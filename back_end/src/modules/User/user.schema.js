const {Schema, model} = require('mongoose');

const UserSchema = new Schema({
    name: {type: String, required: true},
    email: {type: String, required: true},
    password: {type: String, required: true},
    history: {type: Schema.ObjectId, ref: 'Cost', required: true}
});

module.exports = model('User', UserSchema);