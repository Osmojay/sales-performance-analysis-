IF OBJECT_ID('loads', 'U') IS NOT NULL DROP TABLE loads;
IF OBJECT_ID('customers', 'U') IS NOT NULL DROP TABLE customers;

-- Create Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_type VARCHAR(30),           -- Contract / Dedicated / Spot
    credit_terms_days INT,
    primary_freight_type VARCHAR(50),
    account_status VARCHAR(20),           -- Active / Inactive
    contract_start_date DATE,
    annual_revenue_potential DECIMAL(15,2)
); -- Created a customer master table to store account-level and contract information.


-- Create Loads Table
CREATE TABLE loads (
    load_id INT PRIMARY KEY,
    customer_id VARCHAR(20),
    route_id INT,
    load_date DATE,
    load_type VARCHAR(50),
    weight_lbs INT,
    pieces INT,
    revenue DECIMAL(12,2),
    fuel_surcharge DECIMAL(12,2),
    accessorial_charges DECIMAL(12,2),
    load_status VARCHAR(30),              -- Completed / Cancelled
    booking_type VARCHAR(30),             -- Spot / Dedicated
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
); -- Created a transactional loads table with a foreign key relationship to customers.




-- Insert customers data (manually created, realistic)

INSERT INTO customers VALUES
('C001', 'Alpha Logistics', 'Contract', 30, 'General Freight', 'Active', '2022-01-15', 500000),
('C002', 'Beta Traders', 'Spot', 15, 'Retail', 'Active', '2023-03-10', 120000),
('C003', 'Gamma Manufacturing', 'Dedicated', 45, 'Industrial', 'Active', '2021-07-01', 750000),
('C004', 'Delta Supplies', 'Contract', 30, 'Construction', 'Inactive', '2020-11-20', 300000),
('C005', 'Epsilon Foods', 'Dedicated', 30, 'Food & Beverage', 'Active', '2022-06-05', 620000);
-- Inserted sample customer data representing different customer types, industries, and account statuses.



--- Insert loads data (transactional)
INSERT INTO loads VALUES
(101, 'C001', 10, '2024-01-05', 'Full Truckload', 20000, 20, 4500, 300, 150, 'Completed', 'Contract'),
(102, 'C001', 11, '2024-01-18', 'Partial', 12000, 12, 2800, 180, 80, 'Completed', 'Contract'),
(103, 'C002', 12, '2024-02-02', 'Full Truckload', 18000, 18, 3900, 260, 100, 'Cancelled', 'Spot'),
(104, 'C002', 13, '2024-02-20', 'Partial', 9000, 9, 2100, 150, 60, 'Completed', 'Spot'),
(105, 'C003', 14, '2024-03-01', 'Full Truckload', 25000, 25, 5200, 350, 200, 'Completed', 'Dedicated'),
(106, 'C003', 15, '2024-03-15', 'Full Truckload', 24000, 24, 5100, 340, 190, 'Completed', 'Dedicated'),
(107, 'C005', 16, '2024-04-05', 'Partial', 11000, 11, 2600, 170, 90, 'Completed', 'Dedicated'),
(108, 'C005', 17, '2024-04-18', 'Full Truckload', 23000, 23, 5000, 330, 180, 'Cancelled', 'Dedicated');



