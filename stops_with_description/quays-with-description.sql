COPY
  ( SELECT q.netex_id,
           q.description_value,
           tp.name_value,
           ST_AsGeoJSON(q.centroid, 6)
   FROM quay q
   INNER JOIN stop_place_quays spq
    ON spq.quays_id = q.id
   INNER JOIN stop_place s
    ON s.id = spq.stop_place_id
    INNER JOIN topographic_place tp
     on tp.id = s.topographic_place_id
   WHERE
    q.version = (select max(qv.version) from quay qv where qv.netex_id = q.netex_id)
     AND q.description_value <> ''
   ORDER BY q.netex_id,
            q.version) TO STDOUT
DELIMITER ';' CSV;
