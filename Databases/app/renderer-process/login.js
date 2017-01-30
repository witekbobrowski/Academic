let mysql = require('mysql')

let pool = mysql.createPool({
    host: '',
    user: '',
    password: '',
    database: ''
});

let getConnection = function(cb) {
    pool.getConnection(function(err, connection) {
        if (err) {
            return cb(err)
        }
        cb(null, connection)
    })
}

module.exports = getConnection;

document.getElementById('button-login').addEventListener('click', (event) => {
      let host = document.getElementById('input-login host').value
      let user = document.getElementById('input-login user').value
      let password = document.getElementById('input-login password').value
      let database = document.getElementById('input-login database').value

      pool = mysql.createPool({
        host     : host,
        user     : user,
        password : password,
        database : database
      });

      getConnection = function (cb) {
        pool.getConnection(function (err, connection) {
          if(err) {
            return cb(err)
          }
          cb(null, connection)
        })
      }
      module.exports = getConnection;
})
