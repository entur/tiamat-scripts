delete from tariff_zone t where t.version != (select max(t2.version) from tariff_zone t2 where t2.netex_id = t.neteX_id) and  t.netex_id =  'RUT:TariffZone:4S';
delete from tariff_zone t where t.version != (select max(t2.version) from tariff_zone t2 where t2.netex_id = t.neteX_id) and  t.netex_id =  'RUT:TariffZone:2S';
delete from tariff_zone t where t.version != (select max(t2.version) from tariff_zone t2 where t2.netex_id = t.neteX_id) and  t.netex_id =  'RUT:TariffZone:3S';
update tariff_zone_ref set ref = 'RUT:TariffZone:2S' where ref = 'RUT:TariffZone:3S';
update tariff_zone set polygon_id = null where netex_id = 'RUT:TariffZone:2S';
update tariff_zone set polygon_id = null where netex_id = 'RUT:TariffZone:4S';
delete from tariff_zone where netex_id = 'RUT:TariffZone:3S';
update tariff_zone set netex_id = 'RUT:TariffZone:3S', name_value = '3S' where netex_id = 'RUT:TariffZone:4S';
update tariff_zone_ref set ref = 'RUT:TariffZone:3S' where ref = 'RUT:TariffZone:4S';


delete from persistable_polygon p where not exists (select p1.id from parking_area p1 where p1.polygon_id = p.id) 
 and not exists (select p1.id from tariff_zone p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from access_space p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from topographic_place p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from boarding_position p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from stop_place p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from road_address p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from equipment_place p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from quay p1 where p1.polygon_id = p.id)
 and not exists (select p1.id from parking p1 where p1.polygon_id = p.id)
;
