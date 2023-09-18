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
