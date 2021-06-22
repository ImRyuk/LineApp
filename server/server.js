const express = require('express'),
    app = express(),
    port = process.env.PORT || 3000,
    mongoose = require('mongoose'),
    cors = require('cors'),
    bodyParser = require('body-parser');

require('dotenv').config();
require('./api/models/userModel');
require('./api/models/shopModel');
require('./api/models/visitModel');
require('path');

mongoose.Promise = global.Promise;
mongoose
    .connect(process.env.DB_HOST, {
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
app.use(cors());

require("./api/routes/userRoutes")(app);
require('./api/routes/shopRoutes')(app);
require('./api/routes/visitRoutes')(app);

app.listen(process.env.PORT);

console.log('APP Line API server started on: ' + port);
