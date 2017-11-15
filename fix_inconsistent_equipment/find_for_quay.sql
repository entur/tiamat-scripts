SELECT q.id,
       q.netex_id,
       q.version,
       pe.netex_id penxid,
       pe.version pev,
       ie.netex_id ienxid,
       ie.version iev
FROM quay q
INNER JOIN installed_equipment_version_structure pe ON pe.id = q.place_equipments_id
INNER JOIN installed_equipment_version_structure_installed_equipment peie on pe.id = peie.place_equipment_id
INNER JOIN installed_equipment_version_structure ie on peie.installed_equipment_id = ie.id
WHERE q.netex_id = 'NSR:Quay:26684'
ORDER BY q.version;
