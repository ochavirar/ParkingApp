const Mall = require('./mall.schema');
const mqtt = require('./mall.mqtt.creator');

const mqttClient = new mqtt();

mqttClient.connect();

mqttClient.client.subscribe('Punto_Sur');

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
        console.log("Req:", req);
        const newMall = new Mall({
            name: req.name,
            parkingLot: req.parkingLot,
            visitors: req.visitors
        });
        console.log("Obj:", newMall);
        newMall.save().
        then(reponse => {
            console.log(reponse);
        }).catch(err => {
            console.log(err);
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
    splitMessage = message.toString().split(',');
    const mall = new Mall({
        name: splitMessage[0],
        parkingLot: splitMessage[1],
        visitors: splitMessage[2]
    });
    MallController.createMall(mall);
});

module.exports = MallController;