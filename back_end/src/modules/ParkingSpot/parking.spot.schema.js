const {Schema, model} = require('mongoose');
const Mall = require('../Mall/mall.schema');

const parkingSpotSchema = new Schema({
    mall: {type: Schema.ObjectId, ref: 'Mall', required: true},
    floor: {type: Number, required: true},
    row: {type: Number, required: true},
    number: {type: Number, required: true},
    occupied: {type: Boolean, required: true},
    startTime: {type: Date, required: true},
    endTime: {type: Date, required: true},
    cost: {type: Number, required: true}
});

module.exports = model('ParkingSpot', parkingSpotSchema);