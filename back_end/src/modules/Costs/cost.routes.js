const express = require('express');
const router = express.Router();
const CostController = require('./cost.controller');

router.get('/', CostController.getCosts);

module.exports = router;    