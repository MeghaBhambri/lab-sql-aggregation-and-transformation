-- CHALLENGE 1
USE sakila;
-- 1. As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration

SELECT max(length) as max_duration , min(length) as min_duration from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.

SELECT CONCAT(FLOOR(avg(length) / 60), 'h ', avg(length) % 60, 'm') AS average_duration FROM film;


-- 2.We need to use SQL to help us gain insights into our business operations related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and 
-- the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT datediff(max(rental_date) , min(rental_date)) as 'number of operating days' from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *, monthname(rental_date) as 'month',
weekday(rental_date)as 'weekday' from  rental
limit 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression
SELECT *,
       CASE weekday(rental_date)
           WHEN '0' THEN 'Weekend'
           WHEN '1' THEN 'Weekend'
           WHEN '02' THEN 'Monday'
           WHEN '03' THEN 'Tuesday'
           WHEN '04' THEN 'Wednesday'
           WHEN '05' THEN 'Thursday'
           WHEN '06' THEN 'Friday'
           ELSE NULL
       END AS day_type
FROM rental;

-- 3.We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the film titles 
-- and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order. 
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
SELECT title,
      CASE 
      when rental_duration is NULL then  'Not Available' 
			else rental_duration
	  END AS movie_info
from film
order by title ASC;

-- 4. As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. 
-- To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, 
-- so that we can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in
-- ascending order to make it easier for us to use the data.
SELECT *, 
CONCAT(first_name , last_name ,substr(email,1,3)) as personal_recommendations
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2
-- 1.We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(release_year) as 'Number of films released' FROM film;

-- 1.2 The number of films for each rating

SELECT rating , COUNT(*) as "number of films" FROM film
group by (rating);

-- 1.3  The number of films for each rating, and sort the results in descending order of the number of films.
SELECT rating , COUNT(*) as "number of films" FROM film
group by (rating) order by rating desc;

-- 2.We need to track the performance of our employees. Using the rental table, determine the number of rentals 
-- processed by each employee. This will help us identify our top-performing employees and areas where
-- additional training may be necessary.
SELECT staff_id ,count(*) as "number of rentals" from rental
group by staff_id;

-- Using the film table, determine:
-- 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
-- This will help us identify popular movie lengths for each category.
SELECT rating , round(avg(length),2) as "mean of film duartion" FROM film
group by (rating) order by"mean of film duartion" desc;

-- 3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
SELECT rating , round(avg(length),2) as "mean of film duartion" FROM film
group by (rating)
having "mean of film duartion" > 120;

-- 4.Determine which last names are not repeated in the table actor.
SELECT DISTINCT(last_name) FROM ACTOR;