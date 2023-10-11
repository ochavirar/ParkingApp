const mqtt = require('mqtt');
const express = require('express');
const env = require('dotenv').config();
const cors = require('cors');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const protocol = 'mqtt';
const host = process.env.CLOUD_MQTT_HOST;
const mqttPort = process.env.CLOUD_MQTT_PORT;
const clientId = 'mqttjs_' + Math.random().toString(16).substr(2, 8);

const connectionUrl = `${protocol}://${host}:${mqttPort}`;

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// We use cors to allow cross origin resource sharing between frontend and backend
// This avoids the need of a middleware to handle CORS in every call
app.use(cors());

app.use('/api', require('./src/utils/router'));

app.get("/", (req, res) => {
    res.send("Ruta default / ");
});

app.get("*", function (req, res) {
    res.send("Pagina no Encontrada!");
});

// MQTT client
const client = mqtt.connect(connectionUrl, {
    clientId,
    clean: true,
    connectTimeout: 4000,
    username: process.env.CLOUD_MQTT_USER,
    password: process.env.CLOUD_MQTT_PASSWORD,
    reconnectPeriod: 1000,
});

// Example topic
const topic = '/nodejs/mqtt';

// How to subscribe to a topic
client.on('connect', () => { 
    console.log('Connected to MQTT Broker');
    client.subscribe(topic, { qos: 0 });
});  

client.publish(topic, 'Hello mqtt');

// How to publish a message
client.on('message', (topic, message) => {
    console.log(`Received message on ${topic}: ${message}`);
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