const pool = require('./postgres_pool');

module.exports = function(record, callback) {
  pool.connect((err, client, done) => {
    if (err) {
      done(err);
      return callback(err);
    }
    client.query(
      `
       UPDATE task
        SET task_name = $1, task_description = $2, task_priority_id = $3,
        task_status_id = $4 WHERE task_id = $5
      `,
      [
        record["task-name"], record["task-description"], record["task-priority"],
        record["task-status"], record["task-id"]
      ],
      (err, result) => {
        if (err) {
          done(err);
          return callback(err);
        }

        done();
        callback();
      }
    );
  });
};
