const bcrypt = require('bcrypt')

const mongoose = require('mongoose'),
    User = mongoose.model('Users');

function validateEmail(email) {
    const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

exports.list_all_users = function(req, res) {
    User.find({}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.create_a_user = async (req, res) => {

    //Checking is the mail is correct thanks to a REGEX
    if (!validateEmail(req.body.mail)) return res.status(400).send("Invalid Email");

    //We check if the mail already exists in database, if so, we ask for another mail
    let user = await User.findOne({mail: req.body.mail});
    if (user) return res.status(400).send("User with this email already exists");
    else
        // Create a User
        user = new User({
            password:req.body.password,
            mail:req.body.mail,
            firstname: req.body.firstname,
            roles: req.body.roles,
            lastname: req.body.lastname

        });

    //Crypting password
    const salt =  await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password, salt);

    // Save User in the database
    user
        .save()
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while creating the User."
            });
        });
};

exports.login_a_user = async (req, res) => {
    try{
        let user = await User.findOne({mail: req.body.mail});
        if(user){
            const match = await bcrypt.compare(req.body.password, user.password);
            if(match) {
                res.send(user);
            }
            else{
                res.status(500).send({
                    message:
                        "Identifiants incorrects!"
                });
            }
        }
        else
            res.status(500).send({
                message:
                    "Identifiants incorrects!"
            });
    }catch (err){
        res.json({ message: err });
    }

};

exports.read_a_user = function(req, res) {
    User.findById(req.params.userId, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.update_a_user = function(req, res) {
    User.findOneAndUpdate({_id: req.params.userId}, req.body, {new: true}, function(err, task) {
        if (err)
            res.send(err);
        res.json(task);
    });
};

exports.delete_a_user = function(req, res) {

    User.deleteOne({
        _id: req.params.userId
    }, function(err, task) {
        if (err)
            res.send(err);
        res.json({ message: 'User successfully deleted' });
    });
};
