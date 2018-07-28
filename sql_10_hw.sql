use sakila;

SELECT first_name, last_name FROM actor;

SELECT (UPPER(CONCAT(first_name, " ", last_name))) AS `Actor Name` FROM actor;

SELECT * FROM actor WHERE first_name = 'Joe';

SELECT * FROM actor WHERE last_name LIKE '%gen%';

SELECT last_name, first_name FROM actor WHERE last_name LIKE '%li%' ORDER BY last_name ;

SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE `sakila`.`actor` 
ADD COLUMN `description` BLOB NULL AFTER `last_update`;

ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;

SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name)>1;

SELECT actor_id FROM sakila.actor WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
UPDATE actor 
SET first_name = 'HARPO'
WHERE actor_id = 172;

UPDATE actor 
SET first_name = 'GROUCHO'
WHERE actor_id = 172;

SELECT * FROM actor WHERE actor_id = 172;

SHOW CREATE TABLE address;

SELECT staff.first_name, staff.last_name, address.address 
FROM staff 
JOIN address
ON staff.address_id = address.address_id;

SELECT staff.staff_id, SUM(payment.amount)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY staff.staff_id;

SELECT film.title, COUNT(film_actor.actor_id)
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.film_id;

SELECT film.title, COUNT(inventory.film_id)
FROM inventory
JOIN film
ON inventory.film_id = film.film_id
WHERE film.title = 'HUNCHBACK IMPOSSIBLE'
GROUP BY inventory.film_id;

SELECT customer.last_name, customer.first_name, SUM(payment.amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;

SELECT title
FROM film 
WHERE title LIKE 'K%' OR '%Q' 
AND language_id IN
(
	SELECT language_id FROM `language` WHERE `name` = 'English'
);

SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN
(
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN
    (
		SELECT film_id
        FROM film
        WHERE film.title = 'Alone Trip'
	)
);

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Canada';

SELECT * FROM category;

SELECT film.title
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
WHERE category.`name` = 'Family';

SELECT * FROM rental;
/*inventory_id*/

SELECT * FROM film;

SELECT film.title
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
ORDER BY (rental.rental_date) DESC;

SELECT store.store_id, SUM(payment.amount)
FROM payment
JOIN staff
ON payment.staff_id = staff.staff_id
JOIN store
ON staff.store_id = store.store_id
GROUP BY store.store_id;

SELECT store.store_id, city.city, country.country
FROM store
JOIN address
ON store.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;

SELECT category.`name`, SUM(payment.amount)
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.`name`
ORDER BY (SUM(payment.amount)) DESC
LIMIT 5;

CREATE VIEW `top_five_genres` AS
(
SELECT category.`name`, SUM(payment.amount)
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.`name`
ORDER BY (SUM(payment.amount)) DESC
LIMIT 5
);

SELECT * FROM `top_five_genres`;

DROP VIEW `top_five_genres`;