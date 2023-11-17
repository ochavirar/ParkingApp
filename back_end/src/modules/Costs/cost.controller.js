const {Schema, model} = require('mongoose');
const ParkingSpot = require('../ParkingSpot/parking.spot.schema');
const Cost = require('../Costs/cost.schema');

const CostController = {
    getCosts: function (req, res) {
        Cost.find()
        .populate('parkingSpot')
            .then(response => {
                res.send(response);
            })
            .catch(error => {
                res.send(error);
            });
    },
    createCost: function (data) {
        console.log("Cost data: " + data);
        const newCost = {
            user: (data.user != null) ? data.user : null,
            hours: data.hours,
            totalPayed: data.totalPayed,
            start: data.start,
            end: data.end,
            parkingSpot: data.parkingSpot
        }
        Cost.create(newCost)
            .then(response => {
                console.log(response);
            })
            .catch(error => {
                console.log(error);
            });
    },
    getCostsByUser: function (req, res) {
        Cost.find({ user: req.params.id })
        .populate('parkingSpot')
            .then(response => {
                res.send(response);
            })
            .catch(error => {
                res.send(error);
            });
    }
};

module.exports = CostController;