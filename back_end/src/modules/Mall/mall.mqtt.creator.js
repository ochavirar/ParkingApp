const mqtt = require('mqtt');
const protocol = 'mqtt';
const host = process.env.CLOUD_MQTT_HOST;
const mqttPort = process.env.CLOUD_MQTT_PORT;
const env = require('dotenv').config();
const connectionUrl = `${protocol}://${host}:${mqttPort}`;

class MqttClient{
    constructor(){
        this.client = null;
        this.host = `${protocol}://${host}:${mqttPort}`,
        this.username = process.env.CLOUD_MQTT_USER,
        this.password = process.env.CLOUD_MQTT_PASSWORD
    }

    connect(){
        this.client = mqtt.connect(this.host, {
            username: this.username,
            password: this.password
        });

        this.client.on('connect', () => {
            console.log('MQTT client connected');
        });

        this.client.on('error', (err) => {
            console.log(err);
        });
    }

    publishMessage(topic, message){
        this.client.publish(topic, message);
    }

    subscribe(topic){
        this.client.subscribe(topic);
    }
}

module.exports = MqttClient;