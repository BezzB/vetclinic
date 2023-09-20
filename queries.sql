/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
SELECT *
FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

SELECT *
FROM animals
WHERE name != 'Gabumon';

SELECT *
FROM animals
WHERE neutered = true;

SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

SELECT name
FROM animals
WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

SELECT * FROM animals
WHERE name LIKE '%mon';
SAVEPOINT my_savepoint;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT COUNT(*) FROM animals;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC;

SELECT AVG(weight_kg) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT COUNT(*) FROM animals;

UPDATE animals
SET species = 'unspecified';
SELECT species from animals;
ROLLBACK;
SELECT species from animals;

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

ALTER TABLE animals
ADD COLUMN owner_id integer;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN species_id integer;

CREATE TABLE species (
    id serial PRIMARY KEY,
    name varchar(255)
);

CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name varchar(255),
    age integer
);

-- Insert Pokemon
INSERT INTO species (name)
VALUES ('Pokemon');

-- Insert Digimon
INSERT INTO species (name)
VALUES ('Digimon');

-- Insert Sam Smith
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);

-- Insert Jennifer Orwell
INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);

-- Insert Bob
INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);

-- Insert Melody Pond
INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);

-- Insert Dean Winchester
INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);

-- Insert Jodie Whittaker
INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker', 38);

SELECT a.name
FROM animals a
INNER JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, COALESCE(array_agg(a.name), '{}') AS owned_animals
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name;

SELECT s.name AS species_name, COUNT(*) AS total_animals
FROM animals a
INNER JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
INNER JOIN owners o ON a.owner_id = o.id
INNER JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name
FROM animals a
INNER JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.id) AS total_animals_owned
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY total_animals_owned DESC
LIMIT 1;

SELECT s.specialty_name AS suggested_specialty, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets ve ON v.vet_id = ve.id
JOIN specializations s ON ve.id = s.vet_id AND a.species_id = s.species_id
WHERE ve.name = 'Maisy Smith'
GROUP BY s.specialty_name
ORDER BY visit_count DESC
LIMIT 1;

SELECT s.name AS suggested_specialty, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets ve ON v.vet_id = ve.id
JOIN specializations s ON ve.id = s.vet_id AND a.species_id = s.species_id
WHERE ve.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT COUNT(*) AS num_visits_without_specialization
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets ve ON v.vet_id = ve.id
LEFT JOIN specializations s ON ve.id = s.vet_id AND a.species_id = s.species_id
WHERE s.species_id IS NULL;

SELECT a.name AS animal_name, v2.visit_date AS most_recent_visit_date, v2.vet_id, v3.name AS vet_name
FROM (
    SELECT animal_id, MAX(visit_date) AS most_recent_visit_date
    FROM visits
    GROUP BY animal_id
) AS v1
JOIN visits v2 ON v1.animal_id = v2.animal_id AND v1.most_recent_visit_date = v2.visit_date
JOIN animals a ON v1.animal_id = a.id
JOIN vets v3 ON v2.vet_id = v3.id;

SELECT a.name AS first_visit_animal
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY v.visit_date ASC
LIMIT 1;

SELECT a.name AS animal_name, COUNT(v.id) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
  AND v.visit_date >= '2020-04-01' 
  AND v.visit_date <= '2020-08-30';

SELECT
    v.name AS vet_name,
    COALESCE(s.name, 'No Specialty') AS specialty
FROM vets v
LEFT JOIN specializations s ON v.id = s.vet_id;

SELECT COUNT(DISTINCT v.animal_id) AS num_animals_seen
FROM visits v
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT a.name AS last_animal_seen
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY v.visit_date DESC
LIMIT 1;

