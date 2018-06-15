UPDATE tariff_zone
SET to_date=now(), version_comment = 'ROR-395 Terminating old versions manually'
WHERE id IN
(
    SELECT tz.id
    FROM tariff_zone tz
    WHERE tz.version < (
        SELECT MAX(tz2.version)
        FROM tariff_zone tz2
        WHERE tz2.netex_id = tz.netex_id
    )
    AND tz.to_date IS NOT NULL
)