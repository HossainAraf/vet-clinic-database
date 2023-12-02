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

--animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name AS animal_name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

--who owns the most animals
SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

SELECT a.name AS last_animal_seen
FROM visits v
JOIN animals a ON v.animals_id = a.id
WHERE v.vets_id = 1
ORDER BY v.date_of_visit DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animals_id) AS animals_seen_by_stephanie
FROM visits v
WHERE v.vets_id = 3;

SELECT v.name AS vet_name, COALESCE(specialization_names.name, 'No Specialty') AS specialty_name
FROM vets v
LEFT JOIN (
    SELECT vet_id, STRING_AGG(species_name, ', ') AS name
    FROM (
        SELECT v.id AS vet_id, s.name AS species_name
        FROM vets v
        LEFT JOIN specializations sp ON v.id = sp.vet_id
        LEFT JOIN species s ON sp.species_id = s.id
    ) AS subquery
    GROUP BY vet_id
) AS specialization_names ON v.id = specialization_names.vet_id;

SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animals_id = a.id
WHERE v.vets_id = 3
    AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS most_visited_animal
FROM (
    SELECT animals_id, COUNT(*) AS visit_count
    FROM visits
    GROUP BY animals_id
    ORDER BY visit_count DESC
    LIMIT 1
) AS most_visited
JOIN animals a ON most_visited.animals_id = a.id;

SELECT a.name AS first_visit_animal
FROM visits v
JOIN animals a ON v.animals_id = a.id
WHERE v.vets_id = 2
ORDER BY v.date_of_visit ASC
LIMIT 1;

SELECT a.name AS animal_name, vet.name AS vet_name, v.date_of_visit AS date_of_most_recent_visit
FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets vet ON v.vets_id = vet.id
ORDER BY v.date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) AS visits_with_non_specialist
FROM visits v
LEFT JOIN specializations s ON v.vets_id = s.vet_id AND v.animals_id = s.species_id
WHERE s.species_id IS NULL;

SELECT s.name AS recommended_specialty
FROM (
    SELECT a.species_id, COUNT(*) AS visit_count
    FROM visits v
    JOIN animals a ON v.animals_id = a.id
    WHERE v.vets_id = 2
    GROUP BY a.species_id
    ORDER BY visit_count DESC
    LIMIT 1
) AS most_visited_species
JOIN species s ON most_visited_species.species_id = s.id;