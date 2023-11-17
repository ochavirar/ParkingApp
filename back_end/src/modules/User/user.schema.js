const {Schema, model} = require('mongoose');

const UserSchema = new Schema({
    name: {type: String, required: true},
    email: {type: String, required: true},
    password: {type: String, required: true},
    history: {type: Array(Schema.ObjectId), ref: 'Cost', default: []}
});

module.exports = model('User', UserSchema);