copy (SELECT s.netex_id,
          coalesce(s.name_value,p.name_value),
          s.stop_place_type,
          ST_AsGeoJSON(s.centroid, 6)
   FROM stop_place s
   LEFT JOIN stop_place p ON p.netex_id = s.parent_site_ref
   AND cast(p.version AS text) = s.parent_site_ref_version
   WHERE
     s.parent_stop_place = FALSE
     AND ((p.netex_id IS NOT NULL
           AND (p.from_date IS NULL
                OR p.from_date <= '2017-11-02 01:00:00')
           AND (p.to_date IS NULL
                OR p.to_date > '2017-11-02 01:00:00'))
          OR (p.netex_id IS NULL
              AND (s.from_date IS NULL
                   OR s.from_date <= '2017-11-02 01:00:00')
              AND (s.to_date IS NULL
                   OR s.to_date > '2017-11-02 01:00:00')))
   ORDER BY s.netex_id,
            s.version
) TO '/tmp/test.csv' DELIMITER ';' CSV;
