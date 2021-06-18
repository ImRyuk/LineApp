const mongoose = require('mongoose'),
    Reward = mongoose.model('Rewards');


exports.list_all_rewards = function(req, res) {

    Reward.find({}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.create_a_reward = async (req, res) => {
        // Create a Shop
    let reward = new Reward({
        name: req.body.name,
        description: req.body.description,
        shop: req.body.shopId,
    });

        // Save Reward in the database
        reward
            .save()
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while creating the Reward."
                });
            });

};

exports.read_a_reward = function(req, res) {
    Reward.findById(req.params.rewardId, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.update_a_reward = function(req, res) {
    Reward.findOneAndUpdate({_id: req.params.rewardId}, req.body, {new: true}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.delete_a_reward = async function (req, res) {

    Reward.deleteOne({
        _id: req.params.rewardId
    }, function (err, task) {
        if (err)
            res.send(err);
        res.json({message: 'Reward successfully deleted'});
    });
};
