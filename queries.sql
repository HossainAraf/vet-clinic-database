/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

--setting the species column to unspecified
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;

--roll back the change and verify that the species columns went back to null
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;
COMMIT;

--Verify that changes persist after commit.
SELECT * FROM animals;

--delete all records in the animals table
BEGIN;
DELETE FROM animals;

--roll back the transaction
ROLLBACK;
--verify all records in the animals table still exists.
SELECT * FROM animals;

-- Start a transaction
BEGIN;
-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT weight_update;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO weight_update;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = ABS(weight_kg)
WHERE weight_kg < 0;

COMMIT;

--number of animals in the table
 SELECT COUNT(*) AS animal_count FROM animals;

 -- number of animals have never tried to escape
 SELECT COUNT (*) AS never_tried_escape FROM animals WHERE escape_attempts =0;

 --average weight of animals
 SELECT AVG(weight_kg) AS avg_weight FROM animals;

 --escapes the most, neutered or not neutered animals
 SELECT neutered, COUNT(*) AS escape_count
 FROM animals
 WHERE escape_attempts > 0
GROUP BY neutered;

--minimum and maximum weight of each type(species) of animal
FROM animals
GROUP BY species;

--average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

--animals belong to Melody Pond
SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Melodie Pond';

--animals that are pokemon
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--animals are there per species
SELECT species.name AS species_name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

--all owners and their animals, remember to include those that don't own any animal
SELECT owners.full_name, animals.name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

--Digimon owned by Jennifer Orwell
SELECT animals.name AS digimon_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

