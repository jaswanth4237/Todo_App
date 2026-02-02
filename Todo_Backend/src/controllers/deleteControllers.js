const models = require("../models/todoModels");
const deletebyid = async(req,res)=>{
    try {
        const {id} = req.body;
        const todo =await models.findByIdAndDelete({"_id":id});
        res.status(200).json(todo);
    } catch (error) {
        res.status(500).json({message:error.message});
        
    }
}

module.exports={deletebyid};
