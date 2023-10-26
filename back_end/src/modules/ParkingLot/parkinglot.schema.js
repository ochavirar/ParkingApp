const mqtt = require('../Mall/mall.mqtt.creator');
const {Schema, model} = require('mongoose');

const ParkignLotSchema = new Schema({
    name: {type: String, required: true},
    freeParkingSpots: [{type: ObjectId, ref: 'ParkingSpots'}],
    occupiedParkingSpots: [{type: ObjectId, ref: 'ParkingSpots'}],
});

module.exports = model('ParkingLot', ParkignLotSchema);