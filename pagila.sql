#1a. You need a list of all the actors’ first name and last name
select first_name, last_name from actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
Select concat(upper(first_name), ' ', upper(last_name)) Actor_Name from actor;

#2a. You need to find the id, first name, and last name of an actor, of whom you know only the first name of "Joe." 
#What is one query would you use to obtain this information?
select actor_id,first_name,last_name from actor where first_name iLike 'Joe';

#2b. Find all actors whose last name contain the letters GEN. Make this case insensitive
select * from actor where last_name iLike '%GEN%';

#2c. Find all actors whose last names contain the letters LI. 
# This time, order the rows by last name and first name, in that order. Make this case insensitive.
select * from actor where last_name iLike '%LI%' order by last_name, first_name;

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
Select country_id, country from country where country IN ('Afghanistan','Bangladesh','China');

#3a. Add a middle_name column to the table actor. Specify the appropriate column type
ALTER TABLE actor ADD COLUMN middle_name VARCHAR(255)

#3b. You realize that some of these actors have tremendously long last names. 
#Change the data type of the middle_name column to something that can hold more than varchar.
ALTER TABLE actor ALTER COLUMN middle_name SET DATA TYPE text;

#3c. Now write a query that would remove the middle_name column.
ALTER TABLE actor DROP COLUMN middle_name;

#4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(last_name) from actor GROUP BY last_name ORDER BY count(last_name) DESC;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name) from actor 
GROUP BY last_name 
HAVING count(last_name) > 1
ORDER BY count(last_name) DESC;

#4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE actor 
SET first_name = 'HARPO' 
WHERE first_name ilike '%Groucho%' and last_name ilike '%Williams%'

#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! 
UPDATE actor SET
first_name = CASE WHEN first_name = 'HARPO' THEN 'GROUCHO' ELSE 'MUCHO GROUCHO'
END
WHERE actor_id = 172;

#5a. 
#What’s the difference between a left join and a right join. 
A left join joins in everything from the left side of a table, even if there are no matches.
A right join  joins in everything from the right side of a table, even if there are no matches.

#What about an inner join and an outer join?
An inner join finds and returns matching data from tables, while an outer join finds and returns matching data and some dissimilar data from tables.


#When would you use rank?
When you want to rank a group or an individual id by a set of data, and you are fine with ties.

#What about dense_rank? 
When you want to do a rank without any gaps, e.g. no ties.

#When would you use a subquery in a select? 
You would use them in instances where you cannott get data through a normal select query, such as when you are trying access the value of a lead or lag
for a comparison. It is also simpler code to write than a join in some instances. (Ex.That Signifyd question)

#When would you use a right join?
When you want the data from the table that is being joined. 

#When would you use an inner join over an outer join?
When you only want values that match on both sides. 
See(Question 6c.)

#What’s the difference between a left outer and a left join
They are the same.

#When would you use a group by?
If you are collecting aggregate data using an SQL function such as count, and want to display that count.
Ex.: select staff_id, count(payment) from payment GROUP BY staff_id;

#Describe how you would do data reformatting

select
   trim('  Software Engineer  ');

In the example above you would be removing spaces.

#When would you use a with clause?
When you are running multiple subqueries on a table and want to easily rename the first one for the purpose of being referenced later on.


#bonus: When would you use a self join?
You would use a self join when trying to access data from a table when you are trying to access information from two different rows 
that have a relationship with each other.
For example, you want to get data from the first row after a row where the first_name is Pavan.

#6a. Use a JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
select s.first_name, s.last_name, a.address from staff s LEFT JOIN address a ON s.address_id = a.address_id;

#6b. Use a JOIN to display the total amount rung up by each staff member in January of 2007. Use tables staff and payment.
select staff.staff_id, staff.first_name, staff.last_name, sum(payment.amount) from staff 
LEFT JOIN payment
ON staff.staff_id = payment.staff_id 
WHERE CAST(payment_date as DATE) < '2007-02-01'
GROUP BY
staff.staff_id;


#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select f.film_id, f.title, count(fa.actor_id) AS actor_number from film f 
INNER JOIN film_actor fa 
ON f.film_id = fa.film_id
GROUP BY
f.film_id;

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select i.film_id, count(i.inventory_id), f.title from inventory i
LEFT JOIN film f
ON 
f.title = 'HUNCHBACK IMPOSSIBLE'
WHERE
i.film_id = f.film_id
GROUP BY
f.title, i.film_id; 

#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select c.first_name, c.last_name, sum(p.amount)
from customer c
LEFT JOIN
payment p
ON
p.customer_id = c.customer_id
GROUP BY
c.first_name, c.last_name
ORDER BY
c.last_name, c.first_name ASC;

#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
#As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
#display the titles of movies starting with the letters K and Q whose language is English.

select film.*, language.name from film 
LEFT JOIN language 
ON language.name = 'English' 
WHERE film.title ilike 'kq%';

#7b. Use subqueries to display all actors who appear in the film Alone Trip.
Select title, first_name, last_name
FROM
( 
	SELECT fa.actor_id, fa.film_id, f.title, a.first_name, a.last_name
	FROM film_actor fa
	LEFT JOIN film f
	ON f.title = 'ALONE TRIP'
	LEFT JOIN actor a
	ON a.actor_id = fa.actor_id
) fm
GROUP BY fm.title, fm.first_name, fm.last_name;

#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
#Use joins to retrieve this information.
Select email, first_name, last_name, address
FROM
( 
	SELECT cu.first_name, cu.last_name, cu.email, a.address
	FROM customer cu
	LEFT JOIN country c
	ON c.country = 'Canada' 
	LEFT JOIN address a
	ON a.address_id = cu.address_id
	LEFT JOIN city ct
	ON a.city_id = ct.city_id
	WHERE
	ct.country_id = c.country_id
) ca
GROUP BY ca.email, ca.first_name, ca.last_name, ca.address;

#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as a family film.
Select  DISTINCT name, title, film_id
FROM
( 
	SELECT c.name, f.title, f.film_id
	FROM film f
	LEFT JOIN category c
	ON c.name ilike 'Family%'
	LEFT JOIN film_category fc
	ON fc.category_id = c.category_id
	WHERE
	fc.film_id = f.film_id
) fm
GROUP BY fm.name, fm.title, fm.film_id
ORDER BY
fm.film_id ASC;

#7e. Display the most frequently rented movies in descending order.
Select title, count(rental_id)
FROM
( 
	SELECT f.title, r.rental_id
	FROM film f
	LEFT JOIN inventory i
	ON i.film_id = f.film_id
	LEFT JOIN rental r
	ON r.inventory_id = i.inventory_id
) fm
GROUP BY fm.title
ORDER BY
fm.count DESC;

#7f. Write a query to display how much business, in dollars, each store brought in.
Select store_id, cast(sum(amount) as money)
FROM
( 
	SELECT s.store_id, p.amount
	FROM store s
	LEFT JOIN customer c
	ON c.store_id = s.store_id
	LEFT JOIN payment p
	ON p.customer_id = c.customer_id
) st
GROUP BY st.store_id;

#7g. Write a query to display for each store its store ID, city, and country.
Select store_id, city, country
FROM
( 
	SELECT s.store_id, ct.city, c.country
	FROM store s
	LEFT JOIN address a
	ON s.address_id = a.address_id
	LEFT JOIN city ct
	ON ct.city_id = a.city_id
	LEFT JOIN country c
	ON ct.country_id = c.country_id
) st
GROUP BY st.store_id, st.city, st.country;

#7h. List the top five genres in gross revenue in descending order. 
Select name, sum(amount)
FROM
(
	Select p.amount, c.name
	from payment p
	Left join rental r
	ON r.rental_id = p.rental_id
	Left join inventory i
	ON i.inventory_id = r.inventory_id
	Left join film f
	ON f.film_id = i.film_id
	Left join film_category fc
	ON fc.film_id = f.film_id
	Left join category c
	ON c.category_id = fc.category_id
) rev
GROUP BY 
rev.name
ORDER BY
sum(rev.amount) DESC LIMIT 5;

#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
#Use the solution from the problem above to create a view. 
CREATE OR REPLACE VIEW top_5 as
Select name, sum(amount)
FROM
(
	Select p.amount, c.name
	from payment p
	Left join rental r
	ON r.rental_id = p.rental_id
	Left join inventory i
	ON i.inventory_id = r.inventory_id
	Left join film f
	ON f.film_id = i.film_id
	Left join film_category fc
	ON fc.film_id = f.film_id
	Left join category c
	ON c.category_id = fc.category_id
) rev
GROUP BY 
rev.name
ORDER BY
sum(rev.amount) DESC LIMIT 5;


#8b. How would you display the view that you created in 8a?
select * from top_5;

#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_5;
















