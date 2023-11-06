const Mall = require('./mall.schema');
const mqtt = require('../mqtt.handler');

const mqttClient = new mqtt();

mqttClient.connect();

mqttClient.client.subscribe('Mall_Upload');

const MallController = {
    listMalls: function(req, res) {
        Mall.find({}).
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        })
    },
    listMallByID: function(req, res) {
        Mall.findById(req.params.id).
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        })
    },
    createMall: function(req, res) {
        console.log("Req:", req.body);
        const newMall = new Mall({
            name: req.name
        });
        console.log("Obj:", newMall);
        newMall.save().
        then(reponse => {
            console.log(reponse);
            res.status(200).send(reponse);
        }).catch(err => {
            console.log(err);
            res.status(599).send(err);
        })
    },
    updateMall: function(req, res) {
        Mall.findByIdAndUpdate(req.params.id, req.body).
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        })
    },
    deleteMall: function(req, res){
        Mall.findByIdAndDelete(req.params.id).
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        })
    }
};

mqttClient.client.on('message', (topic, message) => {
    const mall = message.toString();
    MallController.createMall(mall);
});

module.exports = MallController;