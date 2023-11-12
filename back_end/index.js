const express = require('express');
const env = require('dotenv').config();
const cors = require('cors');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const mqtt = require('./src/modules/mqtt.handler');
const routes = require('./src/utils/router');
const bcrypt = require('bcrypt');

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// We use cors to allow cross origin resource sharing between frontend and backend
// This avoids the need of a middleware to handle CORS in every call
app.use(cors());

app.use('/', routes);

app.use('/api', require('./src/utils/router'));

app.get("/", (req, res) => {
    res.send("Ruta default / ");
});

app.get("*", function (req, res) {
    res.send("Pagina no Encontrada!");
});

// MongoDB connection
mongoose
    .connect(process.env.MONGO_URL)
    .then(() => console.log('MongoDB connected'))
    .catch(err => console.log(err));

// Server initialization
const server = app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});