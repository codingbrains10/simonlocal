import { Case } from "../models/Case.js";
import commonFunction from "../../../utils/common.js";
const createCase = async(req, res) => {
    const { CaseNumber, CaseName, VoucherNumber } = req.body;
 
    try {
        const usercase = await Case.create(CaseNumber, CaseName, VoucherNumber);
        res.status(201).json({ message: "Case Created Successfully!", casedetails: usercase });
    } catch(error) {
        res.status(500).json("Server error");
    }
   
}

const getAllCases = async (req, res) => {
    try {
        const cases = await Case.fetchAll();
        if (cases.length >= 1) {
            res.status(200).json(cases); 
        } else {
            res.status(404).json({ message: "No Cases" });
        }
       
    } catch (error) {
        res.status(500).json("Server Error");
    }
}

const getCase = async (req, res) => {
    const id = req.params.id;
    try {
        const cases = await Case.fetchCase(id);
        if (cases.length >= 1) {
          res.status(200).json(cases);
        } else {
            res.status(404).json({ message: "No Case Found" });
        }
    } catch (err) {
        console.log(err);
        res.status(500).json("Server error");
          }
}

const deleteCase = async (req, res) => {
    const id = req.params.id;
    try {
        await Case.delete(id);
        res.status(200).json({ message: "Case deleted Successfully!!" });
    } catch (err) {
        console.log(err);
        res.status(500).json("Server Error");
    }

    const updateCase = async (req, res) => {
        const id = req.params.id;
        const { CaseNumber, CaseName, VoucherNumber } = req.body;
        try {
            const createcase = Case.update(CaseNumber,CaseName, VoucherNumber)
            res.status(201).json({ message: "Case Updated!!" });
        } catch (err) {
            res.status(500).json("server error", err);
        }
    }
}

export { createCase, getAllCases, deleteCase, getCase };