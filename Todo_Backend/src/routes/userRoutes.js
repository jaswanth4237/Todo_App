const express = require("express");     
 
const userCntrl = require("../controllers/userControllers");
const router = express.Router();

router.post("/register", userCntrl.registerUser);
router.post("/signup",userCntrl.signUpUser);

module.exports = router;