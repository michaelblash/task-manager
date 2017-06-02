const pool = require('./postgres_pool');

module.exports = function(record, callback) {
  pool.connect((err, client, done) => {
    if (err) {
      done(err);
      return callback(err);
    }
    client.query(
      `
       INSERT INTO task
        (task_name, task_description, task_priority_id, task_status_id, user_id)
        VALUES ($1, $2, $3, $4, $5) RETURNING user_id
      `,
      [
        record["task-name"], record["task-description"], record["task-priority"],
        record["task-status"], record.user
      ],
      (err, result) => {
        if (err) {
          done(err);
          return callback(err);
        }

        done();
        if (result.rows.length) {
          return callback(null, result.rows[0].user_id);
        }

        callback(new Error("cannot add a new task"));
      }
    );
  });
};
