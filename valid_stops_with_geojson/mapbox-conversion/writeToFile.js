const fs = require('fs');

const writeToFile = (name, data) => {
  const target = './output/' + name + '.json';
  const outerJSON = {
    type: 'FeatureCollection',
    features: data
  };

  console.log("--- Started creating data set for " + name);

  fs.writeFile(target, JSON.stringify(outerJSON), err => {
    if (err) throw err;
    console.log('\t' + name + ' saved to => ' + target);
  });
};

module.exports = {writeToFile};