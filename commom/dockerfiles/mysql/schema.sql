CREATE DATABASE IF NOT EXISTS futlive;

USE futlive;

CREATE TABLE games(
  id VARCHAR(255) PRIMARY KEY,
  date DATETIME NOT NULL
);

INSERT INTO games 
VALUES 
  ("1", now()),
  ("2", now()),
  ("3", now()),
  ("4", now());