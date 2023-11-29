--CREATE TABLE

CREATE TABLE animals (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

--ADD NEW COLUMN
ALTER TABLE animals
ADD COLUMN species VARCHAR;
