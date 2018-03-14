UPDATE stop_place
SET public_code = NULL
WHERE id IN
    (SELECT s.id
     FROM stop_place s
     INNER JOIN topographic_place municipality ON s.topographic_place_id = municipality.id
     AND municipality.parent_ref = 'KVE:TopographicPlace:05'
     LEFT JOIN stop_place p ON s.parent_site_ref = p.netex_id
     AND s.parent_site_ref_version = CAST(p.version AS text)
     WHERE ((p.netex_id IS NOT NULL
             AND (p.from_date IS NULL
                  OR p.from_date <= now())
             AND (p.to_date IS NULL
                  OR p.to_date > now())
                  AND p.topographic_place_id IN (select pm.id from topographic_place pm where pm.parent_ref = 'KVE:TopographicPlace:05')
                )
            OR (p.netex_id IS NULL
                AND (s.from_date IS NULL
                     OR s.from_date <= now())
                AND (s.to_date IS NULL
                     OR s.to_date > now())
                AND s.topographic_place_id IN (select pm.id from topographic_place pm where pm.parent_ref = 'KVE:TopographicPlace:05')
                   ))
       AND s.stop_place_type != 'RAIL_STATION');
