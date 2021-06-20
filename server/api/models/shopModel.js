const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const geocoder = require('../../utils/geocoder');

const ShopSchema = new Schema({
    verified: {
        type: Boolean,
        default: false
    },
    siret_number: {
        type: "String",
        required: 'Please enter a valid siret number',
        maxlength: 9,
        minlength: 9,
        unique: true
    },
    name: {
        type: String,
        required: [true, `Please enter the shop's name`]
    },
    location:{
        type: {
            type: String,
            enum: ['Point']
        },
        coordinates: {
            type: [Number],
            index: '2dsphere'
        },
        streetName:String,
        streetNumber:String,
        country:String,
        city: String,
        state:String,
        zipcode: String
    },
    adress_name: {
        type: String,
        required: [true, `Please enter your address name`]
    },
    city: {
        type:String,
        required: [true, `Please enter your city`]
    },
    zip_code: {
        type: "String",
        maxlength: 5,
        required: [true, `Please enter your zip code`]

    },
    merchant:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    hours: {
        lundi: {
            type: Array,
            default: []
        },
        mardi: {
            type: Array,
            default: []
        },
        mercredi: {
            type: Array,
            default: []
        },
        jeudi: {
            type: Array,
            default: []
        },
        vendredi: {
            type: Array,
            default: []
        },
        samedi: {
            type: Array,
            default: []
        },
        dimanche: {
            type: Array,
            default: []
        }
    },
    type:{
      type: String
    },
},{
    timestamps: true
});

//Geocode & create location

ShopSchema.pre('save', async function(next){
    const loc = await geocoder.geocode({
        address: this.adress_name,
        zipcode: this.zip_code,
        city: this.city
    });
    this.location = {
        type: 'Point',
        coordinates: [loc[0].latitude, loc[0].longitude],
        streetName:loc[0].streetName,
        streetNumber:loc[0].streetNumber,
        country:loc[0].country,
        city: loc[0].city,
        state:loc[0].state,
        zipcode: loc[0].zipcode
    }

    this.adress_name = undefined;
    this.zip_code = undefined;
    this.city = undefined;
    next();
    console.log(loc);
});

module.exports = mongoose.model('Shops', ShopSchema);
