const {Schema, model} = require('mongoose');
const parkingSpot = require('../ParkingSpot/parking.spot.schema');

const CostSchema = new Schema({
    user: {type: Schema.ObjectId || null, required: false},
    hours: {type: Number, required: true},
    totalPayed: {type: Number, required: true},
    start: {type: Date, required: true},
    end: {type: Date, required: true},
    parkingSpot: {type: Schema.ObjectId, ref: "ParkingSpot", required: true},
    date: {type: Date, default: Date.now} 
});

module.exports = model('Cost', CostSchema);
