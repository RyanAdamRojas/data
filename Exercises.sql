--PART I
-- TWO COLUMNS DEFINE THE PRIMARY KEY         
CREATE TABLE Locations (
  address CHAR(50) NOT NULL,
  city CHAR(50) NOT NULL,
  state CHAR(50),
  observation CHAR(50),
  PRIMARY KEY (address, city)
) Engine = InnoDB;

DESCRIBE Locations;

-- Do a screenshot
--OK
INSERT INTO
  Locations (address, city, state, observation)
VALUES
  (
    '10415 Ashwood',
    'El Paso',
    'Texas',
    'Need maintenance'
  );

SELECT
  *
FROM
  Locations;

-- Do a screenshot
--Fails - duplicate key
INSERT INTO
  Locations (address, city, state, observation)
VALUES
  ('10415 Ashwood', 'El Paso', 'Texas', 'Good appeal');

-- Do a screenshot
-- OK - partial key different
INSERT INTO
  Locations (address, city, state, observation)
VALUES
  (
    '10415 Ashwood',
    'San Francisco',
    'California',
    'Clean'
  );

-- OK
INSERT INTO
  Locations (address, city, state, observation)
VALUES
  ('6911 Enid Ct', 'El Paso', 'Texas', 'Clean');

-- Screenshot after the following command
SELECT
  *
FROM
  Locations;

--fails - null part of key
INSERT INTO
  Locations (address, city)
VALUES
  ('10415 Ashwood', NULL);

--fails - unspecified key
INSERT INTO
  Locations (address, observation)
VALUES
  ('10415 Ashwood', 'Roof bad');

SELECT
  *
from
  Locations;

--screenshot
DROP TABLE Locations;

--PART II
CREATE TABLE Locations (
  address CHAR(50) NOT NULL,
  city CHAR(50) NOT NULL,
  observation CHAR(50),
  PRIMARY KEY (address, city),
  FOREIGN KEY (city) REFERENCES Cities(city) ON UPDATE CASCADE ON DELETE CASCADE
) Engine = InnoDB;

--Were you able to create the table? What is the issue?
-- Do a screenshot with the error you get
--PART III
CREATE TABLE Cities (
  city CHAR(50) NOT NULL,
  state CHAR(50),
  PRIMARY KEY (city)
) Engine = InnoDB;

CREATE TABLE Locations (
  address CHAR(50) NOT NULL,
  city CHAR(50) NOT NULL,
  observation CHAR(50),
  PRIMARY KEY (address, city),
  FOREIGN KEY (city) REFERENCES Cities(city) ON UPDATE CASCADE ON DELETE CASCADE
) Engine = InnoDB;

--fails - Cannot add or update a child row
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('10415 Ashwood', 'El Paso', 'Need maintenance');

--OK
INSERT INTO
  Cities (city, state)
VALUES
  ('El Paso', 'Texas');

--Screenshot
--OK
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('10415 Ashwood', 'El Paso', 'Need maintenance');

SELECT
  *
FROM
  LOCATIONS;

SELECT
  *
FROM
  CITIES;

--Screenshot
--fails - CANNOT DELETE TABLE WHEN THERE ARE DEPENDENCIES
DROP TABLE Cities;

--Screenshot
-- ok- we're deleting the child table
DROP TABLE Locations;

--PART IV
CREATE TABLE Cities (
  city CHAR(50) NOT NULL,
  state CHAR(50),
  PRIMARY KEY (city)
) Engine = InnoDB;

CREATE TABLE Locations (
  address CHAR(50) NOT NULL,
  city CHAR(50) NOT NULL,
  observation CHAR(50),
  PRIMARY KEY (address, city),
  FOREIGN KEY (city) REFERENCES Cities(city) ON UPDATE CASCADE ON DELETE CASCADE
) Engine = InnoDB;

--OK
INSERT INTO
  Cities (city, state)
VALUES
  ('El Paso', 'Texas');

--ok - El Paso is there
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('10415 Ashwood', 'El Paso', 'Need maintenance');

-- We insert a new city
INSERT INTO
  Cities (city, state)
VALUES
  ('San Francisco', 'California');

INSERT INTO
  Locations (address, city, observation)
VALUES
  ('10415 Ashwood', 'San Francisco', 'Clean');

SELECT
  *
FROM
  Locations;

SELECT
  *
FROM
  Cities;

-- cascading with update
UPDATE
  Cities
SET
  city = 'EL PASO - 2'
WHERE
  city = 'El Paso';

SELECT
  *
FROM
  Locations;

SELECT
  *
FROM
  Cities;

-- CASCADING WITH Delete
DELETE FROM
  Cities
WHERE
  city = 'EL PASO - 2';

--fails because El Paso - 2 was deleted
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('6911 Enid Ct', 'El Paso', 'Clean');

--OK
INSERT INTO
  Cities (city, state)
VALUES
  ('El Paso', 'Texas');

--OK
INSERT INTO
  Cities (city, state)
VALUES
  ('Dallas', 'Texas');

--ok - El Paso is there
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('10415 Ashwood', 'El Paso', 'Need maintenance');

--ok - El Paso is there
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('6911 Enid Ct', 'El Paso', 'Clean');

--ok - El Paso is there INSERT INTO Locations (address,city,observation) VALUES ('10415 Ashwood','El Paso','Need maintenance');
SELECT
  *
FROM
  Locations;

SELECT
  *
FROM
  Cities;

--TAKE A SCREENSHOT FOR HOMEWORK DUE ON 10/19 AT THE BEGINNING OF HE CLASS
-- If there are records (tuples) without dependencies on the parent table, we can modify it without consequences on the child table.
DELETE FROM
  Cities
WHERE
  city = 'Dallas';

SELECT
  *
FROM
  Locations;

SELECT
  *
FROM
  Cities;

INSERT INTO
  Cities (city, state)
VALUES
  ('Dallas', 'Texas');

INSERT INTO
  Cities (city, state)
VALUES
  ('Manhattan', 'New York');

--QUERY THAT JOINS THE TABLES CITIES AND LOCATIONS AFTER SPLITTING THEM FOR NORMALIZATION   
SELECT
  *
FROM
  LOCATIONS
  JOIN CITIES
WHERE
  LOCATIONS.city = CITIES.city;

--TAKE A SCREENSHOT FOR HOMEWORK/CLASS SUBMISSION
SELECT
  LOCATIONS.address,
  LOCATIONS.city,
  LOCATIONS.observation,
  CITIES.state
FROM
  LOCATIONS
  JOIN CITIES
WHERE
  LOCATIONS.city = CITIES.city;

HOMEWORK / CLASS SUBMISSION UP TO THIS POINT --------------------------------------------------------PART V --------------------------------------------------------------------------
CREATE VIEW TexasCities AS
SELECT
  city
FROM
  Cities
WHERE
  state LIKE 'Texas';

SELECT
  *
FROM
  TexasCities;

--TAKE A SCREENSHOT FOR CLASS SUBMISSION
-- Now let's create a view with aggregation
CREATE VIEW CitiesByStates AS
SELECT
  state,
  count(*)
FROM
  Cities
GROUP BY
  state;

SELECT
  *
FROM
  CitiesByStates;

--TAKE A SCREENSHOT FOR CLASS SUBMISSION
-- Now let's create a view that joins the two tables
CREATE VIEW LocationsWithStates AS
SELECT
  Locations.*,
  Cities.state
FROM
  Locations
  JOIN Cities;

-- Cross product
SELECT
  *
FROM
  LocationsWithStates;

--TAKE A SCREENSHOT FOR CLASS SUBMISSION
DROP VIEW LocationsWithStates;

--Specify the condition
CREATE VIEW LocationsWithStates AS
SELECT
  Locations.*,
  Cities.state
FROM
  Locations
  JOIN Cities
WHERE
  Locations.city = Cities.city;

SELECT
  *
FROM
  LocationsWithStates;

--TAKE A SCREENSHOT FOR CLASS SUBMISSION
INSERT INTO
  Cities
VALUES
('Denver', 'Colorado');

-- What if we want to get all the states, with or without states.
CREATE VIEW AllStates AS
SELECT
  Cities.state,
  Locations.*
FROM
  Cities
  LEFT JOIN Locations ON Cities.city = Locations.city;

SELECT
  *
FROM
  AllStates;

--TAKE A SCREENSHOT FOR CLASS SUBMISSION
-- What if we want to get the states with no Locations.
CREATE VIEW StatesWithNoLocations AS
SELECT
  state
FROM
  Cities
WHERE
  city NOT IN (
    SELECT
      city
    FROM
      Locations
  );

SELECT
  *
FROM
  StatesWithNoLocations;

--TAKE A SCREENSHOT FOR CLASS SUBMISSION
CREATE VIEW StatesWithNoLocations AS
SELECT
  state
FROM
  Cities
WHERE
  state NOT IN (
    SELECT
      state
    FROM
      Locations
      JOIN Cities
    WHERE
      Locations.city = Cities.city
  );

SELECT
  *
FROM
  StatesWithNoLocations;

--TAKE A SCREENSHOT FOR HOMEWORK/CLASS SUBMISSION
--Deleting through a view.
DELETE FROM
  TexasCities
WHERE
  city = 'El Paso';

--Locations in 'El Paso' are deleted from Texas Cities.
SELECT
  *
FROM
  TexasCities;

--Locations in 'El Paso' are ALSO deleted from Cities through the view.
SELECT
  *
FROM
  Cities;

--Locations in 'El Paso' are ALSO deleted from Locations through the FOREIGN KEY ON DELETE CASCADE.
SELECT
  *
FROM
  Locations;

--TAKE A SCREENSHOT FOR HOMEWORK/CLASS SUBMISSION
FINAL STEP: Create a new view named 'YourFirstName_LastName_View1' USING THE TABLES CITIES
AND LOCATIONS.This should be a unique view
from
  the ones shown above.Show the results
  and take a screenshot.You can
add
  more Locations
  or cities as needed.FINAL STEP: Create a new view named 'YourFirstName_LastName_View2' USING A SUBQUERY
  AND THE TABLES CITIES
  AND LOCATIONS.This should be a unique view
from
  the ones shown above.Show the results
  and take a screenshot.You can
add
  more Locations
  or cities as needed.--------------------------------------------------------------- PART VI ------- PROCEDURES AND TRIGGERS -----------------------------------------------------------
  -- PROCEDURE EXAMPLE
  --CHANGE DELIMITER
  DELIMITER $ CREATE PROCEDURE LocationsByCity2(IN cityIn CHAR(50)) BEGIN
SELECT
  count(*)
FROM
  Locations
where
  city = cityIn;

END $ DELIMITER;

--CALL THE PROCEDURE AND SHOW THE RESULTS AS SHOWN IN THE SLIDES
--SUBMIT A SCREENSHOT
-- TRIGGER EXAMPLE - THIS CAN ONLY BE USED IN YOUR LOCAL HOST. OPTIONAL, NO NEED TO SUBMIT AS PART OF THE HOMEWORK INDIVIDUAL PRACTICE.
DELIMITER $ --Create trigger to add a city before adding a property
CREATE TRIGGER addingCities BEFORE
INSERT
  ON Locations FOR EACH ROW BEGIN
INSERT INTO
  Cities
SET
  city = NEW.city;

END;

$ --Change delimiter back to ;
DELIMITER;

-- ok - we create the city El Paso, but now we don't have a way to add the additional information. Can be dealt with from the application.
--Insert a Property in a city that is not in the cities table
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('10415 Ashwood', 'Cancun', 'Need maintenance');

--SUBMIT A SCREENSHOT THAT SHOWS WHAT HAPPENS WHEN YOU INSERT THE ROW ABOVE
--Checking that the record was added to cities
SELECT
  *
FROM
  Cities;

-- Adding the missing state
UPDATE
  Cities
SET
  state = 'Texas'
WHERE
  city = 'Austin';

SELECT
  *
FROM
  Cities;

-- Add the additional property, what happens? the trigger is trying to add another city with the primary key 'El Paso'.
INSERT INTO
  Locations (address, city, observation)
VALUES
  ('6911 Enid Ct', 'El Paso', 'Clean');

-- Let's get rid of the trigger    
DROP TRIGGER addingCities;

INSERT INTO
  Locations (address, city, observation)
VALUES
  ('6911 Enid Ct', 'El Paso', 'Clean');

INSERT INTO
  Cities (city, state)
VALUES
  ('Dallas', 'Texas');

SELECT
  *
FROM
  Locations;

SELECT
  *
FROM
  Cities;

SELECT
  *
FROM
  Locations;

SELECT
  *
FROM
  Cities;

-- +----------+-------------+--------------+
-- | address  | city        | observation      |
-- +----------+-------------+--------------+
-- | 10415 Ashwood | El Paso     | Need maintenance |
-- | 10415 Ashwood | San Francisco | Clean        |
-- | 6911 Enid Ct | El Paso     | Clean        |
-- +----------+-------------+--------------+
-- 3 rows in set (0.00 sec)
-- +-------------+------------+
-- | city        | state      |
-- +-------------+------------+
-- | El Paso     | Texas      |
-- | San Francisco | California |
-- | Dallas      | Texas      |
-- +-------------+------------+
-- 3 rows in set (0.00 sec)
-- If there are records (tuples) without dependencies on the parent table, we can modify it without consequences on the child table.
DELETE FROM
  Cities
WHERE
  city = 'Dallas';

SELECT
  *
FROM
  Locations;

SELECT
  *
FROM
  Cities;

--------------------------------------------------------- PART VII ------------------ PROCEDURES WITH IF STATEMENTS -------------------------
-- We will create now a table that contains prices for Locations
DROP TABLE Ctities;

DROP TABLE Locations;

CREATE TABLE Cities (
  city CHAR(50) NOT NULL,
  state CHAR(50),
  PRIMARY KEY (city)
) Engine = InnoDB;

CREATE TABLE Locations (
  address CHAR(50) NOT NULL,
  city CHAR(50) NOT NULL,
  observation CHAR(50),
  price DECIMAL(10, 2),
  PRIMARY KEY (address, city),
  FOREIGN KEY (city) REFERENCES Cities(city) ON UPDATE CASCADE ON DELETE CASCADE
) Engine = InnoDB;

INSERT INTO
  Cities (city, state)
VALUES
  ('El Paso', 'Texas');

INSERT INTO
  Cities (city, state)
VALUES
  ('Dallas', 'Texas');

INSERT INTO
  Locations (address, city, observation, price)
VALUES
  (
    '10415 Ashwood',
    'El Paso',
    'Need maintenance',
    200000.00
  );

INSERT INTO
  Locations (address, city, observation, price)
VALUES
  ('6911 Enid Ct', 'El Paso', 'Clean', 250000.00);

INSERT INTO
  Locations (address, city, observation, price)
VALUES
  ('10415 Ashwood', 'Dallas', 'Clean', 400000.00);

DELIMITER $ CREATE PROCEDURE CityType(IN cityIn CHAR(50), OUT cityLevel VARCHAR(10)) BEGIN DECLARE LocationsInRange INT DEFAULT 0;

SELECT
  count(*) INTO LocationsInRange
FROM
  Locations
WHERE
  city = cityIn
  AND price > 300000.00;

IF LocationsInRange > 1 THEN
SET
  cityLevel = 'EXPENSIVE';

ELSE
SET
  cityLevel = 'AFFORDABLE';

END IF;

END $ --------------------------------------------------------- PART VIII ------------ PROCEDURES WITH PARAMETERS ---------------------------------------------------------------------------------------------------
-- Create a procedure named LocationsInState that receives the name of a State and returns the NUMBER of locations in that state.
-- Submit a screenshot with the procedure command, and the command to CALL the procedure and view the result.