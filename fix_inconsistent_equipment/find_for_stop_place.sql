SELECT s.id,
       s.netex_id,
       s.version,
       p.version parentversion,
       p.from_date parentfrom,
       p.to_date parentto,
       pe.netex_id penxid,
       pe.version pev,
       ie.netex_id ienxid,
       ie.version iev
FROM stop_place s
LEFT  JOIN stop_place p ON s.parent_site_ref = p.netex_id
  AND s.parent_site_ref_version = cast(p.version AS text)
INNER JOIN installed_equipment_version_structure pe ON pe.id = s.place_equipments_id
INNER JOIN installed_equipment_version_structure_installed_equipment peie on pe.id = peie.place_equipment_id
INNER JOIN installed_equipment_version_structure ie on peie.installed_equipment_id = ie.id
WHERE s.netex_id = 'NSR:StopPlace:58392'
ORDER BY s.version;
