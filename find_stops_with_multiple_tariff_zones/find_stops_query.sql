-- Specific prefix
select s.netex_id, count(tzref.ref)
from stop_place s
  inner join stop_place_tariff_zones sptz on s.id = sptz.stop_place_id
  inner join tariff_zone_ref tzref on tzref.id = sptz.tariff_zones_id
where tzref.ref like 'RUT%'
  and s.version = (select max(sv.version) from stop_place sv where sv.netex_id = s.netex_id)
group by s.netex_id having count(tzref.ref) > 1
order by s.netex_id;
