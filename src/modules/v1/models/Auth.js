import con from "../../../config/db.js";

class User {
  static async userExists(email) {
    const sql = "SELECT * FROM user WHERE email = ?";
    const [rows, fields] = await con.query(sql, [email]);
    return rows.length > 0;
  }

  static async createUser(hashedPassword, email) {
    const sql = "INSERT INTO user (password, email) VALUES (?, ?)";
    const [result] = await con.query(sql, [hashedPassword, email]);
    return result;
  }

  static async getUserByEmail(email) {
    const sql = "SELECT * FROM user WHERE email = ?";
    const [rows, fields] = await con.query(sql, [email]);
    return rows[0];
  }
  static async findById(id) {
    const sql = "SELECT * FROM user WHERE userid = ?";
    const [rows, fields] = await con.query(sql, [id]);
    return rows[0]; 
  }
  static async delete(id) {
    const sql = "DELETE FROM user WHERE userid = ?";
    const [rows, fields] = await con.query(sql, [id]);
    return rows;
  }
}

export { User };
