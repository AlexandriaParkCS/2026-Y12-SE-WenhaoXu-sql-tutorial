-- database: ../runtime/db/starwars.db

-- Practical 5: Multiple Tables and relationships (schema)
-- Student Name: Wenhao Xu
-- Date: 17/12/25

-- Create Planets Table
CREATE TABLE IF NOT EXISTS planets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    climate TEXT,
    terrain TEXT,
    population INTEGER
);

-- Create Vehicles Table
CREATE TABLE IF NOT EXISTS vehicles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    model TEXT,
    vehicle_class TEXT,
    manufacturer TEXT
);

-- Create Junctions Table
CREATE TABLE IF NOT EXISTS character_vehicles(
    character_id INTEGER NOT NULL,
    vehicle_id INTEGER NOT NULL,
    PRIMARY KEY (character_id, vehicle_id)
    FOREIGN KEY (character_id) REFERENCES characters(id)
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);

ALTER TABLE characters ADD COLUMN homeworld_id INTEGER;