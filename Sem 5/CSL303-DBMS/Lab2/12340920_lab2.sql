--Part 1
--1.
SELECT sname,gpa FROM students WHERE discipline="Physics";
--2. 
SELECT cname,credits FROM Courses WHERE credits=4;
--3.
SELECT sid,cid FROM Enrolled WHERE grade="F";
--4
SELECT sname,discipline FROM students ORDER BY sname,discipline;

--Part 2
--1 
SELECT sname
FROM Students AS s 
JOIN Enrolled AS e ON s.sid=e.sid
WHERE e.cid="CSL303";

--2
SELECT c.name
FROM students AS s
JOIN Enrolled AS e ON s.sid=c.sid
JOIN Courses As c ON e.cid=c.cid
WHERE s.sname="Ben Taylor";

--3
SELECT s.sname,c.cname,e.grade
FROM students AS s
JOIN Enrolled As e ON s.sid=e.sid
JOIN Courses AS c ON e.cid=c.cid;

--4
SELECT s.sname
FROM Students AS s
LEFT OUTER JOIN Enrolled As e
ON s.sid=e.sid
WHERE e.cid IS NULL;

--5 
SELECT s.sname
FROM Students AS s
JOIN Enrolled AS e
ON s.sid=e.sid
JOIN Courses AS c
ON e.cid=c.cid
WHERE e.grade ='B' AND c.credits=3;

--PART 3

--1
SELECT discipline, COUNT(sid)
FROM Students
GROUP BY discipline;

--2
SELECT credits, COUNT(cid)
FROM Courses
GROUP BY credits;

--3
SELECT c.cname, COUNT(e.sid) AS scount
FROM Courses AS c
JOIN Enrolled AS e
ON c.cid=e.cid
JOIN Students AS s
ON s.sid=e.sid
GROUP BY c.cid;

--4
SELECT e.cid
FROM Enrolled AS e
WHERE e.grade='A'
GROUP BY e.cid
HAVING COUNT(e.sid)>2;









