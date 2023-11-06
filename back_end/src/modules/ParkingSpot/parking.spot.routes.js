const express = require('express');
const router = express.Router();
const parkingSpotController = require('./parking.spot.controller');


router.get('/', parkingSpotController.listParkingSpots);
router.post('/', parkingSpotController.uploadParkingSpot);

module.exports = router;