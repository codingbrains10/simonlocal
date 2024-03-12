import express from 'express';
const router = express.Router();
import { signup, login, deleteUser } from "../controllers/AuthController.js";


router.route("/signup").post(signup);
router.route("/login").post(login);
router.route("/delete-user/:id").delete(deleteUser);

export default router;