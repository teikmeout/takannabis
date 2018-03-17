BEGIN;
-- if you drop the tables in the right order
-- you don't need to drop with cascade
DROP TABLE IF EXISTS entries_strains;
-- entries_strains depends on strains and entries
DROP TABLE IF EXISTS strains;
-- strains is pretty much independent
DROP TABLE IF EXISTS entries;
-- entries depend on users, so first entries
DROP TABLE IF EXISTS users;
-- finally users, depend on no one
COMMIT;

----------------------------------

BEGIN;
\! echo "creating table users..."
CREATE TABLE users (
  id SERIAL NOT NULL PRIMARY KEY,
  uname VARCHAR NOT NULL,
  hash TEXT NOT NULL
);
/* from PSQL docs:
CREATE INDEX constructs an index on the specified column(s) of the specified table.
Indexes are primarily used to enhance database performance (though inappropriate
use can result in slower performance) */
CREATE INDEX userid_idx ON users(id);
\echo ...finished creating users
COMMIT;

----------------------------------

BEGIN;
-- one user can have many entries
\echo creating table entries...
CREATE TABLE entries (
  id SERIAL NOT NULL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  -- ^ every entry is tied to a user
  dated DATE
);
CREATE INDEX idx_entries ON entries(id);
--ALTER TABLE flashcards ADD COLUMN user_id INTEGER REFERENCES users(id);
\echo ...finished creating entries
COMMIT;

----------------------------------

BEGIN;
/*can one have same named strains that are different?
yes
we can later see how strains average between purchases*/
\echo creating table strains...
CREATE TABLE strains (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR,
  type VARCHAR, -- sativa, indica, hybrid
  url TEXT,
  /* in gas chromatography (GC) VS liquid chromatography (LC)
  LC provides a separate read between THC and THCA
  THCA when decarboxylated loses some mass to become active THC
  so here's the fomula of what thc can be calculated with
  THCtotal = (%THCA) x 0.877 + (%THC) */
  thc_total NUMERIC,
  thca NUMERIC,
  thc NUMERIC,
  cbd NUMERIC,
  cbg NUMERIC
);
CREATE INDEX idx_strains ON strains(name);
\echo ...finished creating strains
COMMIT;

--------------------------------

BEGIN;
-- one entry can have many strains
\echo creating table entries_strains...
CREATE TABLE entries_strains (
  entry_id INTEGER NOT NULL REFERENCES entries,
  strains_id INTEGER NOT NULL REFERENCES strains
);
\echo ...finished creating entries_strains
COMMIT;




-- I think I need to put all my alter tables here
-- references
-- ALTER TABLE entries REFERENCES users
