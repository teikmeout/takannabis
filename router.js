const router = require('express').Router();

router.use('/api', require('./routes/api'));

module.exports = router;
