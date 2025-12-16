-- database: ../runtime/db/starwars.db

-- Practical 3: Sorting and Limiting Results
-- Student name: Wenhao
-- Date: 15/12/25
--
-- This script demonstrates ORDER BY and LIMIT clauses

ALTER TABLE characters ADD COLUMN height INTEGER;

UPDATE characters SET height = 172 WHERE name = 'Luke Skywalker';
UPDATE characters SET height = 150 WHERE name = 'Leia Organa';
UPDATE characters SET height = 180 WHERE name = 'Han Solo';
UPDATE characters SET height = 228 WHERE name = 'Chewbacca';
UPDATE characters SET height = 182 WHERE name = 'Obi-Wan Kenobi';
UPDATE characters SET height = 202 WHERE name = 'Darth Vader';
UPDATE characters SET height = 66 WHERE name = 'Yoda';
UPDATE characters SET height = 96 WHERE name = 'R2-D2';


-- Query 1: Sort (A-Z)
SELECT name, species, homeworld FROM characters ORDER BY name;

-- Query 2: Sort by Species
SELECT name, species FROM characters ORDER BY species;

-- Query 3: Sort by Height
SELECT name, height FROM characters ORDER BY height;
-- Query 4 and 5: ASC vs DESC
SELECT name, height FROM characters ORDER BY height ASC;
SELECT name, height FROM characters ORDER BY height DESC;

-- Query 6: Sort (Z-A)
SELECT name FROM characters ORDER BY name DESC;

-- Query 7: Sort by species first. then by name within each species
SELECT name, species, homeworld
FROM characters
ORDER BY species, name

-- Query 8: Group by species (A-Z) then height
SELECT name, species, height
FROM characters
ORDER BY species ASC, height DESC;

-- Query 9: Group by homeworld then by species
SELECT homeworld, species, name
FROM characters
ORDER BY homeworld, species;

-- Query 10: View only first 5
SELECT name FROM characters LIMIT 5;

-- Query 11: Find tallest character
SELECT name, height
FROM characters
ORDER BY height DESC
LIMIT 1;

-- Query 12: Find 3 SHORT KINGS
SELECT name, height
FROM characters
ORDER BY height ASC NULLS LAST -- edited :)
LIMIT 3;

-- Query 13:
SELECT name FROM characters ORDER BY name LIMIT 5;

-- Query 14: Get characters 4-8
SELECT name FROM characters ORDER BY name LIMIT 5 OFFSET 3;

-- Query 15: Find tallest human
SELECT name, height, species 
FROM characters 
WHERE species = 'Human' 
ORDER BY height DESC
LIMIT 1;

-- Query 16: Find 3 CHARACTERS not from tatooine by name
SELECT name, homeworld
FROM characters
WHERE homeworld != 'Tatooine'
ORDER BY name
LIMIT 3;

-- Practice Exercises
-- Exercise 1: Find 5 tallest
SELECT name, height
FROM characters
ORDER BY height DESC
LIMIT 5;

-- Exercise 2: Unique Species in Alphabetical
SELECT DISTINCT species
FROM characters
ORDER BY species;

-- Exercise 3: All humans, sorted by height (short ones first)
SELECT name, height
FROM characters
WHERE species = 'Human'
ORDER BY height ASC;

-- Exercise 4: Find the second and third tallest characters
SELECT name, height
FROM characters
ORDER BY height DESC
LIMIT 2 OFFSET 1;

-- CHALLENGE PROBLEMS
-- Characters whose names contain the letter a
-- sorted by height (shortest first)
-- show only second and third results

SELECT name, height
FROM characters
WHERE name LIKE '%a%'
ORDER BY height ASC NULLS LAST 
LIMIT 2 OFFSET 1;
