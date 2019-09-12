const mysql = require('mysql2');
const pool = mysql.createPool({
  connectionLimit : 20,
  host            : '127.0.0.1',
  user            : 'root',
  password        : '123123',
  database        : 'student_target',
  charset         : 'utf8mb4'
})

module.exports = pool.promise()