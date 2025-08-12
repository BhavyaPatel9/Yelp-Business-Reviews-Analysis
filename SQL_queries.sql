-- SQL Queries 

-- 1  Find number of businesses in each category 
with cte as (select business_id, trim(A.value) as category
from tbl_yelp_businesses, 
lateral split_to_table(categories,',') A
)
select category,count(*) as number_of_business 
from cte 
group by 1
order by number_of_business desc

select * from tbl_yelp_reviews
limit 5
--2 Find top 10 user who have review the most business in the "restaurants" category.
SELECT r.user_id, COUNT(DISTINCT r.BUSINESS_ID) AS business_count
FROM tbl_yelp_reviews r
INNER JOIN tbl_yelp_businesses b ON r.BUSINESS_ID = b.BUSINESS_ID
WHERE LOWER(b.categories) LIKE '%restaurants%'
GROUP BY r.user_id
ORDER BY business_count DESC;

--3 Find the most popular category of business(based on review)
with cte as (select business_id, trim(A.value) as category
from tbl_yelp_businesses, 
lateral split_to_table(categories,',') A
)
select category,count(*) as no_of_review
from cte 
inner join tbl_yelp_reviews r on r.business_id = cte.business_id
group by 1
order by 2 desc


--4 find top 3 most recent review for each business
WITH cte AS (
    SELECT r.*,ROW_NUMBER() OVER (
            PARTITION BY r.business_id 
            ORDER BY review_date DESC
        ) AS rn
    FROM tbl_yelp_reviews r
    INNER JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
)
SELECT * 
FROM cte 
WHERE rn <= 3;

--5 Find month with the highest no. of review

select month(review_date) as review_month,count(*) as no_of_reviews from tbl_yelp_reviews
group by 1
order by 2 desc;


--6 Find the percentage of 5-star review of each business 

select b.business_id,b. name,
as total_reviews
,sum(case when r.review_stars=5 then 1 else 0 end) as star5_reviews from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r. business_id=b. business_id group by 1,2

--7 Find the top 5 most review business in each city

with cte as (
select b.city, b.business_id,b.name,count(*) as total_reviews
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
group by 1,2,3)
select * from cte
qualify row_number () over (partition by city order by total_reviews) <= 5


--8 Find Average rating of business that have atleast 100 review

SELECT 
b.business_id,
b.name,
COUNT(*) AS total_reviews,
FROM tbl_yelp_reviews r
INNER JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
GROUP BY b.business_id, b.name
HAVING COUNT(*) >= 100

--9 List the top 10 users who have 

WITH cte AS (
    SELECT 
        r.user_id, 
        COUNT(*) AS total_reviews
    FROM tbl_yelp_reviews r
    INNER JOIN tbl_yelp_businesses b 
        ON r.business_id = b.business_id
    GROUP BY r.user_id
    ORDER BY total_reviews DESC
    LIMIT 10
)
SELECT 
    r.user_id, 
    r.business_id
FROM tbl_yelp_reviews r
WHERE r.user_id IN (SELECT user_id FROM cte);


--10- find top businesses with highest positve sentiment reviews
select r.business_id,b.name, count(*) as total_reviews
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id=b.business_id 
where sentiments= 'Positive'
group by 1,2
order by 3 desc



