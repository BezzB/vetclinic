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
