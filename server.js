const dotEnv = require('dotenv').config({silent: true});
const express =  require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const PORT = process.env.PORT || 3000;

const app = express();

app.use(logger('dev'));
app.use(bodyParser.json());

// all routes to router.js
app.use(require('./router'));

app.use('*', (req, res) => {
  res.status(404).json({
    message: 'nope',
  });
});

app.listen(PORT, () => {
  console.log('🍙   on ', PORT, process.env.NODE_ENV);
});

