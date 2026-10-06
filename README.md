# 🛠️ IT Service Desk & Incident Management Analytics (T-SQL)

## 📌 Project Overview
This repository contains an end-to-end database and business analytics project simulating an **IT Service Desk & Incident Management System**. 

The project demonstrates full-stack relational database administration and business intelligence capabilities using Microsoft SQL Server (T-SQL), including:
- **Relational Schema Design & Constraints**
- **Data Ingestion & Cleansing**
- **Agent, Customer, and Interaction Performance Analytics**
- **Data Quality & Integrity Verification**
- **Executive Business Insights for SLA & Operational Optimization**

---

## 📁 Repository Structure & Workflow

The SQL scripts in this repository are organized sequentially to maintain a modular and reproducible execution flow:

1. `01_Create_Tables.sql`
   - Defines the relational database schema, tables, foreign key constraints, primary keys, and data types for Agents, Customers, and Service Desk Interactions.

2. `02_Insert_Data.sql`
   - Populates the baseline tables with initial sample records (Proof of Concept dataset).

3. `03_Expand_Demo_Data.sql`
   - Programmatically expands the dataset into a realistic volume of 1,000+ records while applying data cleansing rules (correcting logic anomalies and duplicates).

4. `04_Agent_Analysis.sql`
   - Evaluates support agent performance, resolution velocity, average handling times, and individual CSAT scores.

5. `05_Customer_Analysis.sql`
   - Analyzes customer ticket distribution, recurring incident categories, and department-level demand.

6. `06_Interaction_Analysis.sql`
   - Measures interaction metrics, ticket resolution trends, SLA compliance rates, and priority-based volume distributions.

7. `07_Data_Quality_Checks.sql`
   - Executes validation queries to verify data integrity, detect null/orphaned records, and confirm timestamp logical consistency across resolution metrics.

8. `08_Final_Business_Insights.sql`
   - Aggregates top-level KPI metrics, SLA breach root-cause summaries, and strategic recommendations for IT leadership.

---

## 🛠️️ Tools & Technologies
- **Database Engine:** Microsoft SQL Server (SSMS / T-SQL)
- **Key Concepts:** DDL, DML, Window Functions, Aggregate CTEs, Conditional Aggregation (`CASE WHEN`), Data Cleansing, Data Validation, Foreign Key Constraints.

---

## 💡 Key Business Outcomes & Findings
- **SLA Tracking:** Identified peak ticket volume periods and priority levels causing SLA breaches.
- **Agent Efficiency:** Highlighted high-performing support tiers and workload distribution across teams.
- **Quality Assurance:** Ensured 100% data integrity through automated audit and sanity checks.
