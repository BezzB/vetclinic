/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100)
);

create table animals (
   id serial PRIMARY KEY,
   name varchar(255),
   date_of_birth date,
   escape_attempts integer,
   neutered boolean,
   weight_kg decimal
);

ALTER TABLE animals
ADD COLUMN species varchar(255);

CREATE TABLE vets (
    id serial PRIMARY KEY,
    name varchar(255),
    age integer,
    date_of_graduation date
);

CREATE TABLE specializations (
    id serial PRIMARY KEY,
    vet_id integer,
    species_id integer,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    id serial PRIMARY KEY,
    vet_id integer,
    animal_id integer,
    visit_date date,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);
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


CREATE INDEX idx_animal_id ON visits (animal_id);
