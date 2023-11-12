const router = require('express').Router();
const userController = require('./user.controller');

router.get('/', userController.getUsers);
router.post('/', userController.uploadUser);
router.get('/:email', userController.getUserByEmail);

module.exports = router;
    