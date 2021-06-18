const mongoose = require('mongoose'),
    Shop = mongoose.model('Shops');
const User = mongoose.model('Users');


exports.list_all_shops = function(req, res) {
    Shop.find({}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.create_a_shop = async (req, res) => {

    //We check if the shop's siret already exists in database, if so, we ask for another siret
    let shop = await Shop.findOne({siret_number: req.body.siret_number});
    if (shop) return res.status(400).send("Shop with this siret already exists");
    else{
        let user = await User.findOne({ _id: req.body.merchant });
        if (!user) return res.status(400).send("User id doesnt exists!");
        // Create a Shop
        shop = new Shop({
            siret_number:req.body.siret_number,
            name:req.body.name,
            adress_name: req.body.adress_name,
            adress_number: req.body.adress_number,
            zip_code: req.body.zip_code,
            merchant: req.body.merchant,
            type: req.body.type,
            verified: req.body.verified
        });

        user.shops.push(shop);
        await User.findByIdAndUpdate(user._id, {shops: user.shops});

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
    }
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

exports.delete_a_shop = async function (req, res) {

    let shop = await Shop.findOne({_id: req.params.shopId});

    Shop.deleteOne({
        _id: req.params.shopId
    }, function (err, task) {
        if (err)
            res.send(err);
        //Removing the shop from the user's shop
        User.findOneAndUpdate({_id: shop.merchant}, {$pull: {shops: shop._id }}, {new: true}, function(err, task) {
            if (err)
                res.send(err);
            res.json({message: 'Shop successfully deleted'});
        });
    });
};

exports.search_shops = function(req, res) {
    Shop.find({"$or": [ { name : { $regex: req.params.searchString }}]},function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};
