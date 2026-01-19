"""
Practical 9: Python SQL database integration
Student Name: Wenhao Xu
Date: 19/1/26
"""
import sqlite3
import sys

from pathlib import Path
db_path = Path(__file__).parent.parent / '../runtime/db/starwars.db'
if not db_path.exists():
    print(f"Database not found at: {db_path}")

SQLITEDB = '../runtime/db/starwars.db'

# Connecting to database
def query_characters():
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            print("Connected To Database :)")
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM characters LIMIT 5")
            results = cursor.fetchall()
            for row in results:
                print(row)
    except sqlite3.Error as e:
        print(f"Error: {e}")

def test_connection():
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            print("Connection Successful")
            print(f"SQLITE version: {sqlite3.sqlite_version}")
        print("Connection Automatically Closed")
    except sqlite3.Error as e:
        print(f"Error: {e}")

def get_all_characters():
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT id, name, species, homeworld FROM characters")
            characters = cursor.fetchall()
            print("\n=== All Characters ===")
            for char in characters:
                print(f"ID: {char[0]}, Name: {char[1]}, Species: {char[2]}, Homeworld: {char[3]}")
            print(f"\nTotal Characters: {len(characters)}")
    except sqlite3.Error as e:
        print(f"Error executing query: {e}")

def demonstrate_fetch_requests():
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            cursor = conn.cursor()
            # Method 1
            print("\n=== fetchone() Demo ===")
            cursor.execute("SELECT name, species FROM characters LIMIT 3")
            row = cursor.fetchone()
            while row:
                print(f"Name: {row[0]}, Species: {row[1]}")
                row = cursor.fetchone()
            # Method 2
            print("\n=== fetchmany() Demo ===")
            cursor.execute("SELECT name, species FROM characters")
            rows = cursor.fetchmany(5) # fetch 5 rows
            for row in rows:
                print(f"Name: {row[0]}, Species: {row[1]}")
            # Method 3
            print("\n=== fetchall() Demo ===")
            cursor.execute("SELECT name, height FROM characters WHERE height IS NOT NULL ORDER BY height DESC LIMIT 3")
            all_rows = cursor.fetchall()
            print("Top 3 tallest characters")
            for row in all_rows:
                print(f"{row[0]}: {row[1]}cm")
            
    except sqlite3.Error as e:
        print(f"Error: {e}")

def get_characters_as_dict():
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()

            cursor.execute("SELECT name, species, height FROM characters WHERE height IS NOT NULL ORDER BY height DESC LIMIT 5")
            characters = cursor.fetchall()

            print("\n=== Characters As Dictionaries ===")
            for char in characters:
                print(f"{char['name']}, {char['species']}, {char['height']}cm")

    except sqlite3.Error as e:
        print(f"Error: {e}")

def search_by_species(species):
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            cursor = conn.cursor()

            cursor.execute("""
                        SELECT name, species, height
                        FROM characters
                        WHERE species = ? AND height IS NOT NULL
                        ORDER BY height DESC
                        """, (species,))
            results = cursor.fetchall()

            print(f"\n=== {species} Characters ===")
            for char in results:
                print(f"{char['name']}: {char['height']}cm")

    except sqlite3.Error as e:
        print(f"Error: {e}")

def add_character(name, species, homeworld_id, height=None):
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            cursor = conn.cursor()
            cursor.execute("""
INSERT INTO characters (name, species, homeworld_id, height) VALUES(?, ?, ?, ?)
                           """, (name, species, homeworld_id, height))
            
            print(f"Added Character {name}")
            return True
    
    except sqlite3.Error as e:
        print(f"Error adding character: {e}")
        return False
    
def update_character_height(name, new_height):
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            cursor = conn.cursor()
            cursor.execute("""
UPDATE characters
                           SET height = ?
                           WHERE name = ?
""", new_height, name)
    
            if cursor.rowcount > 0:
                print(f"Updated {cursor.rowcount} Character(s)")
                return True
            else:
                print(f"No character found with name: {name}")
                return False
    except sqlite3.Error as e:
        print(f"Error updating character: {e}")

def delete_character(name):
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            cursor = conn.cursor()
            cursor.execute("DELETE FROM characters WHERE name = ?", (name,))

            if cursor.rowcount > 0:
                print(f"Deleted Character: {name}")
                return True
            else:
                print(f"No character found with name: {name}")
                return False
            
    except sqlite3.Error as e:
        print(f"Error deleting character: {e}")
        return False
    
def get_character_statistics():
    try:
        with sqlite3.connect(SQLITEDB) as conn:
            cursor = conn.cursor()

            cursor.execute("SELECT COUNT(*) FROM characters")
            total_chars = cursor.fetchone()[0]

            cursor.execute("SELECT COUNT(DISTINCT species) FROM characters")
            total_species = cursor.fetchone()[0]

            cursor.execute("SELECT avg(height) FROM characters WHERE height IS NOT NULL")
            avg_height = cursor.fetchone()[0]

            print("\n=== Database Statistics ===")
            print(f"Total Characters: {total_chars}")
            print(f"Total Species: {total_species}")
            print(f"Average Height: {avg_height:.1f}cm")

    except sqlite3.Error as e:
        print(f"Error: {e}")
def main():
    """Main program menu"""
    print("=" * 50)
    print("STAR WARS DATABASE - PYTHON INTERFACE")
    print("=" * 50)
    # Run demonstrations
    print("\n--- Testing Connection --")
    test_connection()

    print("\n--- All Characters --")
    get_all_characters()

    print("\n--- Fetch Methods ---")
    demonstrate_fetch_requests()

    print("\n--- Dictionary Access ---")
    get_characters_as_dict()

    print("\n--- Search by Species ---")
    search_by_species("Human")

    print("\n--- Database Statistics ---")
    get_character_statistics()

    add_character("Test Character", "Test Species", 1, 175)

    update_character_height("Test Character", 180)

    delete_character("Test Character")
    print("\n" + "=" * 50)
    print("Demo complete!")
    print("=" * 50)

if __name__ == "__main__":
    main()