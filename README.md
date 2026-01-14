# SQL-Project  
## 🛒 Olist Brazilian E-Commerce SQL Project  
**Data Analytics Portfolio Project – Flor Hoyos**

This project analyzes the Olist Brazilian E-Commerce dataset using PostgreSQL .
I built a complete relational database, validated the data, performed exploratory analysis,
and generated business insights related to sales, customer behavior, delivery performance, and seller operations.

---

## 📂 Project Structure

### 🧱 1. Database Schema
All 9 Olist tables were recreated in PostgreSQL with correct data types and foreign key relationships:

- `customers`
- `orders`
- `products`
- `order_items`
- `order_payments`
- `order_reviews`
- `geolocation`
- `product_category_name_translation`
- `sellers`

**Schema file:** `schema.sql`

---

### 🔍 2. Data Validation
I checked:

- Row counts per table
- Missing primary keys
- Duplicate IDs
- Orphan foreign keys (orders without customers, items without products, etc.)
- Unrealistic values (negative prices, invalid review scores)

**Validation file:** `datavalidation.sql`

---

## 📊 3. Exploratory & Trend Analysis

### 🔹 sales_trends.sql
This script analyzes how sales performance changes over time.

**Key outputs:**
- Monthly order volume
- Monthly revenue

**Business questions answered:**
- Is demand growing or declining?
- Are there seasonal spikes?
- How stable is revenue month to month?

This forms the baseline performance view of the business.

---

## 💡 4. Business Insights

### ⭐ Sales & Revenue Trends
From `sales_trends.sql`:

- Monthly revenue and order volume trends reveal seasonality and growth patterns.
- The business shows periods of strong demand growth and occasional volatility.

---

### 🧠 Customer Analysis
From `customer_analysis.sql`:

- Revenue by State 
- highlights which customer states generate the most revenue and where demand is concentrated geographically.
- New vs Repeat Customers tracks customer retention over time by separating first-time buyers from returning customers.

This helps identify:
- High-performing regions and potential expansion opportunities
- Retention patterns and the mix of acquisition vs repeat purchasing

---

### 🛍 Product & Category Insights
From `product_seller_analysis.sql`:

- Top categories drive a large share of total revenue.
- Some categories are driven by **high order volume**, while others are driven by **larger basket sizes**.
- The `avg_items_per_order` metric reveals bundling behavior vs. single-item purchasing.

This helps explain *why* certain categories outperform others.

---

### 🏪 Seller Concentration (Overall Marketplace)
From `product_seller_analysis.sql`:

- Top 10 sellers account for ~12.9% of total delivered revenue.
- Top 50 sellers account for ~32.5%.

This indicates a highly fragmented marketplace with low dependency on a small group of sellers.

---

### ⚠ Seller Concentration by Category
From `product_seller_analysis.sql`:

For each category, I computed:
- Total category revenue
- Number of active sellers
- % of revenue controlled by the top 1 seller
- % controlled by the top 5 sellers

This reveals that:
- Some categories are **competitive and healthy**
- Others are **dominated by a few sellers**
- Risk and dependency vary significantly by category

This helps identify:
- High-risk categories
- Seller dependency
- Monopoly-like behavior
- Opportunities for diversification

---

## 📈 5. Tableau Dashboard + Story

Interactive dashboards were built to answer:

- How do sales and revenue change over time?
- Which customer states generate the most revenue?
- How do new vs repeat customers change over time?
- Which categories dominate the marketplace?
- Which categories are most seller-concentrated?
- Which areas show seller dependency risk?

These dashboards allow stakeholders to explore trends dynamically.

---

## 📁 Output Files (CSV)

The following CSV files contain the results of the analysis and can be used for visualization or further exploration:

- `salestrend.csv` – Monthly orders and revenue


---

## 🚀 Tools Used

- PostgreSQL
- pgAdmin 4
- SQL (joins, CTEs, window functions, aggregations)
- Tableau Public
- GitHub for version control

---

## 👩🏻‍💻 Author

**Flor Hoyos**  
Data Analyst | SQL · Tableau · Python
