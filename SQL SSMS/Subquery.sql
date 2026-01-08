/* Subquery – Above Average Revenue Loads
Business Question:
Which loads have revenue higher than the average load revenue? */
SELECT
    load_id,
    customer_id,
    revenue
FROM loads
WHERE revenue >
    (SELECT AVG(revenue) FROM loads)

/* Used a subquery to compare individual load revenue against
the overall average revenue. */


---------------------------------------------------------------------------------------




/* Subquery – Customers Above Overall Average Revenue
Business Question:
Which customers generate more revenue than the average customer?
SQL (Subquery + JOIN) */
SELECT
    c.customer_id,
    c.customer_name,
    SUM(l.revenue) AS total_revenue
FROM customers c
INNER JOIN loads l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(l.revenue) >
    (
        SELECT AVG(customer_revenue)
        FROM (
            SELECT
                SUM(revenue) AS customer_revenue
            FROM loads
            GROUP BY customer_id
        ) t
    )
ORDER BY total_revenue DESC

/* Used nested subqueries to compare customer revenue against the
overall average revenue per customer. */


------------------------------------------------------------------------------------------
