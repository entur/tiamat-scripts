# stops2uic

Python script to create a mapping from stop place and quay ids to uic code.

Usage:

    ./stops2uic.py <input_file> <output_file>


Input file example:

    stop_id,stop_code,stop_name,stop_desc,stop_lat,stop_lon,zone_id,stop_url,location_type,parent_station,wheelchair_boarding,stop_timezone,platform_code,vehicle_type
    NSR:StopPlace:414,,Varhaug,,58.61878,5.64583,,,1,,2,,,700
    NSR:StopPlace:658,,Snartemo stasjon,,58.331738,7.211468,,,1,,2,,,100
    NSR:StopPlace:87,,Skeiane stasjon,,58.847034,5.733579,,,1,,2,,,100
    NSR:Quay:409,,Nelaug stasjon,,58.65728,8.630488,,,0,NSR:StopPlace:250,2,,4,100
    NSR:Quay:413,,Froland stasjon,,58.528877,8.653791,,,0,NSR:StopPlace:251,2,,,700
    NSR:Quay:414,,Nelaug stasjon,,58.657337,8.630584,,,0,NSR:StopPlace:250,2,,2,100
    NSR:Quay:6,,Drangedal stasjon,,59.09621,9.064381,,,0,NSR:StopPlace:1,2,,1,100
    NSR:Quay:415,,Nelaug stasjon,,58.65813,8.62946,,,0,NSR:StopPlace:252,2,,,700
    NSR:Quay:8,,Drangedal stasjon,,59.09618,9.064469,,,0,NSR:StopPlace:1,2,,2,100


Outputs:

    NSR:StopPlace:414,007602220
    NSR:StopPlace:658,007602181
    NSR:StopPlace:87,007612226
    NSR:Quay:409,007602113
    NSR:Quay:413,007602140
    NSR:Quay:414,007602113
    NSR:Quay:6,007602103
    NSR:Quay:415,007602113
    NSR:Quay:8,007602103


Prints information to console when unable to find uic code.



