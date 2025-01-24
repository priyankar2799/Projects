##Handling missing valuses
with temp_customers_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included) as
(
select order_id,customer_id,roll_id,
case when not_include_items is null or not_include_items='' then '0' else not_include_items end as new_not_include_items,
case when extra_items_included in ('','NaN') or extra_items_included is null then '0' else extra_items_included end as new_extra_items_included
from customers_orders),

temp_driver_orders as
(
select order_id,driver_id,pickup_time,distance,duration,
case when cancellation in ('cancellation','customer cancellation') then '0' else '1' end as new_cancellation 
from driver_orders
)
select * from temp_customers_orders where order_id in 
(select order_id from temp_driver_orders        
where new_cancellation != 0)


##Roll Metrics
#how many rolls were ordered
select count(roll_id) from customers_orders;

##how many unique customer order was made
select count(distinct(customer_id)) from customers_orders;

#succussfull orders delivered by each driver
select driver_id,count(order_id) Order_Count from(
select *,case when cancellation in ('cancellation','customer cancellation') then 'cancelled' else 'not cancelled' end as cancelled_column from driver_orders) 
a where cancelled_column='not cancelled'
group by driver_id;

#How many of each type of roll was delivered
select roll_id,count(order_id) Oder_Count from customers_orders where order_id in(
select order_id from(
select *,case when cancellation in ('cancellation','customer cancellation') then 'cancelled' else 'not cancelled' end as cancelled_column from driver_orders) 
a where cancelled_column='not cancelled')
group by roll_id;

#how many veg and non veg roll ordered by each customer
select * from rolls;
select a.*,b.rolls_name from 
(select customer_id,roll_id,count(roll_id) as roll_count from customers_orders
group by customer_id,roll_id) a inner join rolls b on a.roll_id=b.rolls_id;

#what was the max rolls delivered in single order
select roll_count from(
select *,dense_rank() over(order by roll_count desc) as 'Rank' from(
select order_id,count(roll_id) as roll_count from customers_orders where order_id in(
select order_id from(
select *,case when cancellation in ('cancellation','customer cancellation') then 'cancelled' else 'not cancelled' end as cancelled_column from driver_orders)a 
where cancelled_column='not cancelled')
group by order_id)b)c
where `Rank`=1; 

#For each of customer how many delivered roles had atleast 1 change and had no change
with temp_customers_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included) as
(
select order_id,customer_id,roll_id,
case when not_include_items is null or not_include_items='' then '0' else not_include_items end as new_not_include_items,
case when extra_items_included in ('','NaN') or extra_items_included is null then '0' else extra_items_included end as new_extra_items_included
from customers_orders),
temp_driver_orders( order_id,driver_id,pickup_time,distance,duration,new_cancellation)as
(
select order_id,driver_id,pickup_time,distance,duration,
case when cancellation in ('cancellation','customer cancellation') then '0' else '1' end as new_cancellation 
from driver_orders
)
select customer_id,chg_no_chg,count(order_id) from
(select *,
case when not_include_items='0' and extra_items_included='0' then 'no_change' else 'change' end as chg_no_chg from
temp_customers_orders where order_id in 
(select order_id from temp_driver_orders        
where new_cancellation != 0))a
group by customer_id,chg_no_chg;

#how many rolls delivered had exclusions and extra
with temp_customers_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included) as
(
select order_id,customer_id,roll_id,
case when not_include_items is null or not_include_items='' then '0' else not_include_items end as new_not_include_items,
case when extra_items_included in ('','NaN') or extra_items_included is null then '0' else extra_items_included end as new_extra_items_included
from customers_orders)
,
temp_driver_orders( order_id,driver_id,pickup_time,distance,duration,new_cancellation)as
(
select order_id,driver_id,pickup_time,distance,duration,
case when cancellation in ('cancellation','customer cancellation') then '0' else '1' end as new_cancellation 
from driver_orders
)

select exc_and_extra_item,count(exc_and_extra_item) from(
select *,
case when not_include_items!='0' and extra_items_included!='0' then 'exlucded_and_extra' else 'either_excluded_nor_extra' end as exc_and_extra_item
from temp_customers_orders where order_id in 
(select order_id from temp_driver_orders        
where new_cancellation != 0))a
group by exc_and_extra_item;

#Total no of rolls ordered for every hour of the day
select concat(substring(order_date,12,2),'-',substring(order_date,12,2)+1) hr_bracket,count(order_id) total_rolls from customers_orders
group by hr_bracket
order by hr_bracket;

#What was the total number of rolls ordered each day of the week
select dow,count(order_id) from
(select *,dayname(STR_TO_DATE(order_date, '%Y-%m-%d')) dow from customers_orders)a
group by dow;

#Driver and customer metrics
#what was the average time in minitues for each driver to arrive at faasos HQ to pickup the order
select * from driver_orders;

select driver_id,sum(diff)/count(order_id) from
(select * from 
(select *,row_number() over(partition by order_id) rnk from
(select a.order_id,a.customer_id,a.order_date,b.driver_id,b.pickup_time,timestampdiff(minute,str_to_date(a.order_date '%Y-%m-%d %H:%i:%s'),str_to_date(b.pickup_time '%Y-%m-%d %H:%i:%s')) diff  from customers_orders a 
inner join driver_orders b 
on a.order_id=b.order_id
where b.pickup_time is not null)c)d
where rnk=1)e;

#Relationship bw no of rolls ordered and the preparation time
select order_id,count(roll_id),sum(diff)/count(roll_id) from
(select a.order_id,a.customer_id,a.roll_id,a.order_date,b.driver_id,b.pickup_time,TIMESTAMPDIFF(MINUTE, 
        cast(STR_TO_DATE(a.order_date, '%H:%i:%s') as time),   -- Convert a.order_date to DATETIME
        cast(STR_TO_DATE(b.pickup_time, '%H:%i:%s') as time)          -- Convert b.pickup_time to TIME
    ) AS diff  from customers_orders a 
inner join driver_orders b 
on a.order_id=b.order_id
where b.pickup_time is not null)a
group by order_id;

#Average distance travelled for each customer_id
select * from customers_orders;
select * from driver_orders;

select customer_id,avg(distance) from
(select *,row_number() over(partition by order_id) as rnk from
(select a.order_id,a.customer_id,a.roll_id,a.not_include_items,a.extra_items_included,a.order_date,b.driver_id,b.pickup_time,b.distance,b.cancellation from customers_orders a
inner join driver_orders b
on a.order_id=b.order_id
where distance is not null)a)b
where rnk=1
group by customer_id;

#what was the difference bw shortest and longest delivery distance for all orders
select max(distance)-min(distance) as diff from(
select *,row_number() over(partition by order_id) as rnk from
(select a.order_id,a.customer_id,a.roll_id,a.not_include_items,a.extra_items_included,a.order_date,b.driver_id,b.pickup_time,b.distance,b.cancellation from customers_orders a
inner join driver_orders b
on a.order_id=b.order_id
where distance is not null)a)b
where rnk=1;

#what was the difference bw shortest and longest delivery time for all orders
select max(duration)-min(distance) delivery_range from driver_orders
where duration is not null;

select max(duration) from driver_orders;
select min(duration) from driver_orders;

#Handle incorrect data
select duration,
case
when duration like '%min%' then left(duration,2) else duration end as dur from driver_orders;

#what is the successful delivery percentage for each driver
select * from driver_orders;
#sdp=total successfull delivery/total orders made
select driver_id,successfull/total from
(select driver_id,sum(new_column) as successfull,count(driver_id) as total from
(select order_id,driver_id,case
when cancellation like '%cancel%' then 0 else 1 end new_column from driver_orders)a
group by driver_id)b
group by driver_id




