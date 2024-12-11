use walmart_db;

select * from walmart;

drop table walmart;

select count(*) from walmart;

select payment_method, count(*) 
from walmart
group by payment_method; 

select count(distinct branch)
from walmart;

select MAX(quantity) from walmart;

-- BUSINESS PROBLEM
-- 1. Find different payment method and number of transaction, number of qty sold

select payment_method, count(*), sum(quantity) as no_qty_sold
from walmart
group by payment_method;

-- 2. Identify the heighest rated category in each branch in displaying the brach, category, avg rating
select branch, category, avg(rating) as avg_rating, RANK() over(partition by branch order by avg(rating) desc) as ranks
from walmart 
group by 1, 2;

-- 3. identity the busiest day for each branch based on the no.of transtions.
select
	branch,
    TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS day_name,
    count(*) as no
from walmart
group by 1,2;
 
-- 4. calculate the total quantity of items sold per payment method. list payment_method and total_quantity.
select 
	payment_method,
	sum(quantity) as no_qty
from walmart
group by payment_method;    

-- 5. determine the avg, min, and max rating of category for each city. list the city, avg_rating, min_rating and max_rating.
select
	city,
    category,
	min(rating) as min_rating,
    max(rating) as max_rating,
    avg(rating) as avg_rating
from walmart
group by 1,2;  

-- 6. Calculate the total profit for each category by considering total_profit as (unit_price * quantity * profit_margin).
-- list category and total_profit, ordered from highest to lowest profit.
select 
	category, 
    sum(total) as total_revenue,
    sum(total * profit_margin) as profit
from walmart
group by 1;

-- 7. determine the most common payment method for each branch. display brach and the preferred_payment_method.
 select
	branch,
    payment_method,
    count(*) as total_trans,
    rank() over(partition by branch order by count(*) desc) as ranks
from walmart
group by 1,2;    

-- 8. identity 5 branch with heightest decrease ratio in revevenue compare to last yr. (current yr 2023 last yr 2022)
select BRANCH,
SUM(TOTAL) as xxx
from walmart;