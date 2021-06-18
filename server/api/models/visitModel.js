const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const VisitSchema = new Schema({
    start_visit: {
        type: Date,
    },
    end_visit:{
        type: Date,
    },
    shop:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Shop'
    },
},{
    timestamps: true
});

module.exports = mongoose.model('Visits', VisitSchema);
