const { config, environment, Environment } = require('@rails/webpacker');
// const { resolve } = require('path');
const WebpackerPwa = require('webpacker-pwa');

environment.loaders.delete('nodeModules');
new WebpackerPwa(config, environment);

module.exports = environment
