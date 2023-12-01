--CREATE ANIMAL TABLE

CREATE TABLE animals (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

--ADD NEW COLUMN TO ANIMAL TABLE
ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

--CREATE OWNERS TABLE
CREATE TABLE owners (
  id INT PRIMARY KEY,
  full_name VARCHAR(255),
  age INT
);

--CREATE species TABLE
CREATE TABLE species (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);