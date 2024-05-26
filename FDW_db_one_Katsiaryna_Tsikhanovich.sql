-- Install the required extension
CREATE EXTENSION postgres_fdw;

-- Create a foreign server that connects to 'db_two'
CREATE SERVER same_server_postgres
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (dbname 'db_two');

-- Create a user mapping for the current user
CREATE USER MAPPING FOR CURRENT_USER
    SERVER same_server_postgres
    OPTIONS (user 'postgres', password '159357');
	
-- Define a foreign table that maps to 'remote_table' in 'db_two'
CREATE FOREIGN TABLE local_remote_table (
   id INTEGER,
   name VARCHAR(255),
   age INTEGER
)
SERVER same_server_postgres
OPTIONS (schema_name 'public', table_name 'remote_table');

-- Select all records from the foreign table
SELECT * FROM local_remote_table;

-- Insert a new record into the foreign table
INSERT INTO local_remote_table (id, name, age) VALUES (4, 'Hanna Swan', 40);

-- Update an existing record in the foreign table
UPDATE local_remote_table SET age = 20 WHERE name = 'Kate Tihanovich';

-- Delete a record from the foreign table
DELETE FROM local_remote_table WHERE name = 'Alex Smith';