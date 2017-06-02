const config = require('./config');
const path = require('path');
const fs = require('fs');
const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const morgan = require('morgan');
const app = express();


app.engine('ejs', require('ejs-locals'));
app.set('views', './views');
app.set('view engine', 'ejs');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
  secret: config.cookiePassword,
  resave: false,
  saveUninitialized: true,
  cookie: {
   secure: false,
   maxAge: 1800000,
   httpOnly: false,
   sameSite: false
  }
}));

let accessLogStream = fs.createWriteStream(
  path.join(__dirname, config.logFile),
  {flags: 'a'}
);
app.use(morgan('combined', {stream: accessLogStream}))

app.use(require('./middleware/loadUser'));

require('./routes')(app);
app.use(express.static(path.join(__dirname, 'public')));

app.use(function(err, req, res, next) {
  res.locals.error = err;
  res.statusCode = 400;
  res.render('error');
});

app.listen(3000);