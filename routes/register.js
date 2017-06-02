const db = require('../db');

exports.get = function(req, res) {
  res.render('register');
};


exports.post = function(req, res, next) {
  const user = req.body.username;
  const password = req.body.password;
  db.signUp(user, password, function(err, id) {
    if (err) return next(new Error(400));
    req.session.user = id;
    res.send({});
  });
};