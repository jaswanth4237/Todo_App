const model = require("../models/todoModels");

const getdata = async (req, res) => {
  const { title, decription, isPrimary, endDate } = req.body;

  try {
    const Todo = new model({
      title: title,
      decription: decription,          
      isPrimary: isPrimary ?? false,   
      endDate: endDate
    });

    await Todo.save();
    res.status(201).json(Todo);

  } catch (error) {
    console.error("error", error);
    res.status(500).json({ message: error.message });
  }
};

module.exports = { getdata };
