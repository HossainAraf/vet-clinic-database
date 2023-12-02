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
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(255),
  age INT
);

--CREATE species TABLE
CREATE TABLE species (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255)
);

--MODIFY ANIMAL TABLE
ALTER TABLE animals
DROP COLUMN species,

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

CREATE TABLE vets (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    CONSTRAINT pk_specializations PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    date_of_visit DATE NOT NULL,
    CONSTRAINT pk_visits PRIMARY KEY (animals_id, vets_id, date_of_visit)
);