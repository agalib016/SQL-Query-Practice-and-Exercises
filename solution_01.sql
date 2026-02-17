use work;

CREATE TABLE Student_Info(
	Student_ID VARCHAR(10),
	Student_Name VARCHAR(50),
	Department VARCHAR(50),
	City VARCHAR(50)
);
INSERT INTO Student_Info (Student_ID, Student_Name, Department, City) VALUES
	('S101', 'Rahim', 'CSE', 'Dhaka'),
	('S102', 'Karim', 'EEE', 'Rajshahi'),
	('S103', 'Salma', 'CSE', 'Dhaka'),
	('S104', 'Ayesha', 'BBA', 'Chattogram'),
	('S105', 'Rifat', 'CSE', 'Rajshahi'),
	('S106', 'Nusrat', 'EEE', 'Dhaka');

CREATE TABLE Course_Enrollment(
	Enrollment_ID VARCHAR(10),
	Student_ID VARCHAR(10),
	Course_Code VARCHAR(10),
	Course_Title VARCHAR(100),
	Semester VARCHAR(20)
);
INSERT INTO Course_Enrollment (Enrollment_ID, Student_ID, Course_Code, Course_Title, Semester) VALUES
	('E001', 'S101', 'C-201', 'Database Systems', 'Spring'),
	('E002', 'S102', 'C-202', 'Circuits', 'Fall'),
	('E003', 'S103', 'C-201', 'Database Systems', 'Spring'),
	('E004', 'S107', 'C-203', 'Marketing', 'Summer'),
	('E005', 'S106', 'C-204', 'Power Systems', 'Fall'),
	('E006', 'S108', 'C-205', 'Accounting', 'Spring');

--1. Display student information along with course details using INNER JOIN.
SELECT s.Student_ID, s.Student_Name, s.Department, s.City,
       c.Course_Code, c.Course_Title, c.Semester
FROM Student_Info s
INNER JOIN Course_Enrollment c
ON s.Student_ID = c.Student_ID;

--2. Display all students and their course details; include students who are not enrolled in any course using LEFT JOIN.
SELECT s.Student_ID, s.Student_Name, s.Department, s.City,
       c.Course_Code, c.Course_Title, c.Semester
FROM Student_Info s
LEFT JOIN Course_Enrollment c
ON s.Student_ID = c.Student_ID;

--3. Display all course enrollments including those without matching students using RIGHT JOIN.
SELECT s.Student_ID, s.Student_Name, s.Department, s.City,
       c.Course_Code, c.Course_Title, c.Semester
FROM Student_Info s
RIGHT JOIN Course_Enrollment c
ON s.Student_ID = c.Student_ID;

--4. Display all students and all enrollments, whether matched or not using FULL OUTER JOIN.
SELECT s.Student_ID, s.Student_Name, s.Department, s.City,
       c.Course_Code, c.Course_Title, c.Semester
FROM Student_Info s
FULL OUTER JOIN Course_Enrollment c
ON s.Student_ID = c.Student_ID;

--5. Generate a Cartesian product of Student_Info and Course_Enrollment using CROSS JOIN.
SELECT s.Student_ID, s.Student_Name,
       c.Enrollment_ID, c.Course_Code
FROM Student_Info s
CROSS JOIN Course_Enrollment c;

--6. Display pairs of students who belong to the same department using SELF JOIN.
SELECT s1.Student_Name AS Student1,
       s2.Student_Name AS Student2,
       s1.Department
FROM Student_Info s1
JOIN Student_Info s2
ON s1.Department = s2.Department
AND s1.Student_ID < s2.Student_ID;

--7. Display student names and course titles for students enrolled in the Spring semester only.
SELECT s.Student_Name, c.Course_Title
FROM Student_Info s
INNER JOIN Course_Enrollment c
ON s.Student_ID = c.Student_ID
WHERE c.Semester = 'Spring';

--8. Find students who do not have any course enrollment.
SELECT s.Student_ID, s.Student_Name
FROM Student_Info s
LEFT JOIN Course_Enrollment c
ON s.Student_ID = c.Student_ID
WHERE c.Student_ID IS NULL;

--9. Display the number of students enrolled in each course.
SELECT Course_Code, Course_Title,
       COUNT(Student_ID) AS Total_Students
FROM Course_Enrollment
GROUP BY Course_Code, Course_Title;

--10. Display departments having more than 1 enrolled student using HAVING.
SELECT s.Department,
       COUNT(DISTINCT s.Student_ID) AS Total_Enrolled_Students
FROM Student_Info s
INNER JOIN Course_Enrollment c
ON s.Student_ID = c.Student_ID
GROUP BY s.Department
HAVING COUNT(DISTINCT s.Student_ID) > 1;
