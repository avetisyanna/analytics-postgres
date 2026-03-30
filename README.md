# SQL Analytics Portfolio

This project demonstrates **Advanced SQL techniques** for business intelligence and sales performance analysis. It utilizes a containerized PostgreSQL environment to perform complex data transformations, time-series analysis, and statistical distributions.

---

## Project Overview

The goal of this project is to:
- Deploy a containerized PostgreSQL environment using Docker, establishing a reproducible and isolated foundation for high-performance analytics.  
- Architect robust DDL (Data Definition Language) with optimized data types and relational constraints to ensure data integrity across complex datasets.  
- Implement sophisticated query logic to evaluate business growth, sales velocity, and relative performance benchmarks against global datasets.
- Translate raw transactional data into actionable insights, focusing on identifying top-tier performers and uncovering hidden trends in time-series data. 

---

## 🛠️ Advanced SQL Implementations (In Progress)

Time-Series Analytics

Performance Benchmarking

Statistical Distribution Modeling

---

## Tech Stack

- PostgreSQL  
- Docker & Docker Compose  
- pgAdmin  
- SQL  

---

## Repository Structure

```text
sql-analytics-portfolio/
│
├── data/ # CSV datasets
├── init/ # Schema and ETL SQL scripts
├── docker-compose.yaml # PostgreSQL & pgAdmin setup
├── .env # Environment variables
├── .gitignore
└── README.md
```
---

## How to Run the Project

1. **Clone the repository**
   ```bash
   git clone https://github.com/avetisyanna/analytics-postgresql.git
2. **Navigate into the project folder**
   cd analytics-postgresql
3. **Start the containers**
   docker-compose up -d
4. **Access the services**
   PostgreSQL: localhost:5432
   pgAdmin: localhost:5050