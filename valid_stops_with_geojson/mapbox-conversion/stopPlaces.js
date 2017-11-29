const readline = require('readline');
const fs = require('fs');
const { writeToFile } = require('./writeToFile');

const writeStopPlaces = () => {
  readStopPlaces('./data/stops.csv', transformer).then(result => {
    console.log('*** Converting data to MapBox data set ****');

    Object.keys(result).forEach(key => {
      // split data set for ONSTREET_BUS due to limit of MapBox' 5 mb limit
      if (key == 'ONSTREET_BUS') {
        for (let number = 1; number < 3; number++) {
          const splitName = key + '-' + number;
          const middle = result[key].length / 2;
          const splitData = number === 1
            ? result[key].slice(0, middle)
            : result[key].slice(middle);

          writeToFile(splitName, splitData);
        }
      } else {
        writeToFile(key, result[key]);
      }
    });
  });
};

const readStopPlaces = (source, lineTransformer) => {
  return new Promise((resolve, reject) => {
    let stopPlaces = {};
    let inputStream = fs.createReadStream(source);
    let skipCount = 0;

    const output = readline.createInterface({
      input: inputStream
    });

    output.on('line', line => {
      let transformed = lineTransformer(line);
      if (transformed) {
        const { stopPlaceType, data } = transformed;
        let stopPlaceData = stopPlaces[stopPlaceType] || [];
        stopPlaceData.push(data);
        stopPlaces[stopPlaceType] = stopPlaceData;
      } else {
        skipCount++;
      }
    });

    inputStream.on('end', () => {
      resolve(stopPlaces, skipCount);
    });

    output.on('error', err => {
      reject(err, skipCount);
    });
  });
};

const transformer = line => {
  const values = line.split(';');
  const id = values[0];
  const name = values[1];
  const stopPlaceType = values[2];
  const geometry = values[3];
  let geoJSON = null;

  if (geometry) {
    let adjustedLitterals = geometry
      .replace('"', '')
      .replace(/"*$/, '')
      .replace(/""/g, '"');
    geoJSON = JSON.parse(adjustedLitterals);
  } else {
    console.warn('Geometry missing for', id);
    return null;
  }

  if (!name) {
    console.warn('Name was empty for stopPlace: ', id);
  }

  const data = {
    type: 'Feature',
    properties: {
      title: name
    },
    geometry: geoJSON
  };

  return {
    stopPlaceType,
    data
  };
};

module.exports = { writeStopPlaces };
