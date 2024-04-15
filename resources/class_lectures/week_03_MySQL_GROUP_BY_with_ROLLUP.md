# MySQL 8.0: GROUPING function

* Source: https://dev.mysql.com/blog-archive/mysql-8-0-grouping-function/

* Posted on May 2, 2017 by Chaithra Gopalareddy

* Revised/Added/Updated on April 14, 2024 by Mahmoud  Parsian

	
		1. Starting with MySQL 8.0.1, the server 
		supports the SQL GROUPING function.  
	
		2. The GROUPING function is used to 
		distinguish between a NULL representing 
		the set of all values in a super-aggregate 
		row  (produced by a ROLLUP operation) from 
		a NULL in a regular row.
		

# Introduction

	1. MySQL server has supported GROUP BY extension 
	ROLLUP for sometime now.  Here is an example of 
	how to use ROLLUP with GROUP BY.

	2. Starting with MySQL 8.0.1, the server supports 
	the SQL GROUPING function.  
	
	3. The GROUPING function is used to distinguish 
	between a NULL representing the set of all values 
	in a super-aggregate row  (produced by a ROLLUP 
	operation) from a NULL in a regular row.

	4. MySQL server has supported GROUP BY extension 
	ROLLUP for sometime now.  

Here is an example of how to use ROLLUP with GROUP BY.

~~~sql
mysql> create table t1 (a integer, b integer, c integer);
Query OK, 0 rows affected (0.05 sec)

mysql> insert into t1 values (111,11,11);
mysql> insert into t1 values (222,22,22);
mysql> insert into t1 values (111,12,12);
mysql> insert into t1 values (222,23,23);

mysql> select * from t1;
+------+------+------+
| a    | b    | c    |
+------+------+------+
|  111 |   11 |   11 |
|  222 |   22 |   22 |
|  111 |   12 |   12 |
|  222 |   23 |   23 |
+------+------+------+
4 rows in set (0.00 sec)
~~~

GROUP BY ... WITH ROLLUP:

~~~sql
mysql> SELECT a, b, SUM(c) as SUM 
       FROM t1 
       GROUP BY a,b WITH ROLLUP; 
1  +------+------+------+
2  | a    | b    | SUM  |
3  +------+------+------+
4  |  111 |   11 |   11 |
5  |  111 |   12 |   12 |
6  |  111 | NULL |   23 |
7  |  222 |   22 |   22 |
8  |  222 |   23 |   23 |
9  |  222 | NULL |   45 |
10 | NULL | NULL |   68 |
11 +------+------+------+
7 rows in set (0.00 sec)
~~~

	As we see in the above result,  NULL’s 
	are added by the ROLLUP modifier for 
	every super aggregate row.


## Now let us add NULL’s into the table data:

~~~sql
mysql> INSERT INTO t1 values (1111,NULL,112); 
mysql> INSERT INTO t1 values (NULL,112,NULL); 
 
mysql> select * from t1;
+------+------+------+
| a    | b    | c    |
+------+------+------+
|  111 |   11 |   11 |
|  222 |   22 |   22 |
|  111 |   12 |   12 |
|  222 |   23 |   23 |
| 1111 | NULL |  112 |
| NULL |  112 | NULL |
+------+------+------+
6 rows in set (0.00 sec)
~~~

	We have the following result when we 
	query the data with ROLLUP after the 
	addition of NULL’s into table data.

~~~sql
mysql> SELECT a, b, SUM(c) as SUM 
       FROM t1 
       GROUP BY a,b WITH ROLLUP;
1  +------+------+------+
2  | a    | b    | SUM  |
3  +------+------+------+
4  | NULL |  112 | NULL |
5  | NULL | NULL | NULL |
6  |  111 |   11 |   11 |
7  |  111 |   12 |   12 |
8  |  111 | NULL |   23 |
9  |  222 |   22 |   22 |
10 |  222 |   23 |   23 |
11 |  222 | NULL |   45 |
12 | 1111 | NULL |  112 |
13 | 1111 | NULL |  112 |
14 | NULL | NULL |  180 |
15 +------+------+------+
11 rows in set (0.01 sec)
~~~

## What does NULL mean now?

	As we can see in the above example, 
	it is now difficult to distinguish 
	whether a  NULL is representing a 
	
	   1. regular grouped value OR 
	   2. a super-aggregate value.


# What is new in MySQL-8.0.1

	1. The GROUPING function can be used 
	in the above example to differentiate 
	NULLs produced by ROLLUP from NULLs 
	from the grouped data.  
	
	2. GROUPING function for a column returns 
	a value of 1 when the NULL generated for 
	that column is a result of ROLLUP operation. 
	Else it returns a value of 0.


~~~sql
mysql> SELECT a, b, SUM(c) as SUM, GROUPING(a), GROUPING(b) 
       FROM t1 
       GROUP BY a,b WITH ROLLUP;
1  +------+------+------+-------------+-------------+
2  | a    | b    | SUM  | GROUPING(a) | GROUPING(b) |
3  +------+------+------+-------------+-------------+
4  | NULL |  112 | NULL |           0 |           0 |
5  | NULL | NULL | NULL |           0 |           1 |
6  |  111 |   11 |   11 |           0 |           0 |
7  |  111 |   12 |   12 |           0 |           0 |
8  |  111 | NULL |   23 |           0 |           1 |
9  |  222 |   22 |   22 |           0 |           0 |
10 |  222 |   23 |   23 |           0 |           0 |
11 |  222 | NULL |   45 |           0 |           1 |
12 | 1111 | NULL |  112 |           0 |           0 |
13 | 1111 | NULL |  112 |           0 |           1 |
14 | NULL | NULL |  180 |           1 |           1 |
15 +------+------+------+-------------+-------------+
11 rows in set (0.01 sec)
~~~

	As we see in the above example,  GROUPING(b) 
	returns a value of 1 only for those rows which 
	have NULLs produced by a ROLLUP operation.


# Another way of using the GROUPING function

	Another way of using the GROUPING function 
	is by passing multiple columns as arguments 
	to a single GROUPING function. 
	
	The result of the GROUPING function would 
	then be an integer bit mask having 1’s for 
	the arguments which have GROUPING(argument) as 1.


For example:

~~~sql
mysql> SELECT a, b, SUM(c) as SUM, GROUPING(a,b) 
       FROM t1 
       GROUP BY a,b WITH ROLLUP;
1  +------+------+------+---------------+
2  | a    | b    | SUM  | GROUPING(a,b) |
3  +------+------+------+---------------+
4  | NULL |  112 | NULL |             0 |
5  | NULL | NULL | NULL |             1 |
6  |  111 |   11 |   11 |             0 |
7  |  111 |   12 |   12 |             0 |
8  |  111 | NULL |   23 |             1 |
9  |  222 |   22 |   22 |             0 |
10 |  222 |   23 |   23 |             0 |
11 |  222 | NULL |   45 |             1 |
12 | 1111 | NULL |  112 |             0 |
13 | 1111 | NULL |  112 |             1 |
14 | NULL | NULL |  180 |             3 |
15 +------+------+------+---------------+
11 rows in set (0.00 sec)
~~~

	As seen here, 
	
	if GROUPING (a,b) returns 3, 
	    it means that NULL in column “a” and NULL 
        in column “b” for that row is produce by a 
	    ROLLUP operation. 
	
	If result is 1, 
	    NULL in column “b” alone 
	    is a result of ROLLUP operation.


# Other uses of GROUPING function

	We can specify GROUPING function in a 
	select list or in a having condition. 
	When specified in having condition, we 
	can use this function to retrieve 
	
	    only super-aggregate rows 
	    
	            OR 
	            
	    only aggregate rows like 
	    
	in the example below.

~~~sql
mysql> SELECT a, b, SUM(c) as SUM 
       FROM t1 
       GROUP BY a,b WITH ROLLUP 
       HAVING GROUPING(a) = 1 or GROUPING(b) = 1;
   +------+------+------+
   | a    | b    | SUM  |
   +------+------+------+
1  | NULL | NULL | NULL |
2  |  111 | NULL |   23 |
3  |  222 | NULL |   45 |
4  | 1111 | NULL |  112 |
5  | NULL | NULL |  180 |
   +------+------+------+
5 rows in set (0.00 sec)
~~~


	We can also use GROUPING function to 
	differentiate super aggregates from 
	aggregates in a nice way as shown below:

~~~sql
mysql> SELECT 
         IF(GROUPING(a)=1,'All Departments', a) as Department, 
         IF(GROUPING(b)=1, 'All Employees', b) as Employees, 
         SUM(c) as SUM 
         FROM t1 GROUP BY a,b WITH ROLLUP;
+-----------------+---------------+------+
| Department      | Employees     | SUM  |
+-----------------+---------------+------+
| NULL            | 112           | NULL |
| NULL            | All Employees | NULL |
| 111             | 11            |   11 |
| 111             | 12            |   12 |
| 111             | All Employees |   23 |
| 222             | 22            |   22 |
| 222             | 23            |   23 |
| 222             | All Employees |   45 |
| 1111            | NULL          |  112 |
| 1111            | All Employees |  112 |
| All Departments | All Employees |  180 |
+-----------------+---------------+------+
11 rows in set (0.00 sec)
~~~

	Those were some of the uses of newly added 
	GROUPING function in MySQL server.


# CUBE FUNCTION in MySQL

There is no CUBE function in MySQL.

But we can simulate it.

Consider the following data:

~~~sql
mysql> create table t2(country text, year int, sales int);
mysql> insert into t2(country, year, sales) values('USA', 2020, 2);
mysql> insert into t2(country, year, sales) values('USA', 2020, 3);
mysql> insert into t2(country, year, sales) values('USA', 2020, 4);
mysql> insert into t2(country, year, sales) values('USA', 2024, 1);
mysql> insert into t2(country, year, sales) values('USA', 2024, 6);
mysql> insert into t2(country, year, sales) values('CANADA', 2020, 1);
mysql> insert into t2(country, year, sales) values('CANADA', 2020, 2);
mysql> insert into t2(country, year, sales) values('CANADA', 2024, 5);
mysql> insert into t2(country, year, sales) values('CANADA', 2024, 6);
mysql> insert into t2(country, year, sales) values('CANADA', 2024, 7);
mysql> insert into t2(country, year, sales) values('CANADA', 2024, 2);

mysql> select * from t2;
+---------+------+-------+
| country | year | sales |
+---------+------+-------+
| USA     | 2020 |     2 |
| USA     | 2020 |     3 |
| USA     | 2020 |     4 |
| USA     | 2024 |     1 |
| USA     | 2024 |     6 |
| CANADA  | 2020 |     1 |
| CANADA  | 2020 |     2 |
| CANADA  | 2024 |     5 |
| CANADA  | 2024 |     6 |
| CANADA  | 2024 |     7 |
| CANADA  | 2024 |     2 |
+---------+------+-------+
11 rows in set (0.00 sec)
~~~

## GROUP BY

~~~sql
mysql> select country, year, sum(sales) 
       from t2 
       group by country, year order by country;
+---------+------+------------+
| country | year | sum(sales) |
+---------+------+------------+
| CANADA  | 2020 |          3 |
| CANADA  | 2024 |         20 |
| USA     | 2020 |          9 |
| USA     | 2024 |          7 |
+---------+------+------------+
4 rows in set (0.00 sec)
~~~

## GROUP BY WITH ROLLUP (group by country, year)

~~~sql
mysql> select country, year, sum(sales) 
       from t2 
       group by country, year with rollup order by country;
+---------+------+------------+
| country | year | sum(sales) |
+---------+------+------------+
| NULL    | NULL |         39 |
| CANADA  | 2020 |          3 |
| CANADA  | 2024 |         20 |
| CANADA  | NULL |         23 |
| USA     | 2020 |          9 |
| USA     | 2024 |          7 |
| USA     | NULL |         16 |
+---------+------+------------+
7 rows in set (0.01 sec)
~~~

## GROUP BY WITH ROLLUP (group by year, country)

~~~sql
mysql> select country, year, sum(sales) 
       from t2 
       group by  year, country with rollup order by country;
+---------+------+------------+
| country | year | sum(sales) |
+---------+------+------------+
| NULL    | 2020 |         12 |
| NULL    | 2024 |         27 |
| NULL    | NULL |         39 |
| CANADA  | 2020 |          3 |
| CANADA  | 2024 |         20 |
| USA     | 2020 |          9 |
| USA     | 2024 |          7 |
+---------+------+------------+
7 rows in set (0.01 sec)
~~~

# CUBE Operation

~~~sql
mysql> select country, year, sum(sales) from t2 
       group by country, year with rollup
       
       UNION
       
       select country, year, sum(sales) from t2 
       group by year, country with rollup 
       
       order by country;
       
+---------+------+------------+
| country | year | sum(sales) |
+---------+------+------------+
| NULL    | NULL |         39 |
| NULL    | 2020 |         12 |
| NULL    | 2024 |         27 |
| CANADA  | 2020 |          3 |
| CANADA  | 2024 |         20 |
| CANADA  | NULL |         23 |
| USA     | 2020 |          9 |
| USA     | 2024 |          7 |
| USA     | NULL |         16 |
+---------+------+------------+
9 rows in set (0.00 sec)

~~~

