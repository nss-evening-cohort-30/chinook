-- 1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    country
FROM Customer
WHERE country != 'USA';

-- 2. Provide a query only showing the Customers from Brazil.
SELECT * 
FROM Customer
WHERE country = 'Brazil'


-- 3. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    i.invoice_id AS invoice_id,
    i.invoice_date,
    i.billing_country
FROM Invoice i
JOIN Customer c
    ON i.customer_id = c.customer_id
WHERE c.country = 'Brazil';

-- 4. Provide a query showing only the Employees who are Sales Agents.
SELECT
    employee_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    title
FROM Employee
WHERE title = 'Sales Support Agent';

-- 5. Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT billing_country
FROM Invoice
ORDER BY billing_country;

-- 6. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT 
  CONCAT(e.first_name, ' ', e.last_name) AS sales_agent,
  i.invoice_id AS invoice_id,
  i.invoice_date,
  i.billing_country,
  i.total
FROM Invoice i
JOIN Customer c
  ON c.customer_id = i.customer_id
JOIN Employee e
  ON c.support_rep_id = e.employee_id
ORDER BY sales_agent

-- 7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT
    i.total AS invoice_total,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.country,
    CONCAT(e.first_name, ' ', e.last_name) AS sales_agent
FROM Invoice i
JOIN Customer c
    ON i.customer_id = c.customer_id
JOIN Employee e
    ON c.support_rep_id = e.employee_id
ORDER BY c.country, customer_name, i.total DESC;


-- 8. How many Invoices were there in 2021 and 2022?
SELECT 
    EXTRACT(YEAR FROM invoice_date) AS year,
    COUNT(*) AS invoice_count
FROM Invoice
WHERE EXTRACT(YEAR FROM invoice_date) IN (2021, 2022)
GROUP BY year
ORDER BY year;

-- 9. What are the respective total sales for each of those years?
SELECT 
    EXTRACT(YEAR FROM invoice_date) AS year,
    SUM(total) AS total_sales
FROM Invoice
WHERE EXTRACT(YEAR FROM invoice_date) IN (2021, 2022)
GROUP BY year
ORDER BY year;

-- 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT 
    invoice_id,
    COUNT(*) AS line_item_count
FROM Invoice_Line
WHERE invoice_id = 37
GROUP BY invoice_id;

-- 11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT 
    invoice_id,
    COUNT(*) AS line_item_count
FROM Invoice_Line
GROUP BY invoice_id
ORDER BY invoice_id;

-- 12. Provide a query that includes the purchased track name with each invoice line item.
SELECT 
    il.invoice_line_id,
    il.invoice_id,
    t.name AS track_name,
    il.unit_price,
    il.quantity
FROM Invoice_Line il
JOIN Track t
    ON il.track_id = t.track_id
ORDER BY il.invoice_id, il.invoice_line_id;


-- 13. Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT 
    il.invoice_line_id,
    il.invoice_id,
    t.name AS track_name,
    ar.name AS artist_name,
    il.unit_price,
    il.quantity
FROM Invoice_Line il
JOIN Track t
    ON il.track_id = t.track_id
JOIN Album al
    ON t.album_id = al.album_id
JOIN Artist ar
    ON al.artist_id = ar.artist_id
ORDER BY il.invoice_id, il.invoice_line_id;

-- 14. Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT 
    billing_country,
    COUNT(*) AS invoice_count
FROM Invoice
GROUP BY billing_country
ORDER BY invoice_count DESC;


-- 15. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resulant table.
SELECT 
    p.name AS playlist_name,
    COUNT(pt.track_id) AS track_count
FROM Playlist p
LEFT JOIN Playlist_Track pt
    ON p.playlist_id = pt.playlist_id
GROUP BY p.playlist_id
ORDER BY track_count DESC;

-- 16. Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
SELECT
    t.name AS track_name,
    al.title AS album_name,
    mt.name AS media_type,
    g.name AS genre, 
    t.composer AS composer,
    t.milliseconds AS milliseconds,
    t.bytes AS bytes,
    t.unit_price AS unit_price
FROM Track t
JOIN Album al
    ON t.album_id = al.album_id
JOIN Media_Type mt
    ON t.media_type_id = mt.media_type_id
JOIN Genre g
    ON t.genre_id = g.genre_id
ORDER BY t.name;

-- 17. Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT
    i.invoice_id AS invoice_id,
    i.customer_id,
    i.invoice_date,
    i.billing_country,
    i.total AS invoice_total,
    COUNT(il.invoice_line_id) AS line_item_count
FROM Invoice i
LEFT JOIN Invoice_Line il
    ON i.invoice_id = il.invoice_id
GROUP BY i.invoice_id
ORDER BY i.invoice_id;


-- 18. Provide a query that shows total sales made by each sales agent.
SELECT 
  e.employee_id,
  CONCAT(e.first_name, ' ', e.last_name) AS sales_agent,
  SUM(i.total) AS total_sales
FROM Invoice i
JOIN Customer c
  ON i.customer_id = c.customer_id
JOIN Employee e
  ON c.support_rep_id = e.employee_id
GROUP BY e.employee_id

-- 19. Which sales agent made the most in sales in 2022?
--    Hint: Use the MAX function on a subquery.
WITH agent_sales_2022 AS (
  SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS sales_agent,
    SUM(i.total) AS total_sales
  FROM Invoice i
  JOIN Customer c
    ON i.customer_id = c.customer_id
  JOIN Employee e
    ON c.support_rep_id = e.employee_id
  WHERE EXTRACT(YEAR FROM i.invoice_date) = 2022
  GROUP BY e.employee_id
)

SELECT *
FROM agent_sales_2022
WHERE total_sales = (SELECT MAX(total_sales) FROM agent_sales_2022);


-- 20. Which sales agent made the most in sales over all?
WITH agent_sales_overall AS (
  SELECT 
  e.employee_id,
  CONCAT(e.first_name, ' ', e.last_name) AS sales_agent,
  SUM(i.total) AS total_sales
  FROM Invoice i
  JOIN Customer c
    ON i.customer_id = c.customer_id
  JOIN Employee e
    ON c.support_rep_id = e.employee_id
  GROUP BY e.employee_id
)

SELECT *
FROM agent_sales_overall
WHERE total_sales = (SELECT MAX(total_sales) FROM agent_sales_overall);


-- 21. Provide a query that shows the count of customers assigned to each sales agent.
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS sales_agent,
    COUNT(c.customer_id) AS customer_count
FROM Employee e
JOIN Customer c
    ON e.employee_id = c.support_rep_id
GROUP BY e.employee_id


-- 22. Provide a query that shows the total sales per country.
SELECT
    billing_country,
    SUM(total) AS total_sales
FROM Invoice
GROUP BY billing_country

-- 23. Which country's customers spent the most?
WITH country_sales AS (
    SELECT
        billing_country,
        SUM(total) AS total_sales
    FROM Invoice
    GROUP BY billing_country
)

SELECT *
FROM country_sales
WHERE total_sales = (SELECT MAX(total_sales) FROM country_sales);

-- 24. Provide a query that shows the top 5 most purchased tracks over all.
SELECT
    t.track_id,
    t.name AS track_name,
    SUM(il.quantity) AS total_sold
FROM Invoice_Line il
JOIN Track t
    ON il.track_id = t.track_id
GROUP BY t.track_id, t.name
ORDER BY total_sold DESC
LIMIT 5;

-- 25. Provide a query that shows the top 3 best selling artists.
SELECT
    ar.artist_id,
    ar.name AS artist_name,
    SUM(il.quantity) AS total_sold
FROM Invoice_Line il
JOIN Track t
    ON il.track_id = t.track_id
JOIN Album al
    ON t.album_id = al.album_id
JOIN Artist ar
    ON al.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY total_sold DESC
LIMIT 3;

-- 26. Provide a query that shows the most purchased Media Type.
WITH media_sales AS (
    SELECT
        mt.media_type_id,
        mt.name AS media_type,
        SUM(il.quantity) AS total_sold
    FROM Invoice_Line il
    JOIN Track t
        ON il.track_id = t.track_id
    JOIN Media_Type mt
        ON t.media_type_id = mt.media_type_id
    GROUP BY mt.media_type_id, mt.name
)
SELECT *
FROM media_sales
WHERE total_sold = (SELECT MAX(total_sold) FROM media_sales);