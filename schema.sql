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

--MODIFY ANIMAL TABLE
-- Modify the animals table
ALTER TABLE animals
  ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY,
  DROP COLUMN species,
  ADD COLUMN species_id INT REFERENCES species(id),
  ADD COLUMN owner_id INT REFERENCES owners(id);
