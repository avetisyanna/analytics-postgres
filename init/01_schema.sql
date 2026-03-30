-- Connect to default to create the new DB
\c postgres
DROP DATABASE IF EXISTS salesdb;
CREATE DATABASE salesdb;

-- Connect to salesdb
\c salesdb

-- Create the Sales Schema
CREATE SCHEMA sales;

-- 1. Customers
CREATE TABLE sales.customers (
    customerid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    country VARCHAR(50),
    score INT
);

-- 2. Employees
CREATE TABLE sales.employees (
    employeeid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    department VARCHAR(50),
    birthdate DATE,
    gender CHAR(1),
    salary INT,
    managerid INT
);

-- 3. Products
CREATE TABLE sales.products (
    productid INT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    price INT
);

-- 4. Orders
CREATE TABLE sales.orders (
    orderid INT PRIMARY KEY,
    productid INT,
    customerid INT,
    salespersonid INT,
    orderdate DATE,
    shipdate DATE,
    orderstatus VARCHAR(50),
    shipaddress VARCHAR(255),
    billaddress VARCHAR(255),
    quantity INT,
    sales INT,
    creationtime TIMESTAMP
);

-- 5. Orders Archive
CREATE TABLE sales.ordersarchive (
    orderid INT,
    productid INT,
    customerid INT,
    salespersonid INT,
    orderdate DATE,
    shipdate DATE,
    orderstatus VARCHAR(50),
    shipaddress VARCHAR(255),
    billaddress VARCHAR(255),
    quantity INT,
    sales INT,
    creationtime TIMESTAMP
);