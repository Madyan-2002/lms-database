SELECT * FROM public.users
ORDER BY user_id DESC LIMIT 100;

CREATE USER ahmad WITH PASSWORD 'ahmad123';

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO ahmad;

GRANT UPDATE, DELETE, DELETE ON roles TO ahmad;

REVOKE UPDATE, DELETE, SELECT ON roles FROM ahmad;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA PUBLIC FROM ahmad;

-- Create role

CREATE ROLE readonly_role;
GRANT readonly_role TO ahmad;

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO readonly_role;

SELECT * FROM users;
SELECT * FROM roles;
SELECT * FROM categories;
SELECT * FROM courses;
SELECT * FROM enrollments;
SELECT * FROM teachers;
SELECT * FROM submissions;
SELECT * FROM assignments;

-------------------------------------------------------------
INSERT INTO enrollments (user_id, courses_id, enrolled_at)
VALUES 
    (2, 1, CURRENT_TIMESTAMP),
    (2, 2, CURRENT_TIMESTAMP),
    (3, 1, CURRENT_TIMESTAMP);
					
INSERT INTO courses (title , price , level , metadate)
 			VALUES	('API Testing' , 80.0 , 'Advance', '{"language" : "English"}');


			 
INSERT INTO teachers (user_id, courses_id)
VALUES 
    (2, 1),
    (3, 2);

INSERT INTO submissions (score , submission_at , assignment_id , user_id)
		VALUES (100 , CURRENT_TIMESTAMP , 1 , 2),
		       (90 , CURRENT_TIMESTAMP , 2 , 2),
			   (100 , CURRENT_TIMESTAMP , 1 , 3),
			   (75 , CURRENT_TIMESTAMP , 3 , 4);


INSERT INTO assignments (title, max_score, due_date, courses_id)
VALUES 
    ('SQL Queries Practice', 100, '2026-08-01', 1),
    ('API Testing Basics', 50, '2026-08-10', 1),
    ('Database Design Project', 100, '2026-08-15', 2);
-----------------------------------------------------------------
SELECT users.full_name , users.email , roles.role_name
FROM users INNER JOIN roles
ON users.roles_id = roles.roles_id;

--------------------------------------------------------
SELECT c.title , cat.categories_name
FROM courses  c INNER JOIN categories cat
ON c.categories_id = cat.categories_id;

-------------------------------------------------------
SELECT u.full_name , a.country , a.city
FROM users u INNER JOIN addresses a
ON u.addresses_id = a.addresses_id;

-----------------------------------------------
SELECT c.title , cat.categories_name
FROM courses  c RIGHT JOIN categories cat
ON c.categories_id = cat.categories_id;

-------------------------------------------------
SELECT c.title , cat.categories_name
FROM courses  c LEFT JOIN categories cat
ON c.categories_id = cat.categories_id;

--------------------------------------------------
SELECT c.title , cat.categories_name
FROM courses  c FULL JOIN categories cat
ON c.categories_id = cat.categories_id;

------------------------------------------------

--Display each student alongside the instructor who taught them

SELECT s.full_name AS "student name", t.full_name AS "instructor name"
FROM users s
JOIN enrollments e ON s.user_id = e.user_id
JOIN teachers tc ON e.courses_id = tc.courses_id
JOIN users t ON tc.user_id = t.user_id;



---------
SELECT COUNT(user_id) FROM users;
SELECT COUNT(*) FROM users;

SELECT MIN(price) FROM courses;
SELECT MAX(price) FROM courses;
SELECT AVG(price) FROM courses;


SELECT title , MIN(price) FROM courses GROUP BY title; 


-- GROUP BY 
SELECT  c.title,  e.courses_id, COUNT(user_id) AS number_of_student 
FROM enrollments e  JOIN courses c ON e.courses_id = c.courses_id
GROUP BY e.courses_id , c.title HAVING COUNT(e.user_id) > 1;


-- Total number of users
SELECT COUNT(*) AS total_users FROM users;

-- Number of students per course
SELECT c.title, COUNT(e.user_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e ON c.courses_id = e.courses_id
GROUP BY c.title
ORDER BY student_count DESC;



-- Average score per assignment
SELECT a.title, AVG(s.score) AS avg_score
FROM assignments AS a
INNER JOIN submissions AS s ON a.assignment_id = s.assignment_id
GROUP BY a.title;

-- Total revenue (sum of course prices × enrollments)
SELECT SUM(c.price) AS total_revenue
FROM enrollments AS e
INNER JOIN courses AS c ON e.courses_id = c.courses_id;


-- Courses priced above the average price
SELECT title, price FROM courses
WHERE price > (SELECT AVG(price) FROM courses);

-- Students with at least one perfect score
SELECT DISTINCT u.full_name
FROM users AS u
WHERE u.user_id IN (
SELECT user_id FROM submissions WHERE score = 100
);
