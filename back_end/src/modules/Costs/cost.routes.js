const express = require('express');
const router = express.Router();
const CostController = require('./cost.controller');

router.get('/', CostController.getCosts);
router.get('/:id', CostController.getCostsByUser);
module.exports = router;    