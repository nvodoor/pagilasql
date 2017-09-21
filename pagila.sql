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

