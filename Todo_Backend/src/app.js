const express = require("express");
const cors = require("cors");
const getconnection = require("./config/db");
const handle = require("./routes/todoRoutes");
const userRoutes = require("./routes/userRoutes");

const app = express();

// Enable CORS first
app.use(cors());

// Middleware
app.use(express.json());

// Routes
app.use("/todo", handle);
app.use("/user", userRoutes);

app.get("/", (req, res) => {
  res.send("Hello from Express server");
});

// Start server
app.listen(7000, "0.0.0.0", () => {
  console.log("Server is running on port 7000");
  getconnection();
});
