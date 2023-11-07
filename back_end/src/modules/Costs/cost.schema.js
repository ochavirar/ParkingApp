const {Schema, model} = require('mongoose');

const CostSchema = new Schema({
    user: {type: Schema.ObjectId, required: true},
    hours: {type: String, required: true},
    totalPayed: {type: Number, required: true}
});

module.exports = model('Cost', CostSchema);
