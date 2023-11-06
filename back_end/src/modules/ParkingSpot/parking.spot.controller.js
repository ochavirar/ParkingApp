const ParkingSpot = require('./parking.spot.schema');
const Mall = require('../Mall/mall.schema');
const mqtt = require('../mqtt.handler');

const mqttClient = new mqtt();

mqttClient.connect();

mqttClient.client.subscribe('ParkingSpotUpdate');

const ParkingSpotController = {
    listParkingSpots: function(req, res) {
        ParkingSpot.find({}).
        populate('mall').
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        }) 
    },
    listParkingSpotByID: function(req, res) {
        ParkingSpot.findById(req.params.id).
        populate('mall').
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        })
    },
    uploadParkingSpot: function(req, res) {
        const newParkingSpot = new ParkingSpot({
            mall: req.body.mall,
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
    updateParkingSpotOccupation: function(parkingSpot, req, res) {
        ParkingSpot.findOne(
        {
            floor: parkingSpot.floor,
            row: parkingSpot.row,
            number: parkingSpot.number
        })
        .then(reponse => {
            console.log(reponse);
            const occupied = reponse.occupied;
            if(occupied){
                console.log("Parking spot is occupied");
            } else {
                console.log("Parking spot is not occupied");
            }
        })
        .catch(err => {
            console.log("The parking spot does not existt or you cannot connect to the database");
        });
    }
}

mqttClient.client.on('message', (topic, message) => {
    splitMessage = message.toString().split(',');
    console.log(splitMessage);
    const parkingSpot = {
        floor: Number(splitMessage[0]),
        row: Number(splitMessage[1]),
        number: Number(splitMessage[2]), 
    };
    console.log(parkingSpot);
    ParkingSpotController.updateParkingSpotOccupation(parkingSpot);
});

module.exports = ParkingSpotController;
    