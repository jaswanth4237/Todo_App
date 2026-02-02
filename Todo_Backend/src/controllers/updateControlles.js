const models =require("../models/todoModels");

const updatebytitle = async (req, res) => {
    try {
        const { id,title,decription } =req.body;
        const todo = await models.findByIdAndUpdate(
            {"_id": id},
            {
            title:title,
            decription:decription,
        });
        res.status(200).json(todo);
    } catch (error) {
        res.status(500).json({message:error.message});
    }
};

module.exports = { updatebytitle };