const pool = require('./postgres_pool');

module.exports = function(id, callback) {
  pool.connect((err, client, done) => {
    if (err) {
      done(err);
      return callback(err);
    }
    let renderData = {};
    new Promise((resolve, reject) => {
      client.query(
        `
         SELECT user_role_id, user_role_name FROM user_role
         WHERE user_role_id = (SELECT user_role_id FROM user_data WHERE user_id = $1)
        `,
        [id],
        (err, result) => {
          if (err) {
            reject(err);
            return;
          }
          if (result.rows.length) {
            renderData.userRole = result.rows[0].user_role_name;
            resolve(result.rows[0].user_role_id);
          }
          reject();
        });
    })
    .then(response => new Promise((resolve, reject) => {
      let dbReq = `
      SELECT t.task_id, t.task_priority_id, tp.task_priority_name,
       t.task_status_id, ts.task_status_name, t.task_name, t.task_description, u.user_name
       FROM task AS t, task_priority AS tp, task_status AS ts, user_data AS u
       WHERE t.task_priority_id = tp.task_priority_id AND
       t.task_status_id = ts.task_status_id AND
       t.user_id = u.user_id` + (response !== 1 ? ` AND t.user_id = ${id}` : '');
          client.query(dbReq, [], (err, result) => {
            if (err) {
              reject(err);
              return;
            }
            renderData.tasks = result.rows;
            resolve();
          });
    }))
    .then(response => new Promise((resolve, reject) => {
      client.query(
        `
         SELECT task_priority_id, task_priority_name
         FROM task_priority
         ORDER BY task_priority_value
        `,
        [],
        (err, result) => {
          if (err) 
            return reject(err);
          renderData.priorities = result.rows;
          resolve();
        }
      );
    }))
    .then(response => new Promise((resolve, reject) => {
      client.query(
        `
         SELECT task_status_id, task_status_name
         FROM task_status
        `,
        [],
        (err, result) => {
          if (err) 
            return reject(err);
          renderData.statuses = result.rows;
          resolve();
        }
      );
    }))
    .then(response => {
      callback(null, renderData);
      done();
    })
    .catch(error => {
      callback(error);
      done(error);
    });
  });
};
