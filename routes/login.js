const db = require('../db');

exports.get = function(req, res) {
  res.render('login');
};


exports.post = function(req, res, next) {
  const user = req.body.username;
  const password = req.body.password;
  db.authorize(user, password, function(err, id) {
    if (err) return next(new Error(403));
    req.session.user = id;
    res.send({});
  });
};