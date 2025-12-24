-- database: ../runtime/db/starwars.db

-- Practical 6: Table Joins
-- Student Name: Wenhao Xu
-- Date: 23/12/25

-- Query 1: Show characters with their homeworld details

SELECT
characters.name AS character_name, 
characters.species, 
planets.name AS homeworld_name,
planets.climate
FROM characters
INNER JOIN planets ON characters.homeworld_id = planets.id;

-- Query 2: Same query with table aliases
SELECT
c.name as character_name,
c.species,
p.name as homeworld_name,
p.climate,
p.population
FROM characters c
INNER JOIN planets p ON c.homeworld_id = p.id;

-- Query 3: Show which characters pilot which vehicles
SELECT
c.name as character_name,
v.name as vehicles_name,
v.vehicle_class
FROM characters c
INNER JOIN character_vehicles cv ON c.id = cv.character_id
INNER JOIN vehicles v ON cv.vehicle_id = v.id
ORDER BY c.name;

-- Query 4: Find all humans and their homeworlds
SELECT
c.name,
c.species,
p.name as homeworld
FROM characters c
INNER JOIN planets p ON c.homeworld_id = p.id
WHERE c.species = 'Human';

-- Query 5: Count how many characters are from each planet
SELECT 
p.name as planet_name,
count(c.id) as character_count
FROM planets p
INNER JOIN characters c ON p.id = c.homeworld_id
GROUP BY p.name
ORDER BY character_count DESC;

-- Query 6: All characters and their vehicles include no vehicles
SELECT
c.name as character_name,
v.name as vehicle_name
FROM characters c
LEFT JOIN character_vehicles cv ON c.id = cv.character_id
LEFT JOIN vehicles v ON cv.vehicle_id = v.id
ORDER BY c.name;

-- Query 7: Only Character w/o vehicles
SELECT 
c.name as character_name,
c.species
FROM characters c
LEFT JOIN character_vehicles cv on c.id = cv.character_id
WHERE cv.vehicle_id IS NULL;

-- Query 8: Find vehicles that no character pilots
SELECT
v.name as vehicle_name,
v.vehicle_class
FROM vehicles v
LEFT JOIN character_vehicles cv ON v.id = cv.vehicle_id
WHERE cv.character_id IS NULL;

-- Query 9: Count including empty groups
SELECT
p.name as planet_name,
count(c.id) as character_count
FROM planets p
LEFT JOIN characters c ON p.id = c.homeworld_id
GROUP BY p.name
ORDER BY character_count DESC;

-- Query 10: Find humans who pilot starfighters 
SELECT
c.name as character_name,
v.name as vehicle_name,
v.vehicle_class
FROM characters c
INNER JOIN character_vehicles cv ON c.id = cv.character_id
INNER JOIN vehicles v ON cv.vehicle_id = v.id
WHERE c.species = 'Human' AND v.vehicle_class = 'Starfighter';

-- Query 11: Find characters who pilot more than 1 vehicle
SELECT
c.name as character_name,
count(v.id) as vehicle_count
FROM characters c
INNER JOIN character_vehicles cv ON c.id = cv.character_id
INNER JOIN vehicles v ON cv.vehicle_id = v.id
GROUP BY c.name
HAVING count(v.id) > 1;

-- Query 12: Character summary with all related data
SELECT
c.name as character,
c.species,
p.name as homeworld,
p.climate,
count(v.id) as vehicles_piloted
FROM characters c
LEFT JOIN planets p ON c.homeworld_id = p.id
LEFT JOIN character_vehicles cv ON c.id = cv.character_id
LEFT JOIN vehicles v ON cv.vehicle_id = v.id
GROUP BY c.name, c.species, p.name, p.climate
ORDER BY c.name;

-- Practice Exercises
-- Exercise 1: List all characters with their homeworld's population
SELECT
c.name,
p.name as homeworld,
p.population
FROM characters c
INNER JOIN planets p on c.homeworld_id = p.id;

-- Exercise 2: Show all vehicle-pilot pairs with character species
SELECT
c.name as pilot,
c.species,
v.name as vehicle
FROM characters c
INNER JOIN character_vehicles cv ON c.id = cv.character_id
INNER JOIN vehicles v ON cv.vehicle_id = v.id;

-- Exercise 3: Find all planets with no characters
SELECT
p.name as planet_name,
p.climate
FROM planets p
LEFT JOIN characters c ON p.id = c.homeworld_id
WHERE c.id IS NULL;

-- Exercise 4: Show each vehicle with the count of who pilots it
SELECT
v.name as vehicle,
count(c.id) as pilot_count
FROM vehicles v
LEFT JOIN character_vehicles cv ON v.id = cv.vehicle_id
LEFT JOIN characters c ON cv.character_id = c.id
GROUP BY v.name;
