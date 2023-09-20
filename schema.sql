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
