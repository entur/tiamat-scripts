copy (SELECT s.netex_id,
          coalesce(s.name_value,p.name_value),
          t.netex_id,
          s.weighting
   FROM stop_place s
   INNER JOIN topographic_place t ON t.id = s.topographic_place_id
   LEFT JOIN stop_place p ON p.netex_id = s.parent_site_ref
   AND cast(p.version AS text) = s.parent_site_ref_version
   WHERE
     s.parent_stop_place = FALSE
     AND ((p.netex_id IS NOT NULL
           AND (p.from_date IS NULL
                OR p.from_date <= now())
           AND (p.to_date IS NULL
                OR p.to_date > now()))
          OR (p.netex_id IS NULL
              AND (s.from_date IS NULL
                   OR s.from_date <= now())
              AND (s.to_date IS NULL
                   OR s.to_date > now())))
   ORDER BY s.netex_id,
            s.version
) TO '/tmp/test.csv' DELIMITER ';' CSV;
