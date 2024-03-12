import con from "../../../config/db.js";

class Case{
    static async create(CaseNumber, CaseName, VoucherNumber) {
        const sql = "INSERT INTO cases (CaseNumber, CaseName, VoucherNumber) VALUES (?,?,?)";
        const [result] = await con.query(sql, [CaseName, CaseNumber, VoucherNumber]);
        return result;
    }
    static async fetchAll() {
        const sql = "SELECT * FROM cases";
        const [rows] = await con.query(sql);
        return rows;
    };


    static async fetchCase(id) {
        const sql = "SELECT * FROM cases WHERE caseid = ?";
        const [row] = await con.query(sql, [id]);
        return row;
        
    };

    static async delete(id) {
        const sql = "DELETE FROM cases WHERE caseid = ?";
        const [result] = await con.query(sql, [id]);
        return result;
    };

    static async update( CaseNumber,CaseName,VoucherNumber, id) {
        const sql = "UPDATE cases SET CaseNumber = ? , CaseName = ?, VoucherNumber = ?";
        const [result] = await con.query(sql, [CaseNumber, CaseName, VoucherNumber, id]);
        return result;
    }
}

export { Case };