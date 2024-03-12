import express from "express";
import bodyParser from "body-parser";
import config from "./src/config/enviroment.js";
// import authenticate from "./src/middleware/authenticate.js";
import verifyToken from "./src/middleware/authenticate.js";
import apiKeyAuth from "./src/middleware/apiKeyAuth.js";
import con from "./src/config/db.js";
import authRouter from "./src/modules/v1/routes/auth.js";
import caseRouter from "./src/modules/v1/routes/case.js";
import cors from "cors";
// Create the express app
const app = express();
app.use(cors());
const PORT = config.PORT || 3000;

app.use(bodyParser.json());

// Middleware for API request
// app.use(apiKeyAuth);
// make a index route and return hello world
app.get("/", async (req, res) => {
  try {
    // use async await to fetch data from role table
    const [rows, fields] = await con.query("SELECT * FROM role");
    console.log(rows); // rows contains the rows
    // Send the response after fetching data
    res.send({ message: "DataTable", data: rows });
  } catch (error) {
    // Handle any errors
    console.error("Error fetching data:", error);
    res.status(500).send("Internal Server Error");
  }
});


// Error handling middleware
// app.use((err, req, res, next) => {
//   console.error(err.stack);
//   res.status(500).send("Something went wrong!");
// });



app.use("/api/v1", authRouter);
app.use("/api/v1", verifyToken, caseRouter);
// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
