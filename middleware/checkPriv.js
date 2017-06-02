
module.exports = function(req, res, next) {
  if (!req.session.user) {
    next(new Error('Unauthorized'));
    return;
  }
  next();
};