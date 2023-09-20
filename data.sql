/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, true, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Angemon', '2005-06-12', 1, true, 45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Squirtle', '1993-04-02', 3, false, 12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Plantmon', '2021-11-15', 2, true, 5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, 11);

-- Update animals based on owner information
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

-- Update animals based on their names
UPDATE animals
SET species_id = (
    CASE 
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);

-- Insert Vet William Tatcher
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');

-- Insert Vet Maisy Smith
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');

-- Insert Vet Stephanie Mendez
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');

-- Insert Vet Jack Harkness
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert specialization for Vet William Tatcher (specialized in Pokemon)
INSERT INTO specializations (vet_id, species_id)
VALUES (
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    (SELECT id FROM species WHERE name = 'Pokemon')
);

-- Insert specialization for Vet Stephanie Mendez (specialized in Digimon and Pokemon)
INSERT INTO specializations (vet_id, species_id)
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM species WHERE name = 'Digimon')
);

INSERT INTO specializations (vet_id, species_id)
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM species WHERE name = 'Pokemon')
);

-- Insert specialization for Vet Jack Harkness (specialized in Digimon)
INSERT INTO specializations (vet_id, species_id)
VALUES (
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    (SELECT id FROM species WHERE name = 'Digimon')
);

-- Insert visits data
-- Example: Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES (
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    (SELECT id FROM animals WHERE name = 'Agumon'),
    '2020-05-24'
);

INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM animals WHERE name = 'Agumon'),
    '2020-07-22'
);
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES (
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    '2020-01-05'
);
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES (
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    '2020-03-08'
);
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES (
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    '2020-05-14'
);
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM animals WHERE name = 'Devimon'),
    '2021-05-04'
);
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES (
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    (SELECT id FROM animals WHERE name = 'Charmander'),
    '2021-02-24'
);
