# SQL-Project  
## 🛒 Olist Brazilian E-Commerce SQL Project  
**Data Analytics Portfolio Project – Flor Hoyos**

This project analyzes the Olist Brazilian E-Commerce dataset using PostgreSQL. 
I built a complete relational database, validated the data, 
and developed four core analytical modules to generate business insights related 
to sales performance, customer behavior, product and seller dynamics, and delivery experience.

---

## 📂 Project Structure

This project is organized into four main SQL analysis files, each focusing on a specific business area:

1. `sales_trend.sql` – Monthly sales and revenue trends  
2. `customer_analysis.sql` – Customer behavior, retention, and geographic distribution  
3. `product_seller_analysis.sql` – Product category performance and seller concentration  
4. `delivery_reviews.sql` – Delivery speed and its impact on customer satisfaction  


---

### 🧱 Foundational Setup Files

In addition to the four core analytical modules, this project also includes two foundational setup files:

- `schema.sql` – Defines the full relational database schema, including tables, data types, and relationships.
- `datavalidation.sql` – Performs integrity checks such as missing keys, duplicates, orphan records, and unrealistic values.

These files ensure that all downstream analyses are built on a clean, reliable, and well-structured database.

---

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

### 🔹 `sales_trend.sql`
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

### 🧠 Customer Analysis (`customer_analysis.sql`)

- **Revenue by State (`revenuebystate.csv`)**
- highlights which customer states generate the most revenue and where demand is concentrated geographically.  
- **New vs Repeat Customers (`repeatvsnewcustomer.csv`)**
- tracks customer retention over time by separating first-time buyers from returning customers.

This helps identify:
- High-performing regions and potential expansion opportunities  
- Retention patterns and the mix of acquisition vs repeat purchasing  

---

### 🛍 Product & Seller Insights (`product_seller_analysis.sql`)

- Top categories drive a large share of total revenue.  
- Some categories are driven by **high order volume**, while others are driven by **larger basket sizes**.  
- The `avg_items_per_order` metric reveals bundling behavior vs. single-item purchasing.  

#### 🏪 Seller Concentration (Overall Marketplace)
- Top 10 sellers account for ~12.9% of total delivered revenue.  
- Top 50 sellers account for ~32.5%.  

This indicates a highly fragmented marketplace with low dependency on a small group of sellers.

#### ⚠ Seller Concentration by Category
For each category, I computed:
- Total category revenue  
- Number of active sellers  
- % of revenue controlled by the top 1 seller  
- % controlled by the top 5 sellers  

This reveals that:
- Some categories are **competitive and healthy**  
- Others are **dominated by a few sellers**  
- Risk and dependency vary significantly by category  

---

### 🚚 Delivery Performance & Customer Satisfaction (`delivery_reviews.sql`)

This section analyzes how delivery speed impacts customer satisfaction 
by examining the relationship between delivery time and review score.

Using order-level data, I calculated the number of days between the purchase date 
and the delivery date for each delivered order. 
I then grouped orders by their review score (1–5) and 
computed the average delivery time for each group.

**Output files:**
- `deliverydays.csv` – Order-level dataset containing delivery time (in days) and review score.  
- `ordersbyreviewscore.csv` – Aggregated view showing the average delivery time and number of orders per review score.

Key insights from this analysis include:
- Lower-rated orders tend to have significantly longer delivery times.  
- Higher-rated orders are generally delivered more quickly.  
- Delivery performance is a major driver of customer satisfaction.  

This finding highlights the importance of logistics and fulfillment speed in shaping customer experience. 
Improvements in delivery timelines could directly contribute to higher customer ratings, better retention, and stronger marketplace trust.

---

## 📈 5. Story

Questions that were answered:

- How do sales and revenue change over time?  
- Which customer states generate the most revenue?  
- How do new vs repeat customers change over time?  
- Which product categories dominate the marketplace?  
- Which sellers control the most revenue?  
- How does delivery speed impact customer satisfaction?  

---

## 🚀 Tools Used

- PostgreSQL  
- pgAdmin 4  
- SQL (joins, CTEs, window functions, aggregations)  
- GitHub for version control  

---

## 👩🏻‍💻 Author

**Flor Hoyos**  
Data Analyst | SQL · Tableau 
