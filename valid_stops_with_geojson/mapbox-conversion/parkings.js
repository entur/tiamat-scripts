const readline = require('readline');
const fs = require('fs');
const { writeToFile } = require('./writeToFile');

const writeParkings = () => {
  readParkings('./data/parkings.csv', transformer).then(result => {
    writeToFile('PARKINGS', result);
  });
};

const readParkings = (source, lineTransformer) => {
  return new Promise((resolve, reject) => {
    let parkings = [];
    let inputStream = fs.createReadStream(source);
    let count = 0;

    const output = readline.createInterface({
      input: inputStream
    });

    output.on('line', line => {
      let transformed = lineTransformer(line);
      if (transformed) {
        count++;
        parkings.push(transformed);
      }
    });

    inputStream.on('end', () => {
      console.log(`Wrote ${count} parkings`);
      resolve(parkings);
    });

    output.on('error', err => {
      reject(err);
    });
  });
};

const transformer = line => {
  if (!line) return null;

  const values = line.split(';');
  //const id = values[0];
  const name = values[1];
  const geometry = values[2];
  let adjustedLitterals = geometry
  .replace('"', '')
  .replace(/"*$/, '')
  .replace(/""/g, '"');
  const geoJSON = JSON.parse(adjustedLitterals);

  const data = {
    type: 'Feature',
    properties: {
      title: name
    },
    geometry: geoJSON
  };

  return data;
};

module.exports = { writeParkings };
