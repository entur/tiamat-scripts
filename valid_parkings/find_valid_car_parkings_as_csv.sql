COPY
  (SELECT p.netex_id,
          p.version,
          pt.parking_vehicle_types,
          p.parent_site_ref
   FROM parking p
   INNER JOIN parking_parking_vehicle_types pt ON p.id = pt.parking_id
   WHERE pt.parking_vehicle_types = 'CAR'
     AND p.from_date <= now()
     AND (p.to_date > now()
          OR p.to_date IS NULL)
   ORDER BY p.netex_id,
            p.version) TO STDOUT WITH csv;
