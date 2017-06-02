const pool = require('./postgres_pool');

module.exports = function(username, password, callback) {
  pool.connect((err, client, done) => {
    if (err) {
      done(err);
      return callback(err);
    }
    client.query(
      `select user_id, user_password from user_data where user_name=$1`,
      [username],
      (err, result) => {
        if (err) {
          done(err);
          return callback(err);
        }
        rows = result.rows;
        done();

        if (rows.length) {
          if (rows[0].user_password === password) {
            return callback(null, rows[0].user_id);
          }

          return callback(new Error('Password is invalid'));
        }

        callback(new Error('No such a user'));
      }
    ); 
  });
};