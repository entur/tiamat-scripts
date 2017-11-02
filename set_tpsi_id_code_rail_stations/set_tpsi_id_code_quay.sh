#!/bin/bash

set -e

pod=`kubectl get pods | grep tiamatdb-proxy | head -n1 | cut -d '-' -f 1-4 | awk '{print $1}'`
psql="kubectl exec -t $pod -- psql -h tiamatdb-proxy-service postgresql://tiamat:$DB_PASS@/tiamat -qtA -c "
echo "Tiamat proxy pod: $pod"

quaysSql="copy(SELECT qkv.key_values_id, vi.items uicCode, q.id quayId, q.netex_id quayNetexId, q.public_code
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
                AND qkv.key_values_key = 'uicCode'
                AND s.stop_place_type = 'RAIL_STATION'
                AND q.public_code IS NOT NULL
                AND q.public_code != ''
                ORDER BY q.netex_id, q.version, vi.items) TO STDOUT WITH CSV"

$psql "$quaysSql" | tr ',' ' ' | while read line; do

  read kvid uicCode quayId quayNetexId publicCode <<< $line

  echo "Found uicCode $uicCode with publicCode $publicCode. quayId $quayId quay netex_id: $quayNetexId"


  if [ "$publicCode" -lt "10" ]; then
    tpsiIdPostfix="0$publicCode"
  else
    tpsiIdPostfix=$publicCode
  fi

  echo "tpsiIdPostfix: $tpsiIdPostfix"

  tpsiId=$uicCode$tpsiIdPostfix
  tpsiIdKey="tpsiId"
  charlen=${#tpsiId}
  if [ "$charlen" -ne "9" ]; then
    echo "tpsid $tpsiId is not have 9 as length. Will not update"
  else
    sql="select count(*) from quay_key_values where quay_id = $quayId and key_values_key = '$tpsiIdKey'"
    echo $sql
    count=`$psql "copy ($sql) TO STDOUT WITH CSV"`

    if [ "$count" -eq "0" ]; then
      echo "$tpsiIdKey does not already exist. Creating it. Count is $count"
      sql="insert into value(id) values(nextval('hibernate_sequence')) returning id";
      echo $sql;
      keyValuesId=`$psql "copy ($sql) TO STDOUT WITH CSV"`

      sql="insert into quay_key_values(quay_id, key_values_id, key_values_key) values($quayId, $keyValuesId, '$tpsiIdKey')"

      echo $sql;
      $psql "$sql"

      sql="insert into value_items(value_id, items) values($keyValuesId, '"$tpsiId"')"
      echo "$sql"
      $psql "$sql"

      echo "Updated quay $quayNetexId with $tpsiIdKey $tpsiId"
    else
        echo "$tpsiIdKey already exists for quay $quayId"
    fi
  fi

  echo "---------------- iteration ----------------"

done;
