#!/bin/bash

set -e

pod=`kubectl get pods | grep tiamatdb-proxy | head -n1 | cut -d '-' -f 1-4 | awk '{print $1}'`
psql="kubectl exec -t $pod -- psql -h tiamatdb-proxy-service postgresql://tiamat:$DB_PASS@/tiamat -qtA -c "
echo "Tiamat proxy pod: $pod"



sed 1d MetroQuays.csv | tr ';' ' ' | while read line; do
  read importedId newImportedId <<< $line;

  echo "-------- importedId: $importedId, newImportedId: $newImportedId --------";

  quaysSql="SELECT qkv.key_values_id
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
                  AND vi.items = '$importedId'"

  result=`$psql "copy($quaysSql) to stdout with csv;" | tr ',' ' '`

  read keyvalId <<< $result

  if (( $keyvalId > 0 )); then
     echo "got keyvalid $keyvalId"
     insertSql="insert into value_items (value_id, items) values($keyvalId, '$newImportedId')"
     echo $insertSql
     $psql "$insertSql"
  else
    echo "No match for $importedId"
  fi

done;
