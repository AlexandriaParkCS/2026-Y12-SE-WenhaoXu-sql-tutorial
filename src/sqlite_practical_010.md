# SQL, ORM and NoSQL Comparison

**Student Name: Wenhao**             
**Date: 1/21/2026**

## 1. SQL (Structured Query Language)

### What is it?
SQL is a standardised programming language which allows for the accessing and manipulation of databases.
### Advantages
- Great Performance in comparison
- Universal, allowing use in multiple languages
- Simple to use 
### Disadvantages
- Manual Work to handle relationships
- String-based, meaning no autocorrect
- More Code-heavy
### When to use
SQL should be used when data has clear and structured relationships, data integrity is crucial and when complex queries are required.
### Example Query

CREATE TABLE IF NOT EXISTS characters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    height INTEGER
);
INSERT INTO characters (name, height) VALUES 
('Bob', 119), 
('Steve', 160)

SELECT * FROM characters WHERE height IS NOT NULL and height > 120;

---
## 2. ORM (Object-Relational Mapping)
### What is it?
ORM (Object-Relational Mapping) is a method to interact with a database without writing SQL, and instead writing in whatever preferred language a programmer uses.
### Advantages
- Makes it easier to switch databases
- Does not require knowledge of SQL
- Can be more concise to write
- Can make it easier to navigate between related table with relationships
### Disadvantages
- ORM can create inefficient SQL queries
- Requires understanding of ORM syntax
- Worse to debug with harder inspections
- Harder to write complex queries
### When to use
Use ORM to write less complex queries
### Example Code (SQLAlchemy)

characters = session.query(Character)\
    .join(Workplace)\
    .filter(Workplace.location == "Sydney")\
    .all()

---
## 3. NoSQL (Document Database)
### What is it?
NoSQL refers to non-relational databases which store data in flexible formats instead of traditional rows and columns.
### Example Document Structure
(Bob)-[:FRIENDSWITH]->(Steve)

(Steve)-[:WORKSAT]->(Microsoft)
### Advantages
- Flexible
- Nested Data
- Fast read
### Disadvantages
- Less efficient complex queries
- Data duplication
### When to use
NoSQL should be used when data is unstructured and not clear.

## 4. My Recommendation
For the Star Wars Database project, I would choose SQL because of the benefits that SQL has over NoSQL / ORM when I require more complex queries. If I were to have a defined scope that does not require complex queries I would consider ORM. Ultimately I believe that SQL syntax is simpler than ORM syntax so as such I would choose SQL.

---
## 5. Real-World Example
**Application:** Banking System 

**Best Choice:** SQL 

**Reasoning:** A banking system would highly benefit from SQL, as their data is more structured and clear. The performance and data integrity of SQL helps significantly in the operations of a bank.

## Reflection Questions
### What surprised you the most about ORMs?
ORMs are heavy in its syntax and considerably worse than SQL's.
### Can you think of a situation where NoSQL would be better than SQL?
When the data is not structured and clear like the perfect world SQL requires.
### For a School Project, which would you choose and why?
Most likely SQL, but ORM looks potentially easier. SQL is simple yet effective, and allowing for more complex queries would help a lot.