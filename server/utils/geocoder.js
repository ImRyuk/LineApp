const NodeGeocoder = require('node-geocoder');
require('dotenv').config();

const options = {
    provider: process.env.API_PROVIDER,
    apiKey: process.env.API_KEY,
    formatter: null
};

const geocoder = NodeGeocoder(options);

module.exports = geocoder;
