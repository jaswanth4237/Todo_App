const userCntrl = require('../controllers/todoControllers');
const express = require('express');
const todoItems = require('../controllers/getControllers');
const updateCtrl = require('../controllers/updateControlles');
const deleteCtrl = require('../controllers/deleteControllers');

const router = express.Router();
 
router.post('/add', userCntrl.getdata);
router.get('/get', todoItems.getItems);
router.post('/update-one-by-title',updateCtrl.updatebytitle);
router.delete('/delete',deleteCtrl.deletebyid);

module.exports = router;