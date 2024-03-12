import process from "process";
import dotEnv from "dotenv";
import commonFunction from "../utils/common.js";
dotEnv.config();

const apiKeyAuth = (req, res, next) => {
  try {
    const apiKey = req.header("X-API-Key");
    if (!apiKey) {
      return res
        .status(401)
        .json({ message: "Unauthorized. API key is missing." });
    }
    // Decrypting data
    const decryptedText = commonFunction.decrypt(apiKey);

    if (decryptedText !== process.env.API_KEY) {
      return res
        .status(401)
        .json({ message: "Unauthorized. Invalid API key." });
    }

    next();
  } catch (error) {
    console.error("API Key Authentication Error:", error);
    return res.status(401).json({ message: "Unauthorized. Wrong API key." });
  }
};

export default apiKeyAuth;
