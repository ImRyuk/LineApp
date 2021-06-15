const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const UserSchema = new Schema({
    firstname: {
        type: String,
        required: 'Please enter your first name'
    },
    lastname: {
        type: String,
        required: 'Please enter your last name'
    },
    password: {
        type: String,
        required: `Please choose a password`
    },
    mail: {
        type: String,
        unique: true,
        required: `Please enter your mail`
    },
    roles: {
        type: Array,
        default: "ROLE_MERCHANT"
    },
    shops: [
        {type: mongoose.Schema.Types.ObjectId, ref: 'Shop'}
    ]
}, {
    timestamps: true
});

module.exports = mongoose.model('Users', UserSchema);
