\# Retail Audit \& Store Execution Analysis (SQL Project)



\## 🧠 Project Overview



This project analyzes retail audit data collected from point-of-sale locations (PDVs), focusing on product availability, pricing deviations, and store execution compliance.



The goal is to evaluate how well stores comply with merchandising standards, pricing consistency, and operational execution rules such as FEFO and shelf organization.



\---



\## 🎯 Objectives



\* Measure product availability (on-shelf presence)

\* Identify stock gaps by category and store type

\* Analyze pricing deviations between reported and reference prices

\* Detect execution issues (FEFO compliance, expired products, shelf conditions)



\---



\## 🛠️ Tools \& Technologies



\* SQL (PostgreSQL / relational database)

\* Data modeling with dimension and fact tables

\* CTEs and window functions

\* Conditional aggregation

\* Data quality validation techniques



\---



\## 🗂️ Data Model



The project is based on the following tables:



\* \*\*dim\_pdv\*\* → Store / point of sale information

\* \*\*dim\_productos\*\* → Product master data

\* \*\*hechos\_encuestas\*\* → Field audit / survey data



\---



\## 🔍 Key Analyses



\### 📦 Product Availability (Coverage)



\* PDVs with missing products

\* Availability rate by product category

\* Availability rate by store type (tipo\_pdv)



\### 💰 Price Analysis



\* Comparison between reported vs reference prices

\* Identification of pricing deviations

\* Classification of deviation severity (minor / major)



\### 🏪 Store Execution Quality



\* FEFO compliance (First Expired First Out)

\* Presence of expired products in store

\* Shelf invasion issues

\* Checkout product presence



\---



\## 📊 Key Business Insights



\* Certain product categories show lower availability rates across PDVs

\* Significant pricing deviations were detected in specific stores

\* Execution compliance issues (FEFO, expired products) indicate operational gaps in retail standards



\---



\## 📌 SQL Techniques Used



\* JOINs (FULL, INNER)

\* CASE WHEN logic for business rules

\* CTEs for modular queries

\* Aggregations with GROUP BY

\* String manipulation (SPLIT\_PART, SUBSTRING)

\* Conditional KPIs and percentage calculations



\---



\## 🚀 How to Use



1\. Load tables: `dim\_pdv`, `dim\_productos`, `hechos\_encuestas`

2\. Run queries from `queries.sql`

3\. Analyze outputs per business domain (coverage, price, execution)



\---



\## 📫 Author



\*\*Belen Benitez\*\*

Data Engineering Student | ETL | SQL | Power BI | BI Analytics



