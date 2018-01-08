delete from parking_key_values where parking_id in (select p1.id from parking p1 where p1.version < (select max(p2.version) from parking p2 where p2.netex_id = p1.netex_id));
delete from parking_parking_vehicle_types where parking_id in (select p1.id from parking p1 where p1.version < (select max(p2.version) from parking p2 where p2.netex_id = p1.netex_id));
delete from parking p1 where p1.version < (select max(p2.version) from parking p2 where p2.netex_id = p1.netex_id);
