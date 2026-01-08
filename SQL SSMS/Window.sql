/* Window Function – Running Total Revenue by Date
Business Question:
How does cumulative revenue grow over time? */
SELECT
    load_date,
    revenue,
    SUM(revenue) OVER (
        ORDER BY load_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_revenue
FROM loads
WHERE load_status = 'Completed'
ORDER BY load_date

/* Applied a window function to calculate running total revenue 
over time without collapsing rows. */

--------------------------------------------------------------------------------------------


/*Business Question
What percentage of total revenue does each customer contribute? */
SELECT
    c.customer_name,
    SUM(l.revenue) AS customer_revenue,
    ROUND(
        SUM(l.revenue) * 100.0 /
        SUM(SUM(l.revenue)) OVER (),
        2
    ) AS revenue_percentage
FROM customers c
INNER JOIN loads l
    ON c.customer_id = l.customer_id
WHERE l.load_status = 'Completed'
GROUP BY c.customer_name
ORDER BY revenue_percentage DESC

/* Used window functions to calculate each customer’s
percentage contribution to total revenue. */

------------------------------------------------------------------------------------------



/* Business Question
What is the highest revenue load per customer? */
WITH ranked_loads AS (
    SELECT
        load_id,
        customer_id,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY revenue DESC
        ) AS rn
    FROM loads
)
SELECT
    load_id,
    customer_id,
    revenue
FROM ranked_loads
WHERE rn = 1;

/* Used ROW_NUMBER with partitioning to identify 
the highest revenue load for each customer.*/

----------------------------------------------------------------------------------------




/* Window Function – Month-over-Month Revenue Growth
Business Question:
How does revenue change month over month?
SQL (CTE + LAG) */

WITH monthly_revenue AS (
    SELECT
        YEAR(load_date) AS load_year,
        MONTH(load_date) AS load_month,
        SUM(revenue) AS monthly_revenue
    FROM loads
    WHERE load_status = 'Completed'
    GROUP BY YEAR(load_date), MONTH(load_date)
)
SELECT
    load_year,
    load_month,
    monthly_revenue,
    monthly_revenue 
        - LAG(monthly_revenue) OVER (
            ORDER BY load_year, load_month
        ) AS revenue_change
FROM monthly_revenue
ORDER BY load_year, load_month;

/* Used a CTE and the LAG window function to calculate
month-over-month revenue changes. */
