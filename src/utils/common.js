import crypto from "crypto";
import dotenv from "dotenv";
import config from "../config/enviroment.js";
dotenv.config();

/**
 * @description Common function
 */
const commonFunction = {
  /**
   *
   * @param {string} text
   * @returns
   * @description Function to encrypt the data
   */
  encrypt: async (text) => {
    const cipher = crypto.createCipher("aes-256-cbc", process.env.SECRET_KEY);
    let encrypted = cipher.update(text, "utf8", "hex");
    encrypted += cipher.final("hex");
    return encrypted;
  },

  /**
   *
   * @param {string} encryptedText
   * @returns
   * @description Function to decrypt the data
   */
  decrypt: async (encryptedText) => {
    const decipher = crypto.createDecipher(
      "aes-256-cbc",
      config.SECRET_KEY
    );
    let decrypted = decipher.update(encryptedText, "hex", "utf8");
    decrypted += decipher.final("utf8");
    return decrypted;
  },
};

export default commonFunction;
