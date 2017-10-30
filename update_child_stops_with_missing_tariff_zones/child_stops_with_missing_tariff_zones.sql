COPY
  (SELECT s.id sid,
          s.netex_id snxid,
          s.version stoppversion,
          s.parent_site_ref parentsiteref,
          tzr2.ref eariertariffzoneref
   FROM stop_place s
   LEFT JOIN stop_place p ON p.netex_id = s.parent_site_ref
   AND cast(p.version AS text) = s.parent_site_ref_version
   LEFT JOIN stop_place_tariff_zones sptz ON s.id = sptz.stop_place_id
   INNER JOIN stop_place s2 ON s2.netex_id = s.netex_id
   AND s2.version < s.version
   INNER JOIN stop_place_tariff_zones sptz2 ON s2.id = sptz2.stop_place_id
   AND sptz2.tariff_zones_id IS NOT NULL
   INNER JOIN tariff_zone_ref tzr2 ON tzr2.id = sptz2.tariff_zones_id
   WHERE sptz.tariff_zones_id IS NULL
     AND s.parent_site_ref IS NOT NULL
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
   GROUP BY s.id,
            s.netex_id,
            s.version,
            s.parent_site_ref,
            tzr2.ref
   ORDER BY s.netex_id,
            s.version) TO STDOUT WITH CSV;
