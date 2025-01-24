Faasos Project: Operational Analysis


Project Overview:

The Faasos Project involves creating SQL QUERIES to analyze and Power BI Dashboard to visualize operational and customer-related data for Faasos. This project aims to provide insights into the following areas:

1.	Product Performance Trends

2.	Service Delivery and Customer Experience 

Objectives:

1.	Understand Product Trends: Use order patterns and product preferences to improve inventory, menu offerings, and resource planning.

2.	Improve Service Efficiency: Optimize delivery times, driver performance, and pickup processes to ensure timely and reliable services.

3.	Enhance Customer Experience: Maintain high satisfaction by analysing delivery success rates and tailoring services to customer behaviour.

4.	Support Decision-Making: Enable data-driven decisions for stakeholders.

5.	Highlight Trends & Anomalies: Identify insights for business optimization.

Data Sources & Cleaning Process

Data Sources:

1.	Customer Orders 

2.	Driver Orders

3.	Rolls Recipes 

Data Cleaning Techniques:

1.	Duplicate Removal

2.	Handling Missing Values

3.	Creation of Custom Columns 

4.	DAX Calculated Measures


Key Dashboards

1.	Roll Performance Analysis
Key Metrics: Total Rolls, Breakdown by veg and non veg, Max rolls delivered in one order, Order by day of week, Order by hour

![image](https://github.com/user-attachments/assets/b4b03b5a-9193-46b7-b627-51f661d53ebf)

 
2.	Service Delivery and Customer Experience Analysis
Key Metrics: Total Customers, Order by drivers, Average pickup time, Average distance travelled, Longest and shortest deliver time, Successful delivery time. 

![image](https://github.com/user-attachments/assets/c11efb2c-ff69-4c55-b223-04d3d3ec4d13)

 
Insights

Driver and Delivery Insights:

1.	Driver 1 has the highest number of orders but varying pickup and delivery times, indicating potential workload imbalance.

2.	Shortest delivery time is 10 minutes, while the longest is 40 minutes, showing room for improvement in consistency.

Customer Behaviour Insights:

1.	The average delivery success rate is high, but individual drivers' performance varies.

Order Trends:

1.	Most orders occur on Sunday, with demand dropping significantly through the week.

2.	Peak ordering hours are concentrated in specific time brackets (13:00–14:00).

Product Demand Insights:

1.	Non-veg rolls are significantly more popular than veg rolls (9 vs. 3 orders).

2.	Some customers consistently prefer one category, indicating specific demand patterns.

Tools & Techniques Used

Tools:

1.	Power BI

2.	SQL

3.	DAX

•	Techniques:

1.	Data Cleaning: Removed duplicates, handled missing data.

2.	Calculated Measures: Using DAX for custom metrics.

3.	Visualizations: Created Bar, Pie, and Line charts.

4.	Dashboard Design: Simple, intuitive design with clear KPIs.

Challenges & Solutions

1. Data Inconsistencies	Used SQL queries and Power Query for data cleaning.

2. Handling Missing Data	Imputed missing values or excluded incomplete records.

3. Dashboard Layout	Kept the design clean, simple, and easy to navigate.
	
Conclusion & Next Steps

Conclusion: The Faasos Dashboard provides valuable insights into improving delivery efficiency, enhance customer satisfaction, and optimize resources, helping the company make data-driven decisions.

Next Steps:

Service Delivery Improvements:
 
1.	Balance driver workload by evenly distributing orders based on performance and geography.

2.	Optimize route planning using tools to ensure shorter and more consistent delivery times.

Customer Experience Enhancements:

1.	Monitor and address variations in driver success rates to ensure consistent quality of service.

 Product Performance Optimization:

1.	Focus marketing efforts on popular products (non-veg rolls) while promoting veg rolls to diversify sales.

2. Adjust inventory to align with peak demand for non-veg rolls, particularly on Sundays.

Demand-Driven Strategies:

1.	Increase staffing and inventory during peak order hours and days (e.g., Sundays and lunch hours).

2.	Implement promotions on low-demand days to boost sales and balance demand across the week.
Continuous Monitoring:

3.	Use the dashboard to track delivery performance, customer behaviour, and product trends in real time.

4.	Regularly review data insights to adapt strategies and maintain operational efficiency.

