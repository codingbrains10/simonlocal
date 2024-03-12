// Get the client
import mysql from "mysql2/promise";
import dotenv from "dotenv";
import config from "./enviroment.js";
dotenv.config();

// Create the connection to database
const createConnectionPool = async () => {
  try {
    const pool = mysql.createPool(config.DATABASE_CONFIGURATION);
    pool.getConnection((err, connection) => {
      if (err) {
        console.log("unable to connect", err);
        if (err.code === "PROTOCOL_CONNECTION_LOST") {
          console.error("Database connection was closed.");
        }
        if (err.code === "ER_CON_COUNT_ERROR") {
          console.error("Database has too many connections.");
        }
        if (err.code === "ECONNREFUSED") {
          console.error("Database connection was refused.");
        }
        if (err.code === "ER_BAD_DB_ERROR") {
          console.error("Database does not exist.");
        }
      }
      if (connection) {
        console.log("Connected to Mysql Database");
        connection.release();
      }
    });
 
    return pool;
  
  } catch (error) {
    console.error("Error creating database connection pool:", error);
    throw error;
  }
};

const con = await createConnectionPool();

export default con;
