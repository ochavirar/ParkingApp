const express = require('express');
const router = express.Router();
const mallController = require('./mall.controller');

router.get('/', mallController.listMalls);
router.get('/:id', mallController.listMallByID);
router.post('/', mallController.createMall);
router.put('/:id', mallController.updateMall);
router.delete('/:id', mallController.deleteMall);

module.exports = router;