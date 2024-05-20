USE sales;
#Show all records from tables
SELECT * FROM sales.products;
SELECT * FROM sales.customers;
SELECT * FROM transactions;
SELECT * FROM markets; 
SELECT * FROM date;
#Show total numbers of Customers
SELECT COUNT(*) FROM customers;
#Show transactions for Chennai market
SELECT * FROM transactions WHERE market_code='Mark001';
#Show distrinct product codes that were sold in Chennai from Transactions Table
SELECT DISTINCT(product_code) FROM transactions WHERE market_code='Mark001';
#Show transactions where currency is US dollars
SELECT * FROM transactions WHERE currency='USD';
#Show transactions in 2020 join by date table
SELECT sales.transactions.*, sales.date.* FROM sales.transactions JOIN sales.date 
ON sales.transactions.order_date= sales.date.date 
WHERE sales.date.year=2020;
#Show total revenue in year 2020
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions JOIN sales.date 
ON sales.transactions.order_date= sales.date.date 
WHERE sales.date.year=2020;
#Show total revenue in year 2020, January Month
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions JOIN sales.date 
ON sales.transactions.order_date= sales.date.date 
WHERE sales.date.year=2020 AND sales.date.month_name='January';
#Show total revenue in year 2020 in Chennai
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions JOIN sales.date 
ON sales.transactions.order_date= sales.date.date 
WHERE sales.date.year=2020 AND sales.transactions.market_code='Mark001';