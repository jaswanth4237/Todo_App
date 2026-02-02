const model = require("../models/todoModels");

const getItems = async (req, res) => {
  try {
    const todos = await model.find();
    res.status(200).json(todos);
  } catch (error) {
    console.error("error", error);
    res.status(500).json({ message: error.message });
  }
};

module.exports = { getItems };
