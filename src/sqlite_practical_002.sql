-- database: ../runtime/db/starwars.db

-- Practical 2: Selecting and Filtering Data
-- Student name: Wenhao Xu
-- Date: 10/12/25

-- EXAMPLE QUERIES
-- Query 1
SELECT * FROM characters;
-- Query 2
SELECT name, species FROM characters;
-- Query 3
SELECT homeworld, species, name FROM characters;


-- Query 4: Find all human characters
SELECT * FROM characters WHERE species = 'Human';

-- Query 5: Find all characters from a specific planet
SELECT * FROM characters WHERE homeworld = 'Tatooine';

-- Query 6: Find characters not human
SELECT * FROM characters WHERE species != 'Human';

-- Query 7: Find humans from tatooine
SELECT name, species, homeworld
FROM characters
WHERE species = 'Human' AND homeworld = 'Tatooine';

-- Query 8: Find characters who are droid or from Naboo
SELECT name, species, homeworld
FROM characters
WHERE species = 'Droid' OR homeworld = 'Naboo';

-- Query 9: From Tatooine or Alderaan
SELECT name, species, homeworld
FROM characters
WHERE species = 'Human' AND (homeworld = 'Tatooine' OR homeworld = 'Alderaan');

-- Query 10: all characters that start with l
SELECT name FROM characters WHERE name LIKE 'L%';

-- Query 11: all characters that end with o
SELECT name FROM characters WHERE name LIKE '%o';

-- Query 12: name like darth
SELECT name FROM characters WHERE name LIKE '%Darth%';

-- Query 13: Find all species containing 'oid'
SELECT DISTINCT name FROM characters WHERE species LIKE '%oid%';

-- Exercises

-- Exercise 1: 
SELECT name, homeworld FROM characters WHERE homeworld = 'Kashyyyk';

-- Exercise 2:
SELECT name, species FROM characters WHERE species != 'Droid';

-- Exercise 3:
SELECT name, species, homeworld
FROM characters 
WHERE species = 'Human' AND homeworld != 'Tatooine';

-- Exercise 4:
SELECT name FROM characters WHERE name LIKE '%sky%';

-- Challenge Problem:
-- Species with 'oid', AND homeworld starting with 'n'

SELECT * 
FROM characters 
WHERE species LIKE '%oid%' AND homeworld LIKE 'N%';

