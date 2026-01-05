--1 
CREATE TABLE enrolled (
student_id INT,
course_id INT,
grade TEXT,
PRIMARY KEY (student_id,course_id),
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

--2
INSERT INTO enrolled (student_id,course_id,grade)
SELECT student_id,course_id,grade FROM Enrollments;

--3
UPDATE Students
SET department='Philosophy'
WHERE name LIKE '%i%';

--4
ALTER TABLE Students ADD COLUMN email TEXT;

--5
UPDATE Students 
SET email=LOWER(name)||'@iitbhilai.ac.in';

--6
SELECT name FROM Students WHERE department='Computer Science';

--7
SELECT name 
FROM Students s
WHERE s.name IN (SELECT course_name FROM Courses);

--8 
SELECT s.name, c.course_name 
FROM Students s 
JOIN enrolled e ON e.student_id=s.student_id
JOIN Courses c ON e.course_id=c.course_id
ORDER BY c.course_name;

--9 
SELECT s.name, c.course_name 
FROM Students s 
LEFT JOIN enrolled e ON e.student_id=s.student_id
LEFT JOIN Courses c ON e.course_id=c.course_id;

-- 10
SELECT name FROM Students WHERE name LIKE 'A%';


 --11 
SELECT name FROM Students
WHERE student_id IN (
SELECT e.student_id FROM enrolled e JOIN Courses c ON c.course_id=e.course_id WHERE c.credits>3);

--12 
SELECT s.name
FROM Students s
LEFT JOIN enrolled e ON s.student_id=e.student_id
WHERE e.course_id IS NULL;




