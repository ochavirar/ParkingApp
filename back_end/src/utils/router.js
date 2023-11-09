const router = require('express').Router();
const mallRoutes = require('../modules/Mall/mall.routes');
const parkingSpotRoutes = require('../modules/ParkingSpot/parking.spot.routes');
const costRoutes = require('../modules/Costs/cost.routes');

router.use('/malls', mallRoutes);
router.use('/parkingSpot', parkingSpotRoutes);
router.use('/cost', costRoutes);

module.exports = router;