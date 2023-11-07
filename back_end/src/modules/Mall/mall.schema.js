const {Schema, model} = require('mongoose');

const mallSchema = new Schema({
    name: {type: String, required: true},
    parkingLot: {type: String, required: false},
    visitors: {type: Number, required: false},
});

module.exports = model('Mall', mallSchema);