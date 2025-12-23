-- database: ../runtime/db/starwars.db

-- Practical 5: Multiple Tables and relationships (data)
-- Student Name: Wenhao Xu
-- Date: 17/12/25

INSERT INTO planets (name, climate, terrain, population) VALUES
('Tatooine', 'arid', 'desert', 200000),
('Alderaan', 'temperate', 'grasslands, mountains', 2000000000),
('Hoth', 'frozen', 'tundra, ice caves', NULL),
('Kashyyyk', 'tropical', 'jungle, forests', 45000000), 
('Naboo', 'temperate', 'grassy hills, swamps', 4500000000), 
('Corellia', 'temperate', 'plains, urban', 3000000000),
('Stewjon', 'temperate', 'grass', NULL),
('Unknown', NULL, NULL, NULL);

UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Tatooine') WHERE homeworld = 'Tatooine';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Alderaan') WHERE homeworld = 'Alderaan';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Corellia') WHERE homeworld = 'Corellia';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Kashyyyk') WHERE homeworld = 'Kashyyyk';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name ='Stewjon') WHERE homeworld = 'Stewjon';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Naboo') WHERE homeworld = 'Naboo';
UPDATE characters SET homeworld_id = (SELECT id FROM planets WHERE name = 'Unknown') WHERE homeworld = 'Unknown';

INSERT INTO vehicles (name, model, vehicle_class, manufacturer) VALUES 
('X-wing', 'T-65 X-wing', 'Starfighter', 'Incom Corporation'), 
('Millennium Falcon', 'YT-1300 light freighter', 'Light freighter', 'Corellian Engineering Corporation'),
('TIE Fighter', 'Twin Ion Engine Fighter', 'Starfighter', 'Sienar Fleet Systems'),
('Imperial Speeder Bike', '74-Z speeder bike', 'Speeder', 'Aratech Repulsor Company'),
('Snowspeeder', 'T-47 airspeeder', 'Airspeeder', 'Incom Corporation'), 
('Lambda Shuttle', 'Lambda-class shuttle', 'Transport', 'Sienar Fleet Systems'),
('AT-AT', 'All Terrain Armoured Transport', 'Assault walker', 'Kuat Drive Yards'),
('Jedi Starfighter', 'Delta-T Aethersprite', 'Starfighter', 'Kuat Systems Engineering');

INSERT INTO character_vehicles (character_id, vehicle_id) VALUES
-- Luke flies X-wing, Snowspeeder
(28, 1),
(28, 5),
-- Han flies Millenium Falcon
(30, 2),
-- Same w/ Chewbecca
(31, 2),
-- Obi Wan flies Jedi Starfighter
(32, 8),
-- Darth Vader flies TIE Fighter, Lambda Shuttle
(33, 3),
(33, 6),
-- Yoda doesn't fly 🥲
-- R2-D2 is in X-wing and Jedi Starfighter
(35, 1),
(35, 8);

-- View all Planets
SELECT * FROM planets;
-- View all Vehicles
SELECT * FROM vehicles;
-- View character-vehicle links
SELECT * FROM character_vehicles;
-- View updated characters table
SELECT id, name, homeworld, homeworld_id FROM characters;

-- Practice Exercise

-- Add more planets
INSERT INTO planets (name, climate, terrain, population) VALUES
('Rock 89', 'frozen', 'uneven plains', 0),
('Large Rock 31', 'frozen', 'dry hills', 1);
-- Add own vehicles
INSERT INTO vehicles (name, model, vehicle_class, manufacturer) VALUES 
('Car 45', 'model 1', 'personal transport', 'carmaker'),
('Truck 60', 'model 3', 'Transport', 'carmaker');

-- Link
INSERT INTO character_vehicles (character_id, vehicle_id) VALUES
(28, 9),
(28, 10);