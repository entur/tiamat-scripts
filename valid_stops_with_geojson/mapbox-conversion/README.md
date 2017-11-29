# Utility for converting Tiamat SQL dump to MapBox datasets

## How to use

### Convert stop places to GEOJSON

1. Run [valid_stops_with_geojson](https://github.com/entur/tiamat-scripts/blob/master/valid_stops_with_geojson/valid_stops.sql) against Tiamat DB
2. Add `./data/stops.csv` from dump
3. Install dependencies and run utility:
    ```
    yarn install && npm run stops
    ```
4. Destination is `./output/`


### Convert parkings to GEOJSON

1. Run [valid_parkings_with_geojson](https://github.com/entur/tiamat-scripts/blob/master/valid_parkings_with_geojson/valid_parkings.sql) against Tiamat DB
2. Add `./data/parkings.csv` from dump
3. Install dependencies and run utility:
    ```
    yarn install && npm run parkings
    ```
4. Destination is `./output/PARKINGS.json`

