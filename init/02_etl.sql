-- Connect to the target database
\c "MyDatabase"

-- Clean up existing data to ensure a fresh load
TRUNCATE TABLE customers RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

\echo 'Loading customers data...'
COPY customers(id, first_name, country, score)
FROM '/docker-entrypoint-initdb.d/data/customers.csv'
WITH (FORMAT csv, HEADER true);

\echo 'Loading orders data...'
COPY orders(order_id, customer_id, order_date, sales)
FROM '/docker-entrypoint-initdb.d/data/orders.csv'
WITH (FORMAT csv, HEADER true);

\echo 'Data load complete.'