const express = require('express'),
    app = express(),
    port = process.env.PORT || 3000,
    mongoose = require('mongoose'),
    User = require('./api/models/userModel'), //created model loading here
    Shop = require('./api/models/shopModel');
    Reward = require('./api/models/rewardModel');
    Visit = require('./api/models/visitModel');
    bodyParser = require('body-parser');

// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose
    .connect('mongodb+srv://admin-line:AdminLine@cluster0.9tjaf.mongodb.net/LineDatabase?retryWrites=true&w=majority', {
        useNewUrlParser: true,
        useUnifiedTopology: true
    })
    .then(() => {
        console.log("Connected to the database!");
    })
    .catch(err => {
        console.log("Cannot connect to the database!", err);
        process.exit();
    });

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

require("./api/routes/userRoutes")(app);
require('./api/routes/shopRoutes')(app);
require('./api/routes/rewardRoutes')(app);
require('./api/routes/visitRoutes')(app);

app.listen(port);

console.log('APP Line API server started on: ' + port);
