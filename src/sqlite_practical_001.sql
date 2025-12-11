-- database: ../runtime/db/starwars.db

-- Practical 1: Databases and Tables
-- Student Name: Wenhao Xu
-- Date: 8/12/25
--
-- This script creates the Star Wars characters database

CREATE TABLE IF NOT EXISTS characters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    species TEXT,
    homeworld TEXT
);

-- Insert Star Wars characters
INSERT INTO characters (name, species, homeworld) VALUES 
('Luke Skywalker', 'Human', 'Tatooine'), 
('Leia Organa', 'Human', 'Alderaan'),
('Han Solo', 'Human', 'Corellia'), 
('Chewbacca', 'Wookiee', 'Kashyyyk'), 
('Obi-Wan Kenobi', 'Human', 'Stewjon'), 
('Darth Vader', 'Human', 'Tatooine'),
('Yoda', 'Yoda''s species', 'Unknown'),
('R2-D2', 'Droid', 'Naboo');

INSERT INTO characters (name, species, homeworld) VALUES
('Jabba the hutt', 'Hutt', 'Nal Hutta'),
('Boba Fett', 'Human', 'Kamino'),
('Mace Windu', 'Human', 'Haruun Kal');



-- Challenge Task

CREATE TABLE IF NOT EXISTS droid (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    model TEXT,
    function TEXT
);

INSERT INTO droid (name, model, function) VALUES
('R2-D2', 'Astromech', 'Repair & Navigation'),
('C-3PO', 'Protocol Droid', 'Translation'),
('BB-8', 'Astromech', 'Reconnaissance');

SELECT * FROM characters, droid
