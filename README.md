# 🛠️ IT Service Desk & Incident Management Analytics (SQL Server & Power BI)

## 📌 Project Overview
This repository contains an end-to-end data analytics project simulating an **IT Service Desk & Incident Management System**. 

The project covers the complete data pipeline: from database schema architecture and T-SQL data cleansing/expansion in **Microsoft SQL Server**, to interactive data modeling, DAX measure creation, and executive reporting in **Power BI**.

---

## 🏗️ Architecture & Analytical Workflow

1. **Relational Database Design (`01_Create_Tables.sql`)**
   - Built a normalized database schema in SQL Server containing `Customers`, `Agents`, and `Interactions` tables with primary/foreign key relationships.

2. **Data Ingestion & Programmatic Expansion (`02_Insert_Data.sql`, `03_Expand_Demo_Data.sql`)**
   - Cleansed initial baseline anomalies (negative resolution durations, duplicate ticket records).
   - Programmatically generated a realistic 1,000+ record dataset using transaction-safe SQL logic (`TRY/CATCH`, `NOT EXISTS`) with realistic SLA, priority, and CSAT distributions.

3. **T-SQL Performance Analytics (`04` to `08` SQL Scripts)**
   - Performed deep-dive queries on agent workloads, customer ticket volumes, channel efficiency, and SLA compliance metrics.

4. **Power BI Dashboard & Visual Reporting (`IT_Service_Desk_Analysis.pbix`)**
   - Built a Star Schema data model and calculated key DAX metrics.
   - Designed an executive overview dashboard tracking ticket channels, team workload distribution, SLA breach trends, and customer-level priority breakdowns.

---

## 📁 Repository Structure

- `01_Create_Tables.sql` - Database schema, table definitions, and constraints.
- `02_Insert_Data.sql` - Baseline initial records.
- `03_Expand_Demo_Data.sql` - Data cleansing rules and safe 1,000+ row data expansion.
- `04_Agent_Analysis.sql` - Agent handling times, ticket counts, and individual performance.
- `05_Customer_Analysis.sql` - Customer segment and priority-level volume distribution.
- `06_Interaction_Analysis.sql` - Support channel volumes and SLA compliance breakdown.
- `07_Data_Quality_Checks.sql` - Automated data integrity and timestamp validation scripts.
- `08_Final_Business_Insights.sql` - High-level KPI aggregates and operational summaries.
- `IT_Service_Desk_Analysis.pbix` - Interactive Power BI report file.

---

## 📊 Executive Insights & Operational Findings (Dashboard Summary)

- **Total Volume & SLA:** Processed **1,010 total tickets** with an overall **77% SLA Compliance Rate** and an average resolution time of **91.39 minutes**.
- **Customer Satisfaction:** Achieved an overall **4.14 / 5.0 Average CSAT Score**.
- **Workload Concentration:** **Tier 1 Service Desk** handles **50.0%** of total ticket volume, acting as the primary first-line support triage.
- **Top Enterprise Client:** **Siemens Energy** generated the highest demand with **203 tickets** (20.1% of total volume), including 31 Critical priority incidents.

---

## 🛠️ Tools & Technologies
- **SQL / Database:** Microsoft SQL Server, T-SQL (DDL, DML, CTEs, Window Functions, Data Cleansing)
- **Business Intelligence:** Power BI Desktop, DAX, Power Query, Data Modeling (Star Schema)
