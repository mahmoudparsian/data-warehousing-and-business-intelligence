1. week_03_SQL_Aggregate_Functions.pdf

2. week_03_Summarising_Data_in_SQL.pdf

3. week_03_SQL_basics_and_joins.pdf

4. week_03_SQL_SubQueries.pdf

5. week_03_MySQL_GROUP_BY_with_ROLLUP.md

6. week_03_Data_Cleaning_with_SQL_in_8_Steps.pdf

7. week_03_Deleting_Duplicate_Data_With_No_Primary_Key.pdf

8. week_03_Working_with_SQL_for_Data_Analysis.pdf


Product: pname price category manufacturer
Company: cname country

-- Join is on (P.manufacturer = C.cname)
SELECT P.pname
FROM Product P, Company C
WHERE 
       C.country = ‘Japan’
   AND P.price < 150
   AND P.manufacturer = C.cname

====================

-- step-1: Create a new table with distinct records
CREATE TABLE temp_sales_data AS
SELECT DISTINCT *
FROM sales_data;

-- step-2: verify
select count(*) from sales_data;
123

select count(*) from temp_sales_data;
120

select * from temp_sales_data limit 10;

desc temp_sales_data;



-- Step-3: Delete the old table
DROP TABLE sales_data;

-- Step-4: Rename the new table to the original table name
ALTER TABLE temp_sales_data
RENAME TO sales_data;


movies: user_id, movie_id, rating

CREATE TABLE movies_cleaned AS
SELECT user_id, movie_id, rating 
FROM movies
where 
       rating >= 1 and
       rating <= 5;


