const ParkingSpot = require('./parking.spot.schema');
const Mall = require('../Mall/mall.schema');
const mqtt = require('../mqtt.handler');
const costController = require('../Costs/cost.controller');

const mqttClient = new mqtt();

mqttClient.connect();

mqttClient.client.subscribe('ParkingSpotUpdatee');

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
            cost: req.body.cost,
            reserved: req.body.reserved
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
        console.log(parkingSpot);
        ParkingSpot.findOne({ // Finds and the updates
            floor: parkingSpot.floor,
            row: parkingSpot.row,
            number: parkingSpot.number
        }).then(response => {
            const spot = response;
            ParkingSpot.findOneAndUpdate({
                    floor: parkingSpot.floor,
                    row: parkingSpot.row,
                    number: parkingSpot.number
                },{
                    occupied: !spot.occupied,
                    startTime: (!spot.occupied) ? Date.now() : spot.startTime,
                    endTime: (spot.occupied) ? Date.now() : spot.endTime,
                    reserved: (spot.occupied && spot.reserved) ? changeReservedStatus() : spot.reserved
                }).then(reponse => {
                    console.log("Updated!");
                    console.log(reponse);
                    if(!response.occupied && !response.reserved){
                        const cost = {
                            user: null,
                            hours: Number( (response.endTime - response.startTime) / 3600000 ),
                            totalPayed: Number(10 * ( (response.endTime - response.startTime) / 3600000 )),
                            start: response.startTime,
                            end: response.endTime,
                            parkingSpot: response._id
                        };
                        costController.createCost(cost);
                    }
                }).catch(err => {
                    console.log(err);
                });
        }).catch(err => {
            console.log("The parking spot does not exist");
        });
    },
    updateParkingSpotReservation: function(req, res) {
        ParkingSpot.findOneAndUpdate({
            floor: req.body.floor,
            row: req.body.row,
            number: req.body.number
        },{
            reserved: true,
            occupied: true,
        }).then(reponse => {
            console.log(reponse);
            res.status(200).send(reponse);
        }).catch(err => {
            console.log(err);
            res.status(500).send(err);
        })
    },
    getFreeParkingSpots: function(req, res) {
        ParkingSpot.find({occupied: false}).
        populate('mall').
        then(reponse => {
            res.status(200).send(reponse);
        }).catch(err => {
            res.status(500).send(err);
        })
    }
}

mqttClient.client.on('message', (topic, message) => {
    splitMessage = message.toString().split(',');
    const parkingSpot = {
        floor: Number(splitMessage[0]),
        row: Number(splitMessage[1]),
        number: Number(splitMessage[2]), 
    };
    ParkingSpotController.updateParkingSpotOccupation(parkingSpot);
});

module.exports = ParkingSpotController;
    