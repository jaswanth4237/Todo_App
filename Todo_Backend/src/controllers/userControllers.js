const userModel = require("../models/userModels");
const bcrypt = require("bcrypt");

const saltRounds = 12;
//Register Controller
const registerUser = async (req, res) => {
    try{
        const { name, email, password } = req.body;

        const hasedPassword = await bcrypt.hash(password,saltRounds);

        const newUser = new userModel({
            name : name,
            email : email,
            password : hasedPassword,
        });

        await newUser.save();
        res.status(201).json(newUser);
    }
    catch(error){
        console.error("error", error);
        res.status(500).json({message:error.message});
    }

}

//SignUp Controller
const signUpUser = async(req,res)=>{
    try {
        
        const {email,password} = req.body;
        const currentUser =await userModel.findOne({email});

        if(currentUser)
        {
            const isPassword = await bcrypt.compare(password,currentUser.password);
            if(isPassword){
                res.status(200).json(currentUser);
            }
            else{
                res.status(401).json({message:"Invalid Credentials"}); 
            }
        }
        else{
            res.status(404).json({message:"User not found"});
        }
    } catch (error) {
        res.status(500).json({ message:error.message});
        
    }
}

module.exports = { registerUser, signUpUser };