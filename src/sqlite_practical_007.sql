-- database: ../runtime/db/starwars.db

-- Practicla 7: Updating and deleting data
-- Student Name: Wenhao Xu
-- Date: 24/12/25


-- Update R2-D2
SELECT id, name, affiliation FROM characters WHERE name = 'R2-D2';

UPDATE characters
SET affiliation = 'Rebel Alliance'
WHERE name = 'R2-D2';

-- Update Multiple Columns
UPDATE characters
SET species = 'Human (Cyborg)',
    affiliation = 'Galactic Empire'
WHERE name = 'Darth Vader';

SELECT name, species, affiliation FROM characters WHERE name = 'Darth Vader';

-- Update All Droids 
UPDATE characters
SET affiliation = 'No Affiliation'
WHERE species = 'Droid';

SELECT name, species, affiliation FROM characters WHERE species = 'Droid';

-- Add 5cm to everyones height (why)
UPDATE characters
SET height = height + 5
WHERE height IS NOT NULL;

SELECT name, height FROM characters ORDER BY height DESC;

-- Update Affiliations based on species
UPDATE characters
SET affiliation = CASE
WHEN species = 'Droid' THEN 'No Affiliation'
WHEN species = 'Wookiee' THEN 'Rebel Alliance'
WHEN species LIKE '%Jedi%' OR name LIKE '%Obi-Wan%' THEN 'Jedi Order'
ELSE affiliation
END;

SELECT name, species, affiliation FROM characters ORDER BY species;

-- Deleting Records
INSERT INTO characters (name, species, homeworld) VALUES ('Temporary', 'Test', 'Nowhere');
SELECT * FROM characters WHERE name = 'Temporary';

DELETE FROM characters
WHERE name = 'Temporary' AND species = 'Test';
-- Worked


-- Delete characters from unknown planets
DELETE FROM characters
WHERE homeworld in (SELECT id FROM planets WHERE name = 'Unknown');

-- Understanding Constraints:
-- Following 2 statements should fail..
-- ..IF not null
INSERT INTO characters (species, homeworld) VALUES ('Human', 'Earth');
-- ..IF check constraint exists
UPDATE characters SET height = -100 WHERE name = 'Yoda';

-- Try to reference character that does not exist
-- Fail if foreign keys are enabled
UPDATE characters
SET homeworld_id = 9999
WHERE name = 'Luke Skywalker';

-- Enable Foreign Keys 
PRAGMA foreign_keys = ON;

-- Transactions
BEGIN Transaction;
UPDATE characters SET affiliation = 'TEST' WHERE species = 'Human';
UPDATE characters SET height = height * 2 WHERE species = 'Human';

SELECT name, affiliation, height FROM characters WHERE species = 'Human';
ROLLBACK;

SELECT name, affiliation, height FROM characters WHERE species = 'Human';
-- Practice EXERCISES
-- EX 1: Safe Update
-- Check
SELECT name, height FROM characters WHERE name = 'Yoda';
UPDATE characters
SET height = height + 10
WHERE name = 'Yoda';
-- Check again
SELECT name, height FROM characters WHERE name = 'Yoda';

-- EX 2: Update from tatooine, affiliation
UPDATE characters
SET affiliation = 'Desert Natives'
WHERE homeworld_id = (SELECT id FROM planets WHERE name = 'Tatooine');
-- verify
SELECT c.name, p.name AS homeworld, c.affiliation
FROM characters c
JOIN planets p ON c.homeworld_id = p.id
WHERE p.name = 'Tatooine';

-- EX 3: Add and delete test character
INSERT INTO characters (name, species, homeworld) VALUES ('Test Delete', 'Test', 'Nowhere');
SELECT * FROM characters WHERE name = 'Test Delete';
DELETE FROM characters WHERE name = 'Test Delete';
