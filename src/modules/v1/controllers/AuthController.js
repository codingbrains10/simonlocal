import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { User } from "../models/Auth.js";

const signup = async (req, res) => {
  const { password, repeatPassword, email } = req.body;
  if (password !== repeatPassword) {
    return res.status(400).json({ error: "Passwords do not match" });
  }
  try {
    const exists = await User.userExists(email);
    if (exists) {
      return res.status(400).json({ error: "User Already Exists!!" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const userId = await User.createUser(hashedPassword,email);
    res.status(201).json({ message: "Signup Successfull!! ", userId });
  } catch (error) {
    console.error(error.message);
    res.status(500).json({ error: "Server Error" });
  }
};

const login = async (req, res) => {
    const { email, password } = req.body;

  try {
    const user = await User.getUserByEmail(email);
    
    if (!user) {
        return res.status(400).json({ error: "Invalid credentials" });
    }
      
      const isMatch = await bcrypt.compare(password, user.Password);
      
    if (!isMatch) {
      return res.status(400).json({ error: "Invalid credentials" });
    }

    const payload = { user: { id: user.UserID } };
   
    const jwtSecret = process.env.JWT_SECRET || "Ajay123";
    console.log(jwtSecret);
    jwt.sign(payload, jwtSecret, { expiresIn: "1h" }, (err, token) => {
      if (err) throw err;
        res.json({
            token,
            user: {
                name: user.Username,
                email: user.Email,

          },
            message:"Login Successfull!!"
        });
    });
  } catch (error) {
    console.error(error.message);
    res.status(500).json({ error: "Server Error" });
  }
};

const deleteUser = async (req, res) => {
  try {
    const id = req.params.id;
    if (!id) {
      return res.status(404).json({ message: "User ID Not Provided" });
    }

    const userExists = await User.findById(id);
    if (!userExists) {
      return res.status(404).json({ message: "User Not Found" });
    }

    await User.delete(id);
    return res.status(200).json({ message: "User Deleted Successfully" });
  } catch (error) {
    console.error("Error Deleting User", error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};



export { signup, login, deleteUser };
