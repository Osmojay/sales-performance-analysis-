/* CTE – Customer Revenue Ranking
Business Question:
Rank customers by total completed load revenue. */
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(l.revenue) AS total_revenue
    FROM customers c
    INNER JOIN loads l
        ON c.customer_id = l.customer_id
    WHERE l.load_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customer_revenue;

/* Used a Common Table Expression (CTE) to calculate customer 
revenue and apply ranking for performance comparison. */

