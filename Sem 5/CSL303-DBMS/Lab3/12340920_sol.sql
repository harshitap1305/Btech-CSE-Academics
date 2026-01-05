--PART 1

--1.
SELECT c.cname, f.fname 
FROM Courses AS c
JOIN Faculty AS f ON f.fid=c.instructor_fid;

--2.
SELECT s.sname 
FROM Students AS s
JOIN Enrolled AS e ON s.sid=e.sid
JOIN Courses AS c ON e.cid=c.cid
JOIN Faculty AS f ON f.fid=c.instructor_fid
WHERE f.fname='Prof. Sharma';

--3.
SELECT s.sname, c.cname 
FROM Students AS s
LEFT JOIN Enrolled AS e ON e.sid=s.sid
LEFT JOIN Courses AS c ON e.cid=c.cid;

--4.
SELECT f.fname, c.cname
FROM Faculty AS f
LEFT JOIN Courses AS c ON f.fid=c.instructor_fid;

--Part 2

--1
 SELECT sname FROM Students WHERE LOWER(sname) LIKE '%a%';
 
--2 
SELECT sname,sid FROM Students WHERE discip IS NULL;

--3 
SELECT sname,registration_date FROM Students WHERE STRFTIME("%Y", registration_date)='2022';

--4
SELECT sname FROM Students WHERE registration_date BETWEEN '2022-08-01' AND '2022-08-31';

--PART 3

--1
SELECT sname FROM Students WHERE gpa > (SELECT AVG(gpa) FROM Students);

--2
SELECT sname FROM Students WHERE discip='CSE'
EXCEPT
SELECT sname FROM Students s
JOIN Enrolled e ON s.sid=e.sid
WHERE e.cid='CSL303';

--3 
SELECT DISTINCT cname FROM Courses c1
WHERE EXISTS (
SELECT 1 FROM Courses c2
JOIN Enrolled e ON e.cid=c2.cid
WHERE c2.cid=c1.cid
);

--4 
SELECT sname FROM Students s1
WHERE s1.gpa =( SELECT MAX(s2.gpa) FROM Students s2
WHERE s2.discip=s1.discip);


--PART 4

--1 
INSERT INTO Students (sid,sname,discip,gpa,registration_date)
VALUES (201,'Ravi','EE',8.0,'2023-09-01');

--2
UPDATE Students SET gpa=gpa*(1.10) WHERE sid IN (SELECT sid FROM Enrolled WHERE cid="CSL303" AND grade='A');

--3 
 DELETE FROM Enrolled WHERE cid='MAL251';

 














