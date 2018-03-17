const apiRouter = require('express').Router();

apiRouter.route('/')
  .get((req, res) => {
    res.send('"/" GET works');
  })
  .post((req, res) => {
    res.send('"/" POST works');
  });

apiRouter.route('/:id')
  .get((req, res) => {
    res.send(`'/:${req.params.id}' GET works`);
  })
  .put((req, res) => {
    res.send(`'/:${req.params.id}' PUT works`);
  })
  .delete((req, res) => {
    res.send(`'/:${req.params.id}' DELETE works`);
  });


module.exports = apiRouter;
