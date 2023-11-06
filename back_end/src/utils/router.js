const router = require('express').Router();
const mallRoutes = require('../modules/Mall/mall.routes');
const parkingSpotRoutes = require('../modules/ParkingSpot/parking.spot.routes');

router.use('/malls', mallRoutes);
router.use('/parkingSpot', parkingSpotRoutes);

module.exports = router;