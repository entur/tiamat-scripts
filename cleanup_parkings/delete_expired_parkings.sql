delete from parking_key_values where parking_id in (select p1.id from parking p1 where p1.to_date < now());
delete from parking_parking_vehicle_types where parking_id in (select p1.id from parking p1 where p1.to_date < now());
delete from parking where to_date < now();
