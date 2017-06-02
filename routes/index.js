const checkPriv = require('../middleware/checkPriv.js');

module.exports = function(app) {
  app.get('/', require('./mainpage').get);
  app.get('/login', require('./login').get);
  app.post('/login', require('./login').post);
  app.get('/register', require('./register').get);
  app.post('/register', require('./register').post);
  app.get('/logout', require('./logout').get);
  app.get('/tasks', checkPriv, require('./tasks').get);
  app.post('/tasks', checkPriv, require('./tasks').post);
};