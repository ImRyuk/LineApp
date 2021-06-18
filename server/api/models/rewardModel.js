const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const RewardSchema = new Schema({
    name: {
        type: String,
        required: `Please enter the reward's name`
    },
    description: {
        type: String,
        required: `Please enter the description`
    },
    shop:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Shop'
    },
},{
    timestamps: true
});

module.exports = mongoose.model('Rewards', RewardSchema);
