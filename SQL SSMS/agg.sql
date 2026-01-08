-- Single-table Aggregations (loads)
-- Task 1: Load Performance Overview
/* Question:
How many loads exist, how much revenue is generated, and 
what is the average revenue per load? */
SELECT 
COUNT(*) Total_loads,
SUM(revenue) Total_Revenue,
AVG(revenue) Avg_revenue_per_load
FROM loads

/* Explanation 
Performed an aggregation analysis on the loads table to
understand overall shipment volume and revenue performance. */

---------------------------------------------------------------------------
/* Business Question
How many loads are completed vs cancelled, and how much 
revenue does each status generate? */
SELECT 
load_status,
COUNT(*) Total_load,
SUM(revenue) Total_revenue,
AVG(revenue) Avg_revenue
FROM loads
GROUP BY load_status

/* Aggregated load data by load status to evaluate operational performance and 
revenue impact of completed versus cancelled shipments.*/

----------------------------------------------------------------------------------


/* Business Question
How does revenue differ between Spot and Dedicated bookings? */

SELECT 
booking_type,
COUNT(*),
SUM(revenue) Total_revenue,
AVG(revenue) Avg_revenue
FROM loads
GROUP BY booking_type

/*Analyzed load volume and revenue by booking type to 
understand the performance of spot versus dedicated shipments.*/




---------------------------------------------------------------------------------


/*Business Question
How do load volume and revenue trend over time?*/
SELECT 
YEAR(load_date) Load_year,
MONTH(load_date) Load_month,
COUNT(*) Total_loads,
SUM(revenue) Total_revenue
FROM loads
GROUP BY YEAR(load_date), MONTH(load_date)
ORDER BY Load_year, Load_month

/* Performed time-based aggregation on load data to identify 
monthly trends in shipment volume and revenue. */



------------------------------------------------------------------------

