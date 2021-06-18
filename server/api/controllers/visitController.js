const mongoose = require('mongoose'),
    Visit = mongoose.model('Visits');


exports.list_all_visits = function(req, res) {
    Visit.find({}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.create_a_visit = async (req, res) => {

        // Create a Shop
    let visit = new Visit({
        siret_number: req.body.siret_number,
        name: req.body.name,
        adress_name: req.body.adress_name,
        adress_number: req.body.adress_number,
        zip_code: req.body.zip_code,
        merchant: req.body.merchant,
        type: req.body.type,
        verified: req.body.verified
    });

        // Save User in the database
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

    let shop = await Visit.findOne({_id: req.params.visitId});

    Visit.deleteOne({
        _id: req.params.visitId
    }, function (err, task) {
        if (err)
            res.send(err);
    });
};
