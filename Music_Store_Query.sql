/* Q1: Who is the senior most employee based on job title? */

SELECT  title, last_name, first_name
FROM employee
ORDER BY title DESC;

/* Q2: Which countries have the most Invoices? */

SELECT billing_country, COUNT(*) AS no_of_invoices
FROM invoice
GROUP BY billing_country
ORDER BY no_of_invoices DESC;

/* Q3. What are top 3 values of total invoice? */

SELECT invoice_id, SUM(total) AS total_invoices 
FROM invoice
GROUP BY invoice_id
ORDER BY total_invoices DESC ;

/* Q4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals */

SELECT TOP 1 billing_city AS city_name, SUM(Total) AS invoice_total
FROM invoice	
GROUP BY billing_city
ORDER BY invoice_total DESC ;

/* Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer.
Write a query that returns the person who has spent the most money */

SELECT TOP 1 i.customer_id, first_name, last_name, SUM(total) AS total_spend
FROM invoice i
JOIN customer c ON i.customer_id=c.customer_id
GROUP BY i.customer_id, first_name, last_name
ORDER BY total_spend DESC;

/* Q6. Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
Return your list ordered alphabetically by email starting with A */

SELECT DISTINCT email,first_name, last_name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track t
	JOIN genre g ON t.genre_id = g.genre_id
	WHERE g.name LIKE 'Rock'
)
ORDER BY email;

/* Q7. Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands */

SELECT TOP 10 a.name AS artist_name, COUNT(track_id) AS track_count
FROM artist a
JOIN album al ON a.artist_id=al.artist_id
JOIN track t ON al.album_id=t.album_id
JOIN genre g ON t.genre_id=g.genre_id
WHERE g.name LIKE 'rock'
GROUP BY a.name
ORDER BY track_count DESC ;

 /*Q8 : Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */


SELECT name, milliseconds
FROM track
WHERE milliseconds > ( SELECT AVG(milliseconds) FROM track
)
ORDER BY milliseconds DESC;

/* Q9 : Find how much amount spent by each customer on Top selling artist? Write a query to return
customer name, artist name and total spent */

WITH best_selling_artist AS (
SELECT TOP 1 ar.artist_id, ar.name, ROUND(SUM(il.unit_price*il.quantity),2) AS total_sells
FROM invoice_line il 
JOIN track t ON il.track_id=t.track_id
JOIN album al ON t.album_id=al.album_id
JOIN artist ar ON al.artist_id=ar.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY total_sells DESC 
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.name AS artist_name, ROUND(SUM(il.unit_price*il.quantity),2) AS total_spend
FROM customer c
JOIN invoice i ON c.customer_id=i.customer_id
JOIN invoice_line il ON i.invoice_id=il.invoice_id
JOIN track t ON il.track_id=t.track_id
JOIN album al ON t.album_id=al.album_id
JOIN best_selling_artist bsa ON al.artist_id=bsa.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.name
ORDER BY total_spend DESC ;

/* Q10. We want to find out the most popular music Genre for each country. We determine the
most popular genre as the genre with the highest amount of purchases. Write a query
that returns each country along with the top Genre. For countries where the maximum
number of purchases is shared return all Genres */

WITH popular_genre AS (
SELECT g.name, i.billing_country AS country, COUNT(quantity) AS purchases,
ROW_NUMBER() OVER (PARTITION BY i.billing_country ORDER BY COUNT(quantity) DESC ) AS row_num
FROM invoice i 
JOIN invoice_line il ON i.invoice_id=il.invoice_id
JOIN track t ON il.track_id=t.track_id
JOIN genre g ON t.genre_id=g.genre_id
GROUP BY g.name, i.billing_country
)
SELECT * FROM popular_genre 
WHERE row_num <= 1 ;

/* Q11. Write a query that determines the customer that has spent the most on music for each
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all
customers who spent this amount */

WITH best_customers AS (
SELECT c.customer_id, first_name, last_name, billing_country AS country, ROUND(SUM(total),2) AS total_spent,
RANK() OVER (PARTITION BY billing_country ORDER BY SUM(total) DESC ) AS ranking
FROM invoice i 
JOIN customer c ON i.customer_id=c.customer_id
GROUP by c.customer_id, first_name, last_name, billing_country
)
SELECT * 
FROM best_customers bc
WHERE bc.ranking <=1 ;