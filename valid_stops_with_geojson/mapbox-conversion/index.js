const stdio = require('stdio');
const {writeStopPlaces} = require('./stopPlaces');
const {writeParkings} = require('./parkings');

const runTask = type => {
  if (type === 'stops') {
    writeStopPlaces();
  } else if (type === 'parkings') {
    writeParkings();
  } else {
    console.error('Unsupported type', type);
    process.exit(-1);
  }
};

const options = stdio.getopt({
  'type': {key: 't', args: 1, description: 'Type of task. Available are: parking, stops', mandatory: true},
});

const validTaskArgs = ['parkings', 'stops'];

if (!options.type || validTaskArgs.indexOf(options.type) === -1) {
  options.printHelp();
} else {
  runTask(options.type);
}



