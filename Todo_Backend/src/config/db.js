const mongooes = require("mongoose");

const getconnection = async () => {
   try {
    await mongooes.connect("mongodb+srv://dbuser11:Jaswanth123@jaswanth.uhninbi.mongodb.net/Todo");
    console.log("Connected to DB Todo");
   } catch (error) {
    console.error("Error while connecting to MongoDB",error);
    
   }
}

module.exports = getconnection;