#!/bin/bash

set -e

pod=`kubectl get pods | grep tiamatdb-proxy | head -n1 | cut -d '-' -f 1-4 | awk '{print $1}'`
psql="kubectl exec -t $pod -- psql -h tiamatdb-proxy-service postgresql://tiamat:$DB_PASS@/tiamat -qtA -c "
echo "Tiamat proxy pod: $pod"

stopPlacesSql="copy(SELECT skv.key_values_id, vi.items uicCode, s.id stopPlaceId, s.netex_id
                FROM stop_place_key_values skv
                  INNER JOIN stop_place s
                    ON s.id = skv.stop_place_id
                  INNER JOIN value_items vi
                    ON skv.key_values_id = vi.value_id
                  LEFT JOIN stop_place p ON s.parent_site_ref = p.netex_id AND s.parent_site_ref_version = CAST(p.version as text)
                WHERE
                ((p.netex_id IS NOT NULL AND (p.from_date IS NULL OR p.from_date <= now()) AND (p.to_date IS NULL OR p.to_date > now()))
                  OR (p.netex_id IS NULL AND (s.from_date IS NULL OR s.from_date <= now()) AND (s.to_date IS NULL OR s.to_date > now())))
                AND skv.key_values_key = 'uicCode'
                AND s.stop_place_type = 'RAIL_STATION'
                ORDER BY s.netex_id, s.version, vi.items
                ) TO STDOUT WITH CSV"

$psql "$stopPlacesSql" | tr ',' ' ' | while read line; do

  read kvid uicCode stopPlaceId stopPlaceNetexId <<< $line

  echo "Found uicCode $uicCode for stopPlaceId $stopPlaceId stopPlaceNetexId: $stopPlaceNetexId"

  tpsiId="00$uicCode"
  tpsiIdKey="tpsiId"
  charlen=${#tpsiId}
  if [ "$charlen" -ne "9" ]; then
    echo "tpsid $tpsiId is not have 9 as length. Will not update"
  else
    sql="select count(*) from stop_place_key_values where stop_place_id = $stopPlaceId and key_values_key = '$tpsiIdKey'"
    echo $sql
    count=`$psql "copy ($sql) TO STDOUT WITH CSV"`

    if [ "$count" -eq "0" ]; then
      echo "$tpsiIdKey does not already exist. Creating it. Count is $count"
      sql="insert into value(id) values(nextval('hibernate_sequence')) returning id";
      echo $sql;
      keyValuesId=`$psql "copy ($sql) TO STDOUT WITH CSV"`

      sql="insert into stop_place_key_values(stop_place_id, key_values_id, key_values_key) values($stopPlaceId, $keyValuesId, '$tpsiIdKey')"

      echo $sql;
      $psql "$sql"

      sql="insert into value_items(value_id, items) values($keyValuesId, '"$tpsiId"')"
      echo "$sql"
      $psql "$sql"

      echo "Updated stopPlace $stopPlaceNetexId with $tpsiIdKey $tpsiId"
    else
        echo "$tpsiIdKey already exists for stopPlace $stopPlaceId"
    fi
  fi

  echo "---------------- iteration ----------------"

done;
