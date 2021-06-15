const mongoose = require('mongoose'),
    Shop = mongoose.model('Shops');

exports.list_all_shops = function(req, res) {
    Shop.find({}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.create_a_shop = async (req, res) => {

    //We check if the mail already exists in database, if so, we ask for another mail
    let shop = await Shop.findOne({siret_number: req.body.siret_number});
    if (shop) return res.status(400).send("Shop with this email already exists");
    else
        // Create a User
        shop = new Shop({
            siret_number:req.body.siret_number,
            name:req.body.name,
            adress_name: req.body.adress_name,
            adress_number: req.body.adress_number,
            zip_code: req.body.zip_code,
            merchant: req.body.merchant,
            type: req.body.type,

        });

    // Save User in the database
    shop
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

exports.read_a_shop = function(req, res) {
    Shop.findById(req.params.shopId, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.update_a_shop = function(req, res) {
    Shop.findOneAndUpdate({_id: req.params.shopId}, req.body, {new: true}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.delete_a_shop = function(req, res) {

    Shop.remove({
        _id: req.params.shopId
    }, function(err, task) {
        if (err)
            res.send(err);
        res.json({ message: 'Shop successfully deleted' });
    });
};
