-- Active: 1736216143697@@127.0.0.1@3306@userprogressdb
CREATE DATABASE userprogressdb;

USE userprogressdb;

-- 1. Analyse the data
-- Hint: use a SELECT statement via a JOIN to sample the data
-- ****************************************************************
-- what is the common attribute between the two tables (users and progress) to perform a join
SELECT u.*, p.*
FROM users u INNER JOIN progress p
ON u.user_id = p.user_id;

-- 2. What are the Top 25 schools (.edu domains)?
-- Hint: use an aggregate function to COUNT() schools with most students
-- ****************************************************************
SELECT email_domain, COUNT(email_domain) AS "Number of students"
FROM users
WHERE email_domain LIKE '%.edu'
GROUP BY email_domain
ORDER BY 'Number of students' DESC
LIMIT 25;

-- 3. How many .edu learners are located in New York?
-- Hint: use an aggregate function to COUNT() students in New York
-- ****************************************************************
SELECT city, COUNT(city) AS "Number of students"
FROM users
WHERE email_domain LIKE '%.edu' AND city = 'New York'
GROUP BY city;

-- 4. The mobile_app column contains either mobile-user or NULL. 
-- How many of these learners are using the mobile app?
-- Hint: COUNT()...WHERE...IN()...GROUP BY...
-- Hint: Alternate answers are accepted.
-- ****************************************************************
SELECT mobile_app, COUNT(mobile_app) AS "Number of students"
FROM users
WHERE mobile_app = 'mobile-user'
GROUP BY mobile_app;

-- 5. Query for the sign up counts for each hour.
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************
SELECT DATE_FORMAT(sign_up_at, '%H') AS "Hour", 
COUNT(sign_up_at) AS "Number of sign ups"
FROM users
GROUP BY DATE_FORMAT(sign_up_at, '%H')   -- group by hour 
ORDER BY DATE_FORMAT(sign_up_at, '%H') ASC;  -- sorted by hour ascending

-- 6. What courses are the New Yorker Students taking? 
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++"
-- **************************************************************** ~ (use city and learn.*)
SELECT 
    city,
    SUM(CASE WHEN p.learn_cpp IS NOT NULL AND p.learn_cpp != '' THEN 1 ELSE 0 END) AS "C++",
    SUM(CASE WHEN p.learn_sql IS NOT NULL AND p.learn_sql != '' THEN 1 ELSE 0 END) AS "SQL",
    SUM(CASE WHEN p.learn_html IS NOT NULL AND p.learn_html != '' THEN 1 ELSE 0 END) AS "HTML",
    SUM(CASE WHEN p.learn_javascript IS NOT NULL AND p.learn_javascript != '' THEN 1 ELSE 0 END) AS "JavaScript",
    SUM(CASE WHEN p.learn_java IS NOT NULL AND p.learn_java != '' THEN 1 ELSE 0 END) AS "Java"
FROM 
    users u
    JOIN progress p ON u.user_id = p.user_id
WHERE 
    city = 'New York'
GROUP BY 
    city;

-- 7. What courses are the Chicago Students taking? 
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++"
-- **************************************************************** ~ (use city and learn.*)
SELECT 
    city,
    SUM(CASE WHEN p.learn_cpp IS NOT NULL AND p.learn_cpp != '' THEN 1 ELSE 0 END) AS "C++",
    SUM(CASE WHEN p.learn_sql IS NOT NULL AND p.learn_sql != '' THEN 1 ELSE 0 END) AS "SQL",
    SUM(CASE WHEN p.learn_html IS NOT NULL AND p.learn_html != '' THEN 1 ELSE 0 END) AS "HTML",
    SUM(CASE WHEN p.learn_javascript IS NOT NULL AND p.learn_javascript != '' THEN 1 ELSE 0 END) AS "JavaScript",
    SUM(CASE WHEN p.learn_java IS NOT NULL AND p.learn_java != '' THEN 1 ELSE 0 END) AS "Java"
FROM 
    users u
    JOIN progress p ON u.user_id = p.user_id
WHERE 
    city = 'Chicago'
GROUP BY 
    city;