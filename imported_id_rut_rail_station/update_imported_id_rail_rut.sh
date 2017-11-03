#!/bin/bash

set -e

pod=`kubectl get pods | grep tiamatdb-proxy | head -n1 | cut -d '-' -f 1-4 | awk '{print $1}'`
psql="kubectl exec -t $pod -- psql -h tiamatdb-proxy-service postgresql://tiamat:$DB_PASS@/tiamat -qtA -c "
echo "Tiamat proxy pod: $pod"



sed 1d nsr-mapping.csv | tr ',' ' ' | while read line; do
  read name rutId nsrId <<< $line;

  echo "parsed: $name, rutId: $rutId, nsrId: $nsrId";

  findSql="SELECT skv.key_values_id, s.id
    FROM stop_place_key_values skv
    INNER JOIN stop_place s ON s.id = skv.stop_place_id
    LEFT JOIN stop_place p ON s.parent_site_ref = p.netex_id
    AND s.parent_site_ref_version = CAST(p.version AS text)
    WHERE ((p.netex_id IS NOT NULL
            AND (p.from_date IS NULL
                 OR p.from_date <= now())
            AND (p.to_date IS NULL
                 OR p.to_date > now()))
           OR (p.netex_id IS NULL
               AND (s.from_date IS NULL
                    OR s.from_date <= now())
               AND (s.to_date IS NULL
                    OR s.to_date > now())))
      AND skv.key_values_key = 'imported-id'
      AND s.netex_id = '$nsrId'
    ORDER BY s.netex_id,
             s.version"

  result=`$psql "copy($findSql) to stdout with csv;" | tr ',' ' '`

  read keyvalId stopPlaceId <<< $result

  if (( $keyvalId > 0 )); then
    echo "got keyvalid $keyvalId, stopplaceid: $stopPlaceId"

    deleteSql="delete from value_items where value_id = 6763 and items like 'RUT:StopPlace:%';"
    echo $deleteSql
    result=`$psql "$deleteSql"`
    echo $result

    newImportedId="RUT:StopPlace:$rutId"

    echo "new imported id will be: $newImportedId"

    insertSql="insert into value_items (value_id, items) values($keyvalId, '$newImportedId')"
    echo $insertSql

    result=`$psql "$insertSql"`
    echo $result
  else
    echo "Could not find keyvalId: $keyvalId"
  fi
  echo "---------------- iteration ----------------"

done;
