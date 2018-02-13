#!/bin/bash

set -e

pod=`kubectl get pods | grep tiamatdb-proxy | head -n1 | cut -d '-' -f 1-4 | awk '{print $1}'`
psql="kubectl exec -i $pod -- psql -h tiamatdb-proxy-service postgresql://tiamat:$DB_PASS@/tiamat "
echo "Tiamat proxy pod: $pod"

SELECT_FILE=selectIdFile.sql
KEYVAL_FILE=keyvalfile.csv
INSERT_FILE=insertFile.sql

if [ -f $SELECT_FILE ]; then
  echo Deleting old $SELECT_FILE
  rm $SELECT_FILE
fi

if [ -f $INSERT_FILE ]; then
  echo Deleting old $INSERT_FILE
  rm $INSERT_FILE
fi

cat NOPTIS2NSR.txt | tr ';' ' ' | while read -r line; do
  read -r importedId quayId <<< "$line"

  prefixedImportedId="MOR:Quay:$importedId"

  # echo "quayId: $quayId. prefixed imported id: "$prefixedImportedId

  quaysSql="copy(SELECT distinct q.netex_id, qkv.key_values_id, '$prefixedImportedId'
              FROM quay_key_values qkv
                INNER JOIN stop_place_quays spq
                  ON spq.quays_id = qkv.quay_id
                INNER JOIN quay q
                  ON spq.quays_id = q.id
                INNER JOIN stop_place s
                  ON s.id= spq.stop_place_id
                INNER JOIN value_items vi
                  ON qkv.key_values_id = vi.value_id
                LEFT JOIN stop_place p ON s.parent_site_ref = p.netex_id AND s.parent_site_ref_version = CAST(p.version as text)
                WHERE
                  ((p.netex_id IS NOT NULL AND (p.from_date IS NULL OR p.from_date <= now()) AND (p.to_date IS NULL OR p.to_date > now()))
                    OR (p.netex_id IS NULL AND (s.from_date IS NULL OR s.from_date <= now()) AND (s.to_date IS NULL OR s.to_date > now())))
                  AND qkv.key_values_key = 'imported-id'
                  AND q.netex_id = '$quayId') TO STDOUT WITH CSV;";

  echo $quaysSql >> $SELECT_FILE
done

echo "Added "$(wc -l $SELECT_FILE)" select statements to file"
echo "Running all selects"
$psql < $SELECT_FILE > $KEYVAL_FILE

echo "Got "$(cat $KEYVAL_FILE | wc -l)" rows of keyvals in return"

cat $KEYVAL_FILE | tr ',' ' ' | while read -r line; do
  read -r quayId keyvalId importedId <<< $line;

  if [[ -z "${keyvalId// }" ]]
  then
    (>&2 echo "Ignoring quay $quayId, importedId: $importedId because keyvalId is empty ")
  else
    insertSql="insert into value_items(value_id, items) SELECT $keyvalId, '"$importedId"' WHERE NOT EXISTS (SELECT value_id FROM value_items WHERE value_id = $keyvalId AND items = '"$importedId"');"
    echo $insertSql >> $INSERT_FILE
  fi
done

echo "Executing "$(cat $INSERT_FILE | wc -l)" statements"
$psql < $INSERT_FILE
