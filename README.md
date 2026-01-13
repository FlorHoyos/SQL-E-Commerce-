SQL-Project
🛒 Marketplace Revenue & Seller Concentration SQL Project

Data Analytics Portfolio Project – Flor Hoyos

This project analyzes an e-commerce marketplace using PostgreSQL and Tableau.
I built structured SQL queries to explore sales trends, category performance, and seller concentration patterns, transforming raw transactional data into business insights about marketplace health, customer purchasing behavior, and seller dependency risk.

📂 Project Structure
🧱 1. Database Schema

This project uses a relational schema modeled after a real-world e-commerce platform.

Core tables used:

orders

order_items

products

sellers

customers (used in supporting analyses)

These tables were joined using proper primary–foreign key relationships to ensure accurate aggregations and prevent double counting.

🔍 2. Data Preparation & Assumptions

Before analysis, I applied the following standards:

Revenue defined as: price + freight_value

Delivered-only filters applied where relevant

Distinct order counting used when joining item-level data

Monthly bucketing done with DATE_TRUNC()

Window functions used for ranking and concentration analysis

These steps ensure clean, interpretable outputs.

📊 3. Exploratory & Trend Analysis

File: sales_trends.sql

This script analyzes how sales performance changes over time.

Key outputs:

Monthly order volume

Monthly revenue

Business questions answered:

Is demand growing or declining?

Are there seasonal spikes?

How stable is revenue month to month?

This forms the baseline performance view of the business.

💡 4. Business Insights
⭐ Sales & Revenue Trends

From sales_trends.sql:

Monthly revenue and order volume trends reveal seasonality and growth patterns.

The business shows periods of strong demand growth and occasional volatility.

🛍 Product & Category Insights

From product_seller_analysis.sql:

Top categories drive a large share of total revenue.

Some categories are driven by high order volume, while others are driven by larger basket sizes.

The avg_items_per_order metric reveals bundling behavior vs. single-item purchasing.

This helps explain why certain categories outperform others.

🧠 Customer Purchasing Behavior

Categories with higher average items per order indicate bundling behavior.

Categories with lower averages show mission-driven shopping.

This insight can inform cross-selling, bundling, and merchandising strategies.

🏪 Seller Concentration (Overall Marketplace)

From product_seller_analysis.sql:

Top 10 sellers account for ~12.9% of total delivered revenue.

Top 50 sellers account for ~32.5%.

This indicates a highly fragmented marketplace with low dependency on a small group of sellers.

⚠ Seller Concentration by Category

From seller_concentration_by_category.sql:

This is the most advanced part of the project.

For each category, I computed:

Total category revenue

Number of active sellers

% of revenue controlled by the top 1 seller

% controlled by the top 5 sellers

This reveals that:

Some categories are competitive and healthy

Others are dominated by a few sellers

Risk and dependency vary significantly by category

This helps identify:

High-risk categories

Seller dependency

Monopoly-like behavior

Opportunities for diversification
