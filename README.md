This readme file provides an overview of the userprogressdb database and its functionalities.

Database Structure

The userprogressdb database consists of two tables:

users table: This table stores user information such as user ID, email address, sign-up time, city, and mobile app usage (mobile-user or null).
SQL

user_id (INT PRIMARY KEY)
email (VARCHAR(255))
sign_up_at (DATETIME)
city (VARCHAR(255))
mobile_app (VARCHAR(255))
progress table: This table stores user progress data for various courses (C++, SQL, HTML, JavaScript, and Java). Each course has a field indicating whether the user is learning the course (not null or empty string) or not (null or empty string).
SQL

user_id (INT FOREIGN KEY REFERENCES users(user_id) PRIMARY KEY)
learn_cpp (VARCHAR(255))
learn_sql (VARCHAR(255))
learn_html (VARCHAR(255))
learn_javascript (VARCHAR(255))
learn_java (VARCHAR(255))
Sample Queries

The readme file also include some sample queries to demonstrate how to analyze the data in the userprogressdb database. Here are some examples:

Join users and progress tables: This query retrieves all user data along with their corresponding progress data.
SQL

SELECT u.*, p.*
FROM users u
INNER JOIN progress p ON u.user_id = p.user_id;
Top 25 schools (by .edu domain): This query finds the top 25 schools (based on the email domain) with the most students enrolled.
SQL

SELECT email_domain, COUNT(email_domain) AS "Number of students"
FROM users
WHERE email_domain LIKE '%.edu'
GROUP BY email_domain
ORDER BY 'Number of students' DESC
LIMIT 25;
Number of .edu learners in New York: This query counts the number of students with .edu email addresses who are located in New York City.
SQL

SELECT city, COUNT(city) AS "Number of students"
FROM users
WHERE email_domain LIKE '%.edu' AND city = 'New York'
GROUP BY city;
Mobile app usage: This query determines how many users are utilizing the mobile app.
SQL

SELECT mobile_app, COUNT(mobile_app) AS "Number of students"
FROM users
WHERE mobile_app = 'mobile-user'
GROUP BY mobile_app;
Sign up counts by hour: This query retrieves the number of users who signed up for the platform each hour.
SQL

SELECT DATE_FORMAT(sign_up_at, '%H') AS "Hour", 
COUNT(sign_up_at) AS "Number of sign ups"
FROM users
GROUP BY DATE_FORMAT(sign_up_at, '%H') 
ORDER BY DATE_FORMAT(sign_up_at, '%H') ASC;
Courses taken by New Yorker Students: This query finds out which courses (C++, SQL, HTML, JavaScript, and Java) are being taken by students in New York City.
SQL

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
