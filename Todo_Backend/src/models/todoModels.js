const mongooese = require("mongoose");

const todoSchema = new mongooese.Schema({
   title:{
    type:String,
    required:true,
} ,
   decription:{
    type:String,
    required:true,
   },
   isPrimary:{
    type:Boolean,
   },
    endDate: {
        type: String,
        default: ""

    },

});

module.exports = mongooese.model("todo_Schema",todoSchema);