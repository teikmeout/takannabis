const bcrypt = require('bcryptjs');
const db = require('../lib/dbConnect');

// define a recursive method to generate a token
// we need to generate a random string that is unique to our database
// and nearly impossible to replicate
const generateToken = (callback, ...params) => {
  // generate a random number and hash it to create a token
  const token = bcrypt.hashSync(Math.random().toString(), 10);
  // this is returning a promise to make sure the token does not already
  // exist in our database
  return db.oneOrNone('SELECT id FROM users WHERE token = $1', [token])
    .then((res) => { // once we get the response
      if (res) { // if there is a user with that token
        // redo this function and return the result
        return generateToken();
      }
      return callback(...params, token);
    })
    .catch((err) => { // what happens if the DB doesn't work or find it
      console.log(err);
    });
};

// method to update the token on a user
// this will be called each time the user logs in
const updateToken = (id, token) => {
  return db.one(
    `UPDATE users SET token = $1
    WHERE id = $2 RETURNING name, email, token, id`,
    [token, id],
  );
};

  // model method to create a user
const create = (name, email, password, token) => {
  // encrypt the password using bcrypt
  const passwordDigest = bcrypt.hashSync(password, 10);
  // insert the user into the database
  return db.one(
    `INSERT INTO users
    (name, email, password_digest, token)
    VALUES ($1, $2, $3, $4)
    RETURNING name, email, token, id`, // the information we want to send back
    [name, email, passwordDigest, token],
  );
};

// method to find a user given a email
const findByEmail = email => db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);

// method to find a user given a token
// it is using db.one so that if there is not a user, it will throw an error
// we will handle that error in the .catch()
const findByToken = token => db.one('SELECT * FROM users WHERE token = $1', [token]);

module.exports = {
  generateToken,
  updateToken,
  create,
  findByEmail,
  findByToken,
};
