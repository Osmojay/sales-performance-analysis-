-- Basic Joins.
/* Business Question
Which customers are associated with each load? */
-- INNER JOINT
SELECT
    l.load_id,
    c.customer_name,
    c.customer_type,
    l.load_date,
    l.load_status,
    l.revenue
FROM loads l
INNER JOIN customers c
    ON l.customer_id = c.customer_id

/* JOIN Logic (simple explanation)
loads contains transaction data
customers contains customer details customer_id links both tables
INNER JOIN returns only matching records */

/* Joined the loads and customers tables using customer_id to
associate each shipment with customer details for analysis.*/


------------------------------------------------------------------------------



-- Task: Total Revenue by Customer
-- INNER JOIN + GROUP
/* Business Question
Which customers generate the most revenue? */

SELECT 
c.customer_id,
c.customer_name,
c.customer_type,
COUNT(l.load_id) Total_load,
SUM(l.revenue) Total_revenue,
AVG(l.revenue) Avg_revenue_per_load
FROM customers c
INNER JOIN loads l
      ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.customer_name, c.customer_type
ORDER BY Total_revenue

/* JOIN & AGG Logic
Join customers to loads using customer_id Group results by customer
Aggregate revenue and load countSort to identify
top-performing customers */

/* Combined customer and load data to calculate total and
average revenue per customer, helping identify top revenue-generating accounts. */


------------------------------------------------------------------------------


-- Left Join
-- Task: Active Customers With No Loads
/* Business Question
Which active customers have not placed any loads? */

/* This helps identify:
Inactive revenue opportunities Customer churn risk
Sales follow up targets */
SELECT 
c.customer_id,
c.customer_name,
c.customer_type,
c.account_status
FROM customers c
LEFT JOIN loads l
     ON c.customer_id = l.customer_id
WHERE l.load_id IS NULL AND c.account_status = 'Active'

/* LEFT JOIN keeps all customers
Loads that don’t exist return NULL
Filtering l.load_id IS NULL finds customers with no shipments */

/*Used a LEFT JOIN to identify active customers without
any associated load records, highlighting potential revenue opportunitie */


-----------------------------------------------------------------------------------------------


-- INNER JOIN
-- Task: Revenue by Customer Type & Booking Type
/* Business Question
How does revenue vary by customer type and booking type? */

/* This helps the business understand:
Which customer segments are most valuable
Whether Spot or Dedicated bookings perform better per segment */
 
SELECT
    c.customer_type,
    l.booking_type,
    COUNT(l.load_id) AS total_loads,
    SUM(l.revenue) AS total_revenue,
    AVG(l.revenue) AS avg_revenue_per_load
FROM customers c
INNER JOIN loads l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_type, l.booking_type
ORDER BY  total_revenue DESC

/* Logic Explained Join customers with loads
Group by both customer type and booking type Aggregate load 
volume and revenue Compare performance across segments */

/* Analyzed shipment performance by customer segment and
booking type to evaluate revenue contribution across business categories. */

-----------------------------------------------------------------------------------------------




-- Task: Top 5 Customers by Completed Load Revenue
/*Business Question
Who are the top 5 customers based on revenue from completed loads? */

-- SQL Query (JOIN + WHERE + GROUP BY + TOP)

SELECT TOP 5
c.customer_id,
c.customer_name,
c.customer_type,
COUNT(l.load_id) Total_loads,
SUM(l.revenue) Total_revenue
FROM customers c
INNER JOIN loads l
     ON c.customer_id = l.customer_id
WHERE l.load_status = 'Completed'
GROUP BY c.customer_id, c.customer_name, c.customer_type
ORDER BY Total_revenue

/* Logic Breakdown Join customers with loads
Filter to completed loads only Aggregate revenue per customer
Sort and return top 5 */

/*Identified the top 5 customers by revenue from completed
shipments using join operations, filtering, and aggregation. */


----------------------------------------------------------------------------------------


-- Task: Completed vs Cancelled Load Impact by Customer
/* Business Question
How do completed and cancelled loads impact revenue and volume for each customer?
This helps businesses understand:
-Revenue loss due to cancellations
-Customer reliability
-Operational efficiency */

-- SQL Query (JOIN + Conditional Aggregation)
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(CASE WHEN l.load_status = 'Completed' THEN 1 END) completed_loads,
    SUM(CASE WHEN l.load_status = 'Completed' THEN l.revenue ELSE 0 END) completed_revenue,
    COUNT(CASE WHEN l.load_status = 'Cancelled' THEN 1 END) cancelled_loads,
    SUM(CASE WHEN l.load_status = 'Cancelled' THEN l.revenue ELSE 0 END) cancelled_revenue
FROM customers c
INNER JOIN loads l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY completed_revenue DESC

/* Logic Explained (simple & clear) Join customers and loads
Use conditional aggregation with CASE WHEN Count and sum revenue by load status
Compare completed vs cancelled performance */

/*Used conditional aggregation on joined customer and load data to compare completed
and cancelled shipment volume and revenue impact per customer.*/

----------------------------------------------------------------------------------------
