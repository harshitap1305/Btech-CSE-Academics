-- 3. Create student table

CREATE TABLE students (
   studentID INT PRIMARY KEY,
   firstName VARCHAR(255) NOT NULL,
   lastName VARCHAR(255) NOT NULL,
   discipline VARCHAR(255)
);

--3. create faculty table 
CREATE TABLE faculty (
   facultyID INT PRIMARY KEY,
   firstName VARCHAR(255) NOT NULL,
   lastName VARCHAR(255) NOT NULL,
   department VARCHAR(255)
);

--4. inserting data into students table
INSERT INTO students (studentID, firstName, lastName, discipline)
VALUES
(1234000, 'Neha', 'Parihar', 'CSE'),
(1234010, 'Nishi', 'Tigga', 'EE'),
(1234020, 'Nishi', 'Tigga', 'EE'),
(1234030, 'Bhumi', 'Verma', 'ME'),
(1234040, 'Rashi', 'Pandya', 'CSE');

--4. inserting data into faculty table
INSERT INTO faculty (facultyID, firstName, lastName, department)
VALUES
(22330000, 'Laxmi', 'Verma', 'CSE'),
(22330010, 'Neha', 'Verma', 'EE'),
(22330020, 'Nishi', 'Dev', 'CSE'),
(22330040, 'Prema', 'Sharma', 'ME');

--5. Selection (WHERE clause)
SELECT * FROM Students WHERE Discipline = 'CSE';

--Output: 
--12340000|Neha|Parihar|CSE
--1234040|Rashi|Pandya|CSE

SELECT * FROM Faculty WHERE Department = 'CSE';

--Output:
--22330000|Laxmi|Verma|CSE
--22330020|Nishi|Dev|CSE

--6. Projection (SELECT clause)

SELECT firstName, lastName FROM Students;

--Output:
--Neha|Parihar
--Nishi|Tigga
--Nishi|Tigga
--Bhumi|Verma
--Rashi|Pandya

SELECT LastName, Department FROM Faculty;
--Output:
--Verma|CSE
--Tigga|EE
--Dev|CSE
--Sharma|ME

--7. Union
SELECT FirstName FROM Students
UNION
SELECT FirstName FROM Faculty;

--Output:

--Bhumi
--Laxmi
--Neha
--Nishi
--Prema
--Rashi

SELECT LastName FROM Students
UNION
SELECT LastName FROM Faculty;

--Output:

--Dev
--Pandya
--Parihar
--Sharma
--Tigga
--Verma

--8. Intersection
SELECT FirstName FROM Students
INTERSECT
SELECT FirstName FROM Faculty;

--Output:

--Neha
--Nishi

SELECT LastName FROM Students
INTERSECT
SELECT LastName FROM Faculty;

--Output:
--Verma
