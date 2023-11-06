const ParkingSpot = require('./parking.spot.schema');

const mqtt = require('../mqtt.handler');

const mqttClient = new mqtt();

mqttClient.connect();

mqttClient.client.subscribe('ParkingSpotUpdate');

const ParkingSpotController = {
    listParkingSpots: function(req, res) {
        ParkingSpot.find({}).
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        }) 
    },
    listParkingSpotByID: function(req, res) {
        ParkingSpot.findById(req.params.id).
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        })
    },
    uploadParkingSpot: function(req, res) {
        const newParkingSpot = new ParkingSpot({
            //mall: ,
            floor: req.body.floor,
            row: req.body.row,
            number: req.body.number,
            occupied: req.body.occupied,
            startTime: req.body.startTime,
            endTime: req.body.endTime,
            cost: req.body.cost
        });
        newParkingSpot.save().
        then(reponse => {
            console.log(reponse);
            res.status(200).send(reponse);
        }).catch(err => {
            console.log(err);
            res.status(500).send(err);
        })
    }, 
    updateParkingSpotOccupation: function(req, res) {
        ParkingSpot.findOneAndUpdate(
        {
            floor: req.body.floor,
            row: req.body.row,
            number: req.body.number
        },
        req.params.id, req.body)
        .then(reponse => {
            const occupied = reponse.occupied;
            const updatedSpot = reponse.body;
            if(occupied){

            }
            res.status(200).send(reponse);
        })
        .catch(err => {
            res.status(500).send(err);
        });
    }
}

mqttClient.client.on('message', (topic, message) => {
    splitMessage = message.toString().split(',');
    const parkingSpot = new Mall({
        floor: Number(splitMessage[0]),
        row: Number(splitMessage[1]),
        number: Number(splitMessage[2]),        
    });
    ParkingSpotController.uploadParkingSpot(parkingSpot);
});
module.exports = ParkingSpotController;
    