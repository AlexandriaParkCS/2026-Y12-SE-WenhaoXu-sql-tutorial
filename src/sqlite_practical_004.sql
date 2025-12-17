-- database: ../runtime/db/starwars.db

-- Practical 4: Aggregation and Grouping
-- Student Name: Wenhao Xu
-- Date: 16/12/25
--
-- This script demonstrates aggregate functions and grouping data

-- Query 1: How many characters in list?
SELECT COUNT(*) FROM characters;

-- Query 2: Count characters w/ recorded height
SELECT COUNT(height) FROM characters;

-- Query 3: Find tallest character's height
SELECT MAX(height) FROM characters;

-- Query 4: Find shortest character's height
SELECT MIN(height) FROM characters;

-- Query 5: Average character height
SELECT AVG(height) FROM characters;

-- Query 6: Add up all character heights
SELECT SUM(height) FROM characters;

-- Query 7; Get multiple stats!
SELECT
    COUNT(*) AS total_characters,
    AVG(height) AS average_height,
    MAX(height) AS tallest,
    MIN(height) AS shortest
FROM characters;

-- Query 8: how many char of each species
SELECT species, COUNT(*) AS character_count
FROM characters
GROUP BY species;

-- Query 9: Find average height for each species
SELECT species, AVG(height) AS average_height
FROM characters
WHERE height IS NOT NULL
GROUP BY species;

-- Query 10: Count characters by homeworld
SELECT homeworld, COUNT(*) AS character_count
FROM characters
GROUP BY homeworld
ORDER BY character_count DESC;


ALTER TABLE characters ADD COLUMN affiliation TEXT;
UPDATE characters SET affiliation = 'Rebel Alliance' WHERE name IN ('Luke Skywalker', 'Leia Organa', 'Han Solo', 'Chewbacca');
UPDATE characters SET affiliation = 'Jedi Order' WHERE name IN ('Obi-Wan Kenobi', 'Yoda');
UPDATE characters SET affiliation = 'Galactic Empire' WHERE name = 'Darth Vader';
UPDATE characters SET affiliation = 'Independent' WHERE name = 'R2-D2';

-- Query 11: Count characters in each affiliation
SELECT affiliation, count(*) AS members
FROM characters
WHERE affiliation IS NOT NULL
GROUP BY affiliation
ORDER BY members DESC;

-- Query 12: Show only species with more than 2 characters
SELECT species, COUNT(*) AS character_count
FROM characters
GROUP BY species
HAVING COUNT(*) > 2;

-- Query 13: Find affiliations wiht more than avg amount of members
SELECT species, COUNT(*) AS member_count
FROM characters
WHERE affiliation IS NOT NULL
GROUP BY affiliation
HAVING COUNT(*) > (SELECT AVG(cnt) FROM (SELECT COUNT() as cnt FROM characters WHERE affiliation IS NOT NULL GROUP BY affiliation));

-- Query 14: count human by homeworld, only showing planets with more than 2+ humans
SELECT homeworld, COUNT(*) AS human_count
FROM characters
WHERE species = 'Human'
GROUP BY homeworld
HAVING COUNT(*) >= 2;

-- Query 15: Count Distinct Species
SELECT COUNT(DISTINCT species) AS unique_species
FROM characters;

-- Query 16: how many different homeworlds?
SELECT COUNT(DISTINCT homeworld) AS unique_homeworlds
FROM characters;


-- PRACTICE EXERCISES
-- Exercise 1: Total height of all characters combined
SELECT SUM(height) AS Total_Height
FROM characters;

-- Exercise 2: count characters from each homeworld alphabetical
SELECT homeworld, COUNT(*) AS character_count
FROM characters
GROUP BY homeworld
ORDER BY homeworld;

-- Exercise 3: average height by affiliation
SELECT affiliation, AVG(height) as average_height
FROM characters
WHERE height IS NOT NULL AND affiliation IS NOT NULL
GROUP BY affiliation;

-- Exercise 4: Homeworlds, EXACTLY 1 CHARACTER
SELECT homeworld, COUNT(*) AS character_count
FROM characters
GROUP BY homeworld
HAVING count(*) = 1;

-- Challenge Problem
-- Which affiliation has the tallest height?
-- But only affiliation with 2 or more members
-- Sort by tallest first

SELECT affiliation, count(*) AS character_count, avg(height) AS average_height
FROM characters
WHERE affiliation IS NOT NULL AND height IS NOT NULL
GROUP BY affiliation
HAVING count(*) >= 2
ORDER BY avg(height) DESC;