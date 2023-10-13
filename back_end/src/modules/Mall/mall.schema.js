const mqtt = require('../Mall/mall.mqtt.creator');
const {Schema, model} = require('mongoose');

const mallSchema = new Schema({
    name: String,
    parkingLot: String,
    visitors: Number
});

module.exports = model('Mall', mallSchema);