const moment = require('moment');

const mongoose = require('mongoose'),
    Visit = mongoose.model('Visits');

exports.list_all_visits = function(req, res) {
    Visit.find({}, function(err, task) {
        if (err)
            res.send(err);
        else{
            console.log(moment().format('DD'))
            const data = task.map(obj => ({
                start: moment( obj.start_visit ).format(), end: moment( obj.end_visit ).format(), shop: obj.shop
            }));
            res.json(data);
        }
    });
};

exports.create_a_visit = async (req, res) => {

    // Create a Shop
    let visit = new Visit({
        start_visit: new Date(req.body.start),
        end_visit: new Date(req.body.end),
        shop: req.body.shop
    });

        // Save Visit in the database
        visit
            .save()
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while creating the Shop."
                });
            });
};

exports.read_a_visit = function(req, res) {
    Visit.findById(req.params.visitId, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.update_a_visit = function(req, res) {
    Visit.findOneAndUpdate({_id: req.params.visitId}, req.body, {new: true}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.delete_a_visit = async function (req, res) {

    let visit = await Visit.findOne({_id: req.params.visitId});

    Visit.deleteOne({
        _id: req.params.visitId
    }, function (err, task) {
        if (err)
            res.send(err);
    });
};
