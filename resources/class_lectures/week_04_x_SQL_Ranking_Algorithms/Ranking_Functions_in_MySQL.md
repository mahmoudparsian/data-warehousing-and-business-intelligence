# MySQL | Ranking Functions

# Introduction

	1. The ranking functions in MySQL are  
	   used to rank each row of a partition. 

	2. The ranking functions are also part 
	   of MySQL windows functions list.

	3. These functions are always used with 
	   `OVER()` clause.

	4. The ranking functions always assign 
	   rank on basis of ORDER BY clause.

	5. The rank is assigned to rows in a 
	   sequential manner.

	6. The assignment of rank to rows always 
	   start with 1 for every new partition.


There are 3 types of ranking functions supported in MySQL-

1. `dense_rank()`
2. `rank()`
3. `percent_rank()`


## `dense_rank()`: 

	1. This function will assign rank to each 
	   row within a partition without gaps. 
	
	2. Basically, the ranks are assigned in 
	   a consecutive manner i.e if there is 
	   a tie between values then they will 
	   be assigned the same rank, and next 
	   rank value will be one greater than 
	   the previous rank assigned.

## `rank()`

	1. This function will assign rank to each 
	   row within a partition with gaps. Here, 
	   ranks are assigned in a non-consecutive 
	   manner i.e 
	
	2. if there is a tie between values then 
	   they will be assigned same rank, and 
	   next rank value will be previous rank + 
	   no of peers (duplicates).

## `percent_rank()`

	1. It returns the percentile rank of 
	   a row within a partition that ranges 
	   from 0.0 to 1.0 
	
	2. It tells the percentage of partition 
	   values less than the value in the current 
	   row, excluding the highest value.


## Examples...


	In order to understand these functions 
	in a better way. 

	Let consider a table “result”:

~~~text
SELECT * FROM result;

name      subjects   mark
------    --------   -----
Pratibha  Maths      100
Ankita    Science     80
Swarna    English    100
Ankita    Maths       65
Pratibha  Science     80
Swarna    Science     50
Pratibha  English     70
Swarna    Maths       85
Ankita    English     90
~~~


Queries:


## `dense_rank()` function:

~~~sql
SELECT subjects, name, mark, 
dense_rank() OVER ( partition by subjects 
                    order by mark desc 
                  ) AS 'dense_rank' 
FROM result;
~~~

Output-Explanation-

	1. Here, table is partitioned on the basis 
	   of “subjects”.

	2. `order by` clause is used to arrange 
	   rows of each partition in descending 
	   order by “mark”.

	3. `dense_rank()` is used to rank students 
	   in each subject.

	4. Note, for science subject there is a tie 
	   between Ankita and Pratibha, so they both 
	   are assigned same rank. The next rank value 
	   is incremented by 1 i.e 2  for Swarna.

~~~text
subjects    name       mark    dense_rank
--------    ---------  ----    ----------
English     Swarna     100     1
English     Ankita      90     2
English     Pratibha    70     3
Maths       Pratibha   100     1
Maths       Swarna      85     2
Maths       Ankita      65     3
Science     Ankita      80     1
Science     Pratibha    80     1
Science     Swarna      50     2
~~~

## `rank()` function:

~~~sql
SELECT subjects, name, mark, 
       rank() OVER ( 
                    partition by subjects 
                    order by mark desc 
                   ) AS 'rank' 
FROM result;
~~~

Output-Explanation-

	1. It’s output is similar to 
	   `dense_rank()` function.

	2. Except, that for Science subject 
	in case of a tie between Ankita and Pratibha, 
	the next rank value is incremented by 2 i.e 3 
	for Swarna.

~~~text
subjects    name       mark    rank
--------    -------    ----    -----
English    Swarna       100    1
English    Ankita        90    2
English    Pratibha      70    3
Maths      Pratibha     100    1
Maths      Swarna        85    2
Maths      Ankita        65    3
Science    Ankita        80    1
Science    Pratibha      80    1
Science    Swarna        50    3
~~~

## `percent_rank()` function:

~~~sql
SELECT subjects, name, mark, 
       percent_rank()  OVER ( 
                              partition by subjects 
                              order by mark 
                             ) AS 'percent_rank' 
FROM result;
~~~

Output-Explanation:

	1. Here, the `percent_rank()` function 
	   calculate percentile rank in ascending 
	   order by “mark” column.

	2. `percent_rank` is calculated using 
	   following formula-

			(rank - 1) / (rows - 1)

	3. `rank` is the rank of each row of the 
	   partition resulted using `rank()` function.

	4. `rows` represent the no of rows in that partition.


To understand this formula, consider following query-

~~~sql
SELECT subjects, name, mark, 
       rank() OVER ( partition by subjects order by mark )-1 AS 'rank-1', 
       count(*) over (partition by subjects)-1 AS 'total_rows-1', 
       percent_rank() OVER ( partition by subjects order by mark ) AS 'percenr_rank'
FROM result;
~~~

Output:

~~~text-
subjects  name        mark  rank-1  total_rows-1  percent_rank
--------  ---------   ----  ------  ------------  ------------
English   Pratibha    70    0       2             0.0
English   Ankita      90    1       2             0.5
English   Swarna     100    2       2             1.0
Maths     Ankita      65    0       2             0.0
Maths     Swarna      85    1       2             0.5
Maths     Pratibha   100    2       2             1.0
Science   Swarna      50    0       2             0.0
Science   Ankita      80    1       2             0.5
Science   Pratibha    80    1       2             0.5


subjects    name        mark   percent_rank
--------    ---------   ----   -------------
English     Pratibha     70    0.0
English     Ankita       90    0.5
English     Swarna      100    1.0
Maths       Ankita       65    0.0
Maths       Swarna       85    0.5
Maths       Pratibha    100    1.0
Science     Swarna       50    0.0
Science     Pratibha     80    0.5
Science     Ankita       80    0.5
~~~

## Introduction to MySQL `DENSE_RANK` function

	The `DENSE_RANK()` is a window function 
	that assigns a rank to each row within 
	a partition or result set with no gaps 
	in ranking values.

~~~sql
CREATE TABLE t (
    val INT
);

INSERT INTO t(val)
VALUES(1),(2),(2),(3),(4),(4),(5);


SELECT * FROM t;
+------+
| val  |
+------+
|    1 |
|    2 |
|    2 |
|    3 |
|    4 |
|    4 |
|    5 |
+------+
7 rows in set (0.00 sec)
~~~

Now apply `DENSE_RANK` function:


~~~sql
SELECT
    val,
    DENSE_RANK() OVER (ORDER BY val) my_rank
FROM t;

+------+---------+
| val  | my_rank |
+------+---------+
|    1 |       1 |
|    2 |       2 |
|    2 |       2 |
|    3 |       3 |
|    4 |       4 |
|    4 |       4 |
|    5 |       5 |
+------+---------+
7 rows in set (0.01 sec)
~~~


## MySQL `DENSE_RANK()` function example

We will use the following sales table for the demonstration:

~~~sql
CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
      ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);
~~~

Output:

~~~sql
SELECT * FROM sales;
+----------------+-------------+--------+
| sales_employee | fiscal_year | sale   |
+----------------+-------------+--------+
| Alice          |        2016 | 150.00 |
| Alice          |        2017 | 100.00 |
| Alice          |        2018 | 200.00 |
| Bob            |        2016 | 100.00 |
| Bob            |        2017 | 150.00 |
| Bob            |        2018 | 200.00 |
| John           |        2016 | 200.00 |
| John           |        2017 | 150.00 |
| John           |        2018 | 250.00 |
+----------------+-------------+--------+
9 rows in set (0.00 sec)
~~~


	The following statement uses the 
	`DENSE_RANK()` function to rank the 
	sales employees by sale amount.

~~~sql
SELECT 
  sales_employee, 
  fiscal_year, 
  sale, 
  DENSE_RANK() OVER (
    PARTITION BY fiscal_year 
    ORDER BY sale DESC
  ) sales_rank 
FROM 
  sales;
  
+----------------+-------------+--------+------------+
| sales_employee | fiscal_year | sale   | sales_rank |
+----------------+-------------+--------+------------+
| John           |        2016 | 200.00 |  1         |
| Alice          |        2016 | 150.00 |  2         |
| Bob            |        2016 | 100.00 |  3         |
+----------------+-------------+--------+------------+
| Bob            |        2017 | 150.00 |  1         |
| John           |        2017 | 150.00 |  1         |
| Alice          |        2017 | 100.00 |  2         |
+----------------+-------------+--------+------------+
| John           |        2018 | 250.00 |  1         |
| Alice          |        2018 | 200.00 |  2         |
| Bob            |        2018 | 200.00 |  2         |
+----------------+-------------+--------+------------+
~~~

In this example:

	1. First, the PARTITION BY clause 
	divided the result sets into partitions 
	using fiscal_year.

	2. Second, the ORDER BY clause specified 
	the order of the sales employees by sales 
	in descending order.

	3. Third, the DENSE_RANK() function is 
	applied to each partition with the order 
	of the rows specified by the ORDER BY clause.


## MySQL `ROW_NUMBER()` Function


	1. The `ROW_NUMBER()` function in MySQL 
	   is used to returns the sequential number 
	   for each row within its partition. 

	2. It is a kind of window function. 
	   The row number starts from 1 to the 
	   number of rows present in the partition.


Syntax:

	ROW_NUMBER() OVER (<partition_definition> <order_definition>)  
	


Example:
	
	1. Let us demonstrate it using an example.
	
	2. First, we are going to create a table named 
	   "Person" using the below statement:

~~~sql
CREATE TABLE Person (  
  Name varchar(45) NOT NULL,  
  Product varchar(45) DEFAULT NULL,  
  Country varchar(25) DEFAULT NULL,  
  Year int NOT NULL  
); 
~~~
 
Populate Table:

	Next, it is required to add values to this 
	table.  Execute the below statement:

~~~sql
INSERT INTO Person(Name, Product, Country, Year)   
VALUES 
('Stephen', 'Computer', 'USA', 2015),   
('Joseph', 'Laptop', 'India', 2016),   
('John', 'TV', 'USA', 2016),  
('Donald', 'Laptop', 'England', 2015),  
('Joseph', 'Mobile', 'India', 2015),  
('Peter', 'Mouse', 'England', 2016); 

mysql> select * from Person;
+---------+----------+---------+------+
| Name    | Product  | Country | Year |
+---------+----------+---------+------+
| Stephen | Computer | USA     | 2015 |
| Joseph  | Laptop   | India   | 2016 |
| John    | TV       | USA     | 2016 |
| Donald  | Laptop   | England | 2015 |
| Joseph  | Mobile   | India   | 2015 |
| Peter   | Mouse    | England | 2016 |
+---------+----------+---------+------+
6 rows in set (0.00 sec)
~~~ 

Next, execute the SELECT statement to display the records:

~~~sql
SELECT *,   
    ROW_NUMBER() OVER() AS row_num  
FROM Person;
mysql> SELECT *,
    ->     ROW_NUMBER() OVER() AS row_num
    -> FROM Person;
+---------+----------+---------+------+---------+
| Name    | Product  | Country | Year | row_num |
+---------+----------+---------+------+---------+
| Stephen | Computer | USA     | 2015 |       1 |
| Joseph  | Laptop   | India   | 2016 |       2 |
| John    | TV       | USA     | 2016 |       3 |
| Donald  | Laptop   | England | 2015 |       4 |
| Joseph  | Mobile   | India   | 2015 |       5 |
| Peter   | Mouse    | England | 2016 |       6 |
+---------+----------+---------+------+---------+
6 rows in set (0.01 sec)
~~~
The following are the basic syntax to use `ROW_NUMBER()` in MySQL:

Now, we can use the `ROW_NUMBER()` function to assign a 
sequence number for each record using the below statement:

~~~sql
SELECT *,   
    ROW_NUMBER() OVER(PARTITION BY Year) AS row_num  
FROM Person;

mysql> SELECT *,
    ->     ROW_NUMBER() OVER(PARTITION BY Year) AS row_num
    -> FROM Person;
+---------+----------+---------+------+---------+
| Name    | Product  | Country | Year | row_num |
+---------+----------+---------+------+---------+
| Stephen | Computer | USA     | 2015 |       1 |
| Donald  | Laptop   | England | 2015 |       2 |
| Joseph  | Mobile   | India   | 2015 |       3 |
| Joseph  | Laptop   | India   | 2016 |       1 |
| John    | TV       | USA     | 2016 |       2 |
| Peter   | Mouse    | England | 2016 |       3 |
+---------+----------+---------+------+---------+
6 rows in set (0.00 sec)  
~~~

NOTE:

	It will give the output as below where 
	two partitions found based on the year 
	(2015 and 2016).


# Twitter Example:

~~~sql
CREATE DATABASE twitter;
USE twitter;

CREATE TABLE twitter_comments (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  user_id INT,
  likes INT,
  published_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
~~~

~~~sql
INSERT INTO twitter_comments(user_id, likes, published_at) 
VALUES
(1, 100, '2021-04-05 09:01:00'),
(1, 200, '2021-04-05 10:01:00'),
(1, 300, '2021-04-05 11:01:00'),
(1, 200, '2021-04-05 12:01:00'),
(1, 100, '2021-04-05 13:01:00'),
(1, 200, '2021-04-05 14:01:00');

INSERT INTO twitter_comments(user_id, likes, published_at) 
VALUES
(2, 200, '2021-05-05 09:01:00'),
(2, 300, '2021-05-05 10:01:00'),
(2, 100, '2021-05-05 11:01:00'),
(2, 300, '2021-05-05 12:01:00'),
(2, 200, '2021-05-05 13:01:00'),
(2, 100, '2021-05-05 14:01:00');
~~~

~~~sql
mysql> select * from twitter_comments;
+----+---------+-------+---------------------+
| id | user_id | likes | published_at        |
+----+---------+-------+---------------------+
|  1 |       1 |   100 | 2021-04-05 09:01:00 |
|  2 |       1 |   200 | 2021-04-05 10:01:00 |
|  3 |       1 |   300 | 2021-04-05 11:01:00 |
|  4 |       1 |   200 | 2021-04-05 12:01:00 |
|  5 |       1 |   100 | 2021-04-05 13:01:00 |
|  6 |       1 |   200 | 2021-04-05 14:01:00 |
|  7 |       2 |   200 | 2021-05-05 09:01:00 |
|  8 |       2 |   300 | 2021-05-05 10:01:00 |
|  9 |       2 |   100 | 2021-05-05 11:01:00 |
| 10 |       2 |   300 | 2021-05-05 12:01:00 |
| 11 |       2 |   200 | 2021-05-05 13:01:00 |
| 12 |       2 |   100 | 2021-05-05 14:01:00 |
+----+---------+-------+---------------------+
12 rows in set (0.00 sec)
~~~

* What we want to do: 

given we have a list of tweets, we 
want to find SUM of the latest comments 
(only 3 latest items) for each user.

~~~sql
SELECT
  user_id,
  SUM(likes)
  FROM (
        SELECT *,
        ROW_NUMBER() 
          OVER( PARTITION BY user_id 
                ORDER BY published_at DESC 
              ) 
          AS `rank`
        FROM twitter_comments
        ORDER BY user_id ASC, published_at DESC
       ) AS data
  WHERE `rank` <= 3
 GROUP BY user_id;
~~~

### Analyze INNER QUERY:

	1. For each user's tweet, we generate a unique 
	   row number, which is later used to limit rows 
	   with aggregation functions(like SUM or AVG)

	2. The intermediate result (with rank for each 
	   tweet per user) looks like this:

~~~
mysql> SELECT *,
    ->         ROW_NUMBER() OVER( PARTITION BY user_id 
    ->                            ORDER BY published_at DESC 
    ->                          ) AS `rank`
    ->         FROM twitter_comments
    ->         ORDER BY user_id ASC, published_at DESC;
+----+---------+-------+---------------------+------+
| id | user_id | likes | published_at        | rank |
+----+---------+-------+---------------------+------+
|  6 |       1 |   200 | 2021-04-05 14:01:00 |    1 |
|  5 |       1 |   100 | 2021-04-05 13:01:00 |    2 |
|  4 |       1 |   200 | 2021-04-05 12:01:00 |    3 |
|  3 |       1 |   300 | 2021-04-05 11:01:00 |    4 |
|  2 |       1 |   200 | 2021-04-05 10:01:00 |    5 |
|  1 |       1 |   100 | 2021-04-05 09:01:00 |    6 |
| 12 |       2 |   100 | 2021-05-05 14:01:00 |    1 |
| 11 |       2 |   200 | 2021-05-05 13:01:00 |    2 |
| 10 |       2 |   300 | 2021-05-05 12:01:00 |    3 |
|  9 |       2 |   100 | 2021-05-05 11:01:00 |    4 |
|  8 |       2 |   300 | 2021-05-05 10:01:00 |    5 |
|  7 |       2 |   200 | 2021-05-05 09:01:00 |    6 |
+----+---------+-------+---------------------+------+
12 rows in set (0.00 sec)
~~~

~~~
mysql> SELECT
    ->   user_id,
    ->   SUM(likes)
    ->   FROM (
    ->         SELECT *,
    ->         ROW_NUMBER() OVER( 
    ->                           PARTITION BY user_id 
    ->                           ORDER BY published_at DESC 
    ->                          ) AS `rank`
    ->         FROM twitter_comments
    ->         ORDER BY user_id ASC, published_at DESC
    ->        ) AS data
    ->   WHERE `rank` <= 3
    ->  GROUP BY user_id;
+---------+------------+
| user_id | SUM(likes) |
+---------+------------+
|       1 |        500 |
|       2 |        600 |
+---------+------------+
2 rows in set (0.00 sec)
~~~

Another solution:

~~~sql
mysql> SELECT
    ->   tw.user_id,
    ->   SUM(tw.likes) AS total_likes
    ->   FROM twitter_comments AS tw
    ->   JOIN (
    ->     SELECT
    ->       user_id,
    ->       GROUP_CONCAT(id ORDER BY published_at DESC) AS comments_ids
    ->       FROM twitter_comments
    ->     GROUP BY user_id
    ->   ) AS t ON t.user_id = tw.user_id
    ->  WHERE FIND_IN_SET(tw.id, t.comments_ids) BETWEEN 1 AND 3
    ->  GROUP BY tw.user_id;
+---------+-------------+
| user_id | total_likes |
+---------+-------------+
|       1 |         500 |
|       2 |         600 |
+---------+-------------+
2 rows in set (0.01 sec)
~~~

# `ROW_NUMBER()` Function Example

	1. The `ROW_NUMBER()` function in MySQL 
	   assigns a unique integer value to 
	   each row in the result set. 

	2. This assigned number is determined by 
	   the order in which rows appear in 
	   the query result. 
	   
	3. It's important to note that `ROW_NUMBER()` 
	   does not directly modify the table data but 
	   is rather a means to generate a ranking for 
	   each row within the result set.

Here is the basic syntax of the `ROW_NUMBER()` function:

	ROW_NUMBER() OVER (ORDER BY column_name)

`ROW_NUMBER()`: The function itself.

* OVER: A clause that specifies the window frame for the function.

* `(ORDER BY column_name)`: The column by which the 
   rows will be ordered to assign the row numbers.

* PARTITION BY

NOTE:
		While `ROW_NUMBER()` can be used on its own to 
		assign a sequential number to each row in the 
		result set, combining it with the PARTITION BY 
		clause allows you to reset the numbering for 
		each distinct value in a specified column. 

		This is particularly useful when you want to 
		GROUP your data into partitions and assign 
		row numbers within those partitions.

Here is the basic syntax of `ROW_NUMBER()` with PARTITION BY:

	ROW_NUMBER() OVER (PARTITION BY partition_column ORDER BY column_name)

	PARTITION BY partition_column: Specifies the  
	column by which to partition the result set. 
	
	The ROW_NUMBER() function will reset the numbering 
	for each unique value in this column.

	ORDER BY column_name: Determines the order within 
	each partition, which is used to assign row numbers.


## Real-World Example: Document Versioning

	1. Let's take a real-world example to illustrate 
	   the use of `ROW_NUMBER()` over PARTITION BY. 

	2. Consider a scenario where you have a database 
	   table called document_versions, which stores 
	   multiple versions of documents.

The document_versions table has the following structure:

~~~sql
CREATE TABLE `document_versions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);
~~~

The data in the document_versions table looks like this:

~~~text
+----+-------------+---------------+---------------------+
| id | document_id | name          | created_at          |
+----+-------------+---------------+---------------------+
|  1 |           1 | document1.pdf | 2023-09-13 18:07:19 |
|  2 |           2 | document2.pdf | 2023-09-13 18:08:19 |
|  3 |           1 | document1.pdf | 2023-09-13 18:10:19 |
|  4 |           2 | document2.pdf | 2023-09-13 18:12:19 |
|  5 |           2 | document2.pdf | 2023-09-13 18:14:19 |
+----+-------------+---------------+---------------------+
~~~

	1. Each document has a unique `document_id`, 

	2. and you want to assign a version number to 
	   each version within the context of its 
	   associated document. 

Here's how you can achieve this using `ROW_NUMBER()` and `PARTITION BY`:

~~~sql
SELECT
    id,
    document_id,
    name,
    created_at,
    ROW_NUMBER() OVER (
        PARTITION BY document_id ORDER BY created_at
    ) AS version_number
FROM
    document_versions;
~~~

In this SQL query:

	1. We select the id, document_id, created_at 
	   and name columns from the document_versions table.

	2. We use the `ROW_NUMBER()` function with 
	   `PARTITION BY` document_id to partition 
	    the result set by the document_id column. 

	3. This ensures that the numbering starts fresh 
	   for each unique document.

	4. We specify the ORDER BY created_at clause to 
	   determine the order of versions within each 
	   document, which will be used for assigning 
	   version numbers. 
	
	5. The oldest version will get the lowest number, 
	   the newest version will get the highest number.

Running the query results in the following output:

SELECT
    id,
    document_id,
    name,
    created_at,
    ROW_NUMBER() OVER (
        PARTITION BY document_id ORDER BY created_at
    ) AS version_number
FROM
    document_versions
ORDER BY
    created_at;
+----+-------------+---------------+---------------------+----------------+
| id | document_id | name          | created_at          | version_number |
+----+-------------+---------------+---------------------+----------------+
|  1 |           1 | document1.pdf | 2023-09-13 18:07:19 |              1 |
|  2 |           2 | document2.pdf | 2023-09-13 18:08:19 |              1 |
|  3 |           1 | document1.pdf | 2023-09-13 18:10:19 |              2 |
|  4 |           2 | document2.pdf | 2023-09-13 18:12:19 |              2 |
|  5 |           2 | document2.pdf | 2023-09-13 18:14:19 |              3 |
+----+-------------+---------------+---------------------+----------------+
5 rows in set (0.00 sec)
~~~

Even if you change the ordering of the result set, 
the version numbers will remain the same:

SELECT
    id,
    document_id,
    name,
    created_at,
    ROW_NUMBER() OVER (
        PARTITION BY document_id ORDER BY created_at
    ) AS version_number
FROM
    document_versions
ORDER BY
     name, created_at;
+----+-------------+---------------+---------------------+----------------+
| id | document_id | name          | created_at          | version_number |
+----+-------------+---------------+---------------------+----------------+
|  1 |           1 | document1.pdf | 2023-09-13 18:07:19 |              1 |
|  3 |           1 | document1.pdf | 2023-09-13 18:10:19 |              2 |
|  2 |           2 | document2.pdf | 2023-09-13 18:08:19 |              1 |
|  4 |           2 | document2.pdf | 2023-09-13 18:12:19 |              2 |
|  5 |           2 | document2.pdf | 2023-09-13 18:14:19 |              3 |
+----+-------------+---------------+---------------------+----------------+
5 rows in set (0.00 sec)
~~~

## Conclusion

	1. The `ROW_NUMBER()` function combined with 
	   the `PARTITION BY` clause in MySQL is a 
	   powerful tool for assigning row numbers 
	   within partitions of data. 

	2. This construct is particularly valuable when 
	   you need to rank or sequence data within specific 
	   groups or categories. 
	   
	3. In our real-world example of document versioning, 
	   it allowed us to easily assign version numbers to 
	   each version of a document within the context of 
	   that document. 

	4. By mastering this SQL construct, you can unlock 
	   new possibilities for analyzing and organizing 
	   your data in MySQL databases.



# References

1. [MySQL | Ranking Functions](https://www.geeksforgeeks.org/mysql-ranking-functions/)

2. [MySQL RANK Function](https://www.mysqltutorial.org/mysql-window-functions/mysql-rank-function/)
