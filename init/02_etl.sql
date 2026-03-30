\c salesdb

-- Using the schema name (sales.) is required here!
\echo 'Loading Customers...'
COPY sales.customers FROM '/docker-entrypoint-initdb.d/data/Customers.csv' WITH (FORMAT csv, HEADER true);

\echo 'Loading Employees...'
COPY sales.employees FROM '/docker-entrypoint-initdb.d/data/Employees.csv' WITH (FORMAT csv, HEADER true);

\echo 'Loading Products...'
COPY sales.products FROM '/docker-entrypoint-initdb.d/data/Products.csv' WITH (FORMAT csv, HEADER true);

\echo 'Loading Orders...'
COPY sales.orders FROM '/docker-entrypoint-initdb.d/data/Orders.csv' WITH (FORMAT csv, HEADER true);

\echo 'Loading Orders Archive...'
COPY sales.ordersarchive FROM '/docker-entrypoint-initdb.d/data/OrdersArchive.csv' WITH (FORMAT csv, HEADER true);