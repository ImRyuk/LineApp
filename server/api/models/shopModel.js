const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const ShopSchema = new Schema({
    verified: {
        type: Boolean,
        default: false
    },
    siret_number: {
        type: "Number",
        required: 'Please enter a valid siret number',
        maxlength: 9,
        minlength: 9,
        unique: true
    },
    name: {
        type: String,
        required: `Please enter the shop's name`
    },
    adress_name: {
        type: String,
        required: `Please enter your address name`
    },
    adress_number: {
        type: String,
        required: `Please enter your address number`
    },
    zip_code: {
        type: Number,
        maxlength: 5,
        required: `Please enter your zip code`
    },
    merchant:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    type:{
      type: String
    },
},{
    timestamps: true
});

module.exports = mongoose.model('Shops', ShopSchema);