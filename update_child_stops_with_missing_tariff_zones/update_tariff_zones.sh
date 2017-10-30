#!/bin/bash

set -e

pod=`kubectl get pods | grep tiamatdb-proxy | head -n1 | cut -d '-' -f 1-4 | awk '{print $1}'`
psql="kubectl exec -t $pod -- psql -h tiamatdb-proxy-service postgresql://tiamat@/tiamat -qtA -c "
echo "Tiamat proxy pod: $pod"



cat child_stops_without_tariff_zone.csv | tr ',' ' ' | while read line; do
  read sid snid sversion psnid tznid <<< $line;
  echo "stop place primary id: $sid ($snid) should have a reference to tariff zone with netex_id: $tznid";

  sql="insert into tariff_zone_ref(id, ref) values(nextval('tariff_zone_ref_seq'), '$tznid') returning id";

  echo $sql
  tzrid=`$psql "copy ($sql) TO STDOUT WITH CSV"`

  echo "Got tariff zone ref id: $tzrid"

  sql="insert into stop_place_tariff_zones(stop_place_id, tariff_zones_id) values($sid, $tzrid)"

  echo $sql

  $psql "$sql"

  echo "------------end iteration----------------"
  # break;


done;
