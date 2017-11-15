SELECT q.id quayid,
       q.netex_id quaynxid,
       q.version qv,
       q2.version q2v,
       pe.netex_id penxid,
       pe2.netex_id pe2nxid,
       pe.version pev,
       pe2.version pe2v,
       ie.netex_id ienxid,
       ie2.netex_id ie2nxid,
       ie.version iev       ,
       ie2.version ie2v
FROM quay q
INNER JOIN installed_equipment_version_structure pe ON pe.id = q.place_equipments_id
INNER JOIN installed_equipment_version_structure_installed_equipment peie on pe.id = peie.place_equipment_id
INNER JOIN installed_equipment_version_structure ie on peie.installed_equipment_id = ie.id
INNER JOIN quay q2
    ON q2.netex_id = q.netex_id AND q2.version = q.version +1
  INNER JOIN installed_equipment_version_structure pe2
    ON pe2.id = q2.place_equipments_id AND pe2.netex_id = pe.netex_id
  INNER JOIN installed_equipment_version_structure_installed_equipment peie2
    ON pe2.id = peie2.place_equipment_id
  INNER JOIN installed_equipment_version_structure ie2
    ON peie2.installed_equipment_id = ie2.id
    AND ie2.netex_id = ie.netex_id
    AND (
      pe2.version = pe.version-1
      OR
      ie2.version = ie.version-1
    )
ORDER BY q.version;
