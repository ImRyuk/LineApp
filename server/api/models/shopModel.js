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
    phone_number:{
        type: "String",
    },
    description:{
      type: "String"
    },
    merchant:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    hours: {
        monday: {
            type: Array,
            default: []
        },
        tuesday: {
            type: Array,
            default: []
        },
        wednesday: {
            type: Array,
            default: []
        },
        thursday: {
            type: Array,
            default: []
        },
        friday: {
            type: Array,
            default: []
        },
        saturday: {
            type: Array,
            default: []
        },
        sunday: {
            type: Array,
            default: []
        }
    },
    type:{
      type: String
    },
    reward:{
        type: String,
        default: ''
    }
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
