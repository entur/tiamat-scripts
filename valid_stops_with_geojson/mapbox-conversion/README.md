# Utility for converting Tiamat SQL dump to MapBox datasets

## How to use

1. Run [valid_stops_with_geojson](https://github.com/entur/tiamat-scripts/blob/master/valid_stops_with_geojson/valid_stops.sql) against Tiamat DB
2. Add `./data/nsr.csv` from dump
3. Install dependencies and run utility:
    ```
    yarn install && npm start
    ```
4. Destination is `./output/`

