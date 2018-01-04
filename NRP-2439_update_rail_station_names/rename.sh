#!/bin/bash

sed 1d rename_rail_station_names.csv | while read line; do
  id=$(echo $line | cut -d';' -f1)
  newname=$(echo $line | cut -d';' -f3)
  echo "update stop_place s set name_value='$newname' where s.netex_id = '$id' and s.version = (select max(sv.version) from stop_place sv where sv.netex_id = s.netex_id);"
done
