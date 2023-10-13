const router = require('express').Router();
const mallRoutes = require('../modules/Mall/mall.routes');

router.use('/malls', mallRoutes);

module.exports = router;