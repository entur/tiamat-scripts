COPY
  (SELECT p.netex_id,
          p.name_value,
          ST_AsGeoJSON(p.centroid, 6)
   FROM parking p
   WHERE (p.from_date IS NULL
          OR p.from_date <= '2017-11-28 01:00:00')
     AND (p.to_date IS NULL
          OR p.to_date > '2017-11-28 01:00:00')
     AND p.version = (select max(pv.version) from parking pv where pv.netex_id = p.netex_id)
ORDER BY p.netex_id,
         p.version ) TO STDOUT WITH DELIMITER ';' CSV;
