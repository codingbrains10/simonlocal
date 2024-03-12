import express from 'express';
import { createCase, getAllCases, deleteCase, getCase } from "../controllers/caseController.js";
const router = express.Router();

router.route("/cases").post(createCase).get(getAllCases);
router.route("/cases/:id").delete(deleteCase).get(getCase);

export default router;

