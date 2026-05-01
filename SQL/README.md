# 📊 Customer Purchase Behavior & Revenue Analysis (SQL Project)

## 📌 Project Overview

This project focuses on analyzing a bike sales dataset using SQL.
The objective is to extract meaningful business insights across revenue, product performance, demographics, and regional trends.

---

## 🧱 Data Model

The dataset is structured using a **Star Schema**:

* **Fact_Sales** → Revenue, Profit, Order Quantity
* **Date Dimension**
* **Customer Dimension**
* **Product Dimension**
* **Location Dimension**

---

## 🛠️ Tools Used

* SQL Server (SSMS)

---

## 📂 SQL Queries

All queries are available in:

```
analysis_queries.sql
```

---

## 🔍 Analysis Performed

### 🔹 Business KPIs

* Total Revenue
* Total Profit
* Total Orders
* Average Order Value

---

### 🔹 Time Analysis

* Monthly Revenue & Profit
* Running Total Revenue
* Best Performing Month

---

### 🔹 Product Analysis

* Top 10 Products by Revenue
* Most Profitable Products
* Category-wise Revenue
* Category-wise Profit Margin
* Revenue Contribution %
* Top Product per Category

---

### 🔹 Demographic Analysis

* Revenue by Age Group
* Revenue by Gender
* Most Profitable Age Group
* Profit by Gender
* Product Preference by Age Group

---

### 🔹 Regional Analysis

* Revenue by State
* Top 5 States by Revenue
* Profit by Country

---

## 📈 Key SQL Techniques Used

* Aggregations (`SUM`, `AVG`, `COUNT`)
* Joins (Fact ↔ Dimension tables)
* Window Functions (`ROW_NUMBER`, `DENSE_RANK`, `RANK`)
* Common Table Expressions (CTEs)
* Ranking & Contribution Analysis

---

## 🚀 Key Insights

* Revenue is concentrated in a few top-performing categories (Pareto effect)
* Certain regions contribute significantly more to overall revenue
* Customer demographics influence product demand patterns


