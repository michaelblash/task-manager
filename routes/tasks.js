const db = require('../db');

exports.get = function(req, res) {
  db.getTasks(req.session.user, function(err, data) {
    if (err) return next(err);
    renderData = {
      role: data.userRole,
      tasks: data.tasks.map(
        v => ({
          taskId: v.task_id,
          task: v.task_name,
          description: v.task_description, 
          priorityId: v.task_priority_id,
          priority: v.task_priority_name,
          statusId: v.task_status_id,
          status: v.task_status_name,
          user: v.user_name
        })
      ),
      priorities: data.priorities.map(
        v => ({
          priorityId: v.task_priority_id,
          priority: v.task_priority_name
        })
      ),
      statuses: data.statuses.map(
        v => ({
          statusId: v.task_status_id,
          status: v.task_status_name
        })
      )
    };

    res.locals.data = renderData;
    res.render('tasks');
  
  });
};


exports.post = function(req, res, next) {
  let record = req.body;
  record.user = res.locals.user;
  if(record["task-id"] > 0) {
    db.update(record, function(err) {
      if (err) return next(err);
      res.send({});
    });
  } else {
    db.add(record, function(err, id) {
      if (err) next(err);
      res.send({ id });
    });
  }
};