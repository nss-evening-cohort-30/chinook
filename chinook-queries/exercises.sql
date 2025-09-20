-- 1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  customer_id, 
  country
FROM Customer
WHERE country != 'USA'


-- 2. Provide a query only showing the Customers from Brazil.
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  customer_id, 
  country
FROM Customer
WHERE country = 'Brazil'

-- 3. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  i.invoice_id,
  i.invoice_date,
  i.billing_country
FROM Invoice i 
JOIN Customer c
  ON i.customer_id = c.customer_id
WHERE c.country = 'Brazil'

-- 4. Provide a query showing only the Employees who are Sales Agents.
SELECT * 
FROM Employee
WHERE title = 'Sales Support Agent'

-- 5. Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT 
  DISTINCT billing_country
FROM Invoice

-- 6. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT 
  i.*,
  CONCAT(e.first_name, ' ', e.last_name) AS sales_agent
FROM Invoice i
JOIN Customer c
  ON i.customer_id = c.customer_id
JOIN Employee e
  ON c.support_rep_id = e.employee_id

-- 7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT 
  i.invoice_id,
  i.total,
  CONCAT(c.first_name, ' ', c.last_name) AS customer,
  i.billing_country,
  CONCAT(e.first_name, ' ', e.last_name) AS sales_agent
FROM Invoice i
JOIN Customer c
  ON i.customer_id = c.customer_id
JOIN Employee e
  ON c.support_rep_id = e.employee_id


-- 8. How many Invoices were there in 2021 and 2022?
SELECT 
  COUNT(i.invoice_id),
  COUNT(i.invoice_id) AS total,
  EXTRACT(year FROM i.invoice_date) AS year
FROM Invoice i
WHERE EXTRACT(year FROM i.invoice_date) between '2021' AND '2022'
GROUP BY EXTRACT(year FROM i.invoice_date)

SELECT 
  COUNT(i.invoice_id)
FROM Invoice i
WHERE EXTRACT(year FROM i.invoice_date) between '2021' AND '2022'

-- 9. What are the respective total sales for each of those years?
SELECT 
  SUM(i.total) AS total_sales,
  EXTRACT(year FROM i.invoice_date) AS year
FROM Invoice i
WHERE EXTRACT(year FROM i.invoice_date) between '2021' AND '2022'
GROUP BY EXTRACT(year FROM i.invoice_date)


-- 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.


-- 11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY


-- 12. Provide a query that includes the purchased track name with each invoice line item.


-- 13. Provide a query that includes the purchased track name AND artist name with each invoice line item.


-- 14. Provide a query that shows the # of invoices per country. HINT: GROUP BY


-- 15. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.


-- 16. Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.


-- 17. Provide a query that shows all Invoices but includes the # of invoice line items.


-- 18. Provide a query that shows total sales made by each sales agent.


-- 19. Which sales agent made the most in sales in 2009?
--    Hint: Use the MAX function on a subquery.


-- 20. Which sales agent made the most in sales over all?


-- 21. Provide a query that shows the count of customers assigned to each sales agent.


-- 22. Provide a query that shows the total sales per country.


-- 23. Which country's customers spent the most?


-- 24. Provide a query that shows the most purchased track of 2013.


-- 25. Provide a query that shows the top 5 most purchased tracks over all.


-- 26. Provide a query that shows the top 3 best selling artists.


-- 27. Provide a query that shows the most purchased Media Type.