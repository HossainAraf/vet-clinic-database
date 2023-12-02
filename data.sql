
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    (1, 'Agumon', '2020-02-03', 0, true, 10.23),
    (2, 'Gabumon', '2018-11-15', 2, true, 8),
    (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
    (4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    (5, 'Charmander', '2020-02-08', 0, false, 11),
    (6, 'Plantmon', '2015-11-15', 2, true, 5.7),
    (7, 'Squirtle', '1993-04-02', 3, false, 12.13),
    (8, 'Angemon', '2005-06-12', 1, true, 45),
    (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
    (10, 'Blossom', '1998-10-13', 3, true, 17),
    (11, 'Ditto', '2022-05-14', 4, true, 22);

    --INSERT full-name and age into owners table
    INSERT INTO owners (full_name, age)
    VALUES 
    ('Sam Smith', 34), 
    ('Jennifer Orwell', 19), 
    ('Bob', 45), 
    ('Melodie Pond', 77), 
    ('Dean Winchester', 14), 
    ('Jodie Whittaker', 38);


INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

UPDATE animals
SET owner_id = 
    CASE
        WHEN name = 'Agumon' THEN 1
        WHEN name IN ('Gabumon', 'Pikachu') THEN 2
        WHEN name IN ('Devimon', 'Plantmon') THEN 3
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
        WHEN name IN ('Angemon', 'Boarmon') THEN 5
        ELSE NULL
    END;

    -- INSERT DATA FOR VETS
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');
