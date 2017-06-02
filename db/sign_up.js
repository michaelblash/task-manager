const pool = require('./postgres_pool');

module.exports = function(username, password, callback) {
  pool.connect((err, client, done) => {
    if (err) {
      done(err);
      return callback(err);
    }
    client.query(
      `
       INSERT INTO user_data (user_name, user_password, user_role_id)
       VALUES ($1, $2, 2) RETURNING user_id
      `,
      [username, password],
      (err, result) => {
        if (err) {
          done(err);
          if (err.code == 23505) {
            return callback(new Error('Username already exists'));
          }
          return callback(err);
        }
        rows = result.rows;
        done();

        if (rows.length) 
          return callback(null, rows[0].user_id);

        callback(new Error('Cannot create a new user'));
      }
    );
  });
};
