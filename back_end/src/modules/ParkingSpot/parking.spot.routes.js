const express = require('express');
const router = express.Router();
const parkingSpotController = require('./parking.spot.controller');


router.get('/', parkingSpotController.listParkingSpots);
router.get('/free', parkingSpotController.getFreeParkingSpots);
router.post('/', parkingSpotController.uploadParkingSpot);
router.post('/reservation', parkingSpotController.updateParkingSpotReservation);
router.put('/exit', parkingSpotController.checkout);
module.exports = router; 