UPDATE tariff_zone
SET to_date=now() - interval '1 day'
WHERE id IN
(
    SELECT tz.id
    FROM tariff_zone tz
    WHERE tz.version < (
        SELECT MAX(tz2.version)
        FROM tariff_zone tz2
        WHERE tz2.netex_id = tz.netex_id
    )

)