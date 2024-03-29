COPY
  ( SELECT s.netex_id,
           s.description_value,
           p.description_value,
           s.stop_place_type,
           s.parent_site_ref,
           ST_AsGeoJSON(s.centroid, 6) stopCoordinate
   FROM stop_place s
   LEFT JOIN stop_place p ON p.netex_id = s.parent_site_ref
   AND cast(p.version AS text) = s.parent_site_ref_version
   WHERE ((p.netex_id IS NOT NULL
           AND (p.from_date IS NULL
                OR p.from_date <= now())
           AND (p.to_date IS NULL
                OR p.to_date > now()))
          OR (p.netex_id IS NULL
              AND (s.from_date IS NULL
                   OR s.from_date <= now())
              AND ( s.to_date IS NULL
                   OR s.to_date > now()) ) )
     AND s.description_value <> ''
   ORDER BY s.netex_id,
            s.version) TO STDOUT
DELIMITER ';' CSV;
