DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS entries;
DROP TABLE IF EXISTS strains;

CREATE TABLE users (
  id SERIAL NOT NULL PRIMARY KEY,
  uname VARCHAR NOT NULL,
  hash TEXT NOT NULL
);

-- one user can have many entries
CREATE TABLE entries (
  id SERIAL NOT NULL PRIMARY KEY,
  user_id INTEGER REFERENCES users,
  -- ^ every entry is tied to a user
  dated DATE DEFAULT CURRENT_DATE,
);

-- one entry can have many strains
CREATE TABLE entries_strains (
  entry_id INTEGER NOT NULL REFERENCES entries,
  strains_id INTEGER NOT NULL REFERENCES strains
);

-- can one have same named strains that are different?
-- yes
-- we can later see how strains average between purchases
CREATE TABLE strains (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR,
  type VARCHAR, -- sativa, indica, hybrid
  url TEXT,
  -- in gas chromatography (GC) VS liquid chromatography (LC)
  -- LC provides a separate read between THC and THCA
  -- THCA when decarboxylated loses some mass to become active THC
  -- so here's the fomula of what thc can be calculated with
  -- THCtotal = (%THCA) x 0.877 + (%THC)
  thc_total NUMERIC,
  thca NUMERIC,
  thc NUMERIC,
  cbd NUMERIC,
  cbg NUMERIC,
);
