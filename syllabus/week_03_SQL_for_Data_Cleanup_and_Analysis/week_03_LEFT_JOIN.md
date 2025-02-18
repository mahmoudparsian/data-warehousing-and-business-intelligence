# What is the case for using LEFT-JOIN:

# LEFT JOIN = LEFT OUTER JOIN

	Common use cases for LEFT JOIN include: 
	
	Displaying all items: When you want to 
	display all items from the left table, 
	even if there are NO corresponding items 
	in the right table. 
	
	Handling missing data: 
	    When you need to handle situations 
	    where data  might  be  missing or 
	    incomplete in one of the tables.


![Alt text](https://www.sqlitetutorial.net/wp-content/uploads/2015/12/SQLite-left-join-example.png)

![Alt text](https://learn.microsoft.com/en-us/power-query/media/merge-queries-left-outer/left-outer-join-operation.png)

![Alt text](https://miro.medium.com/v2/resize:fit:1400/1*4at6xu--rLo5cgUO3sgdDw.png)


# LEFT JOIN Definition

	What is the purpose of left join?
	
	The LEFT JOIN command returns all rows 
	from the left table, and the matching 
	rows from the right table. The result is 
	NULL from the right side, if there is no match.
	


~~~sql
mysql> use testing_joins;


Database changed
mysql> show tables;
+-------------------------+
| Tables_in_testing_joins |
+-------------------------+
| departments             |
| employees               |
+-------------------------+
2 rows in set (0.00 sec)

mysql> select * from employees;
+------+-------+---------+--------+
| eid  | ename | dept_id | salary |
+------+-------+---------+--------+
| 5800 | Alex  |     100 |  34000 |
| 5801 | Bob   |     100 |  35000 |
| 5802 | Jane  |     200 |  37000 |
| 5803 | Alex  |     200 |  38000 |
| 5804 | David |     300 |  34000 |
+------+-------+---------+--------+
5 rows in set (0.00 sec)

mysql> select * from departments;
+---------+-----------+---------------+
| dept_id | dept_name | dept_location |
+---------+-----------+---------------+
|     100 | Marketing | Sunnyvale     |
|     200 | Sales     | Stanford      |
|     300 | Software  | Ames          |
|     400 | Hardware  | Ames          |
|     500 | HR        | Cupertino     |
|     500 | Analytics | Palo Alto     |
+---------+-----------+---------------+
6 rows in set (0.00 sec)
~~~

### find departments where no employee works for those department(s)

~~~sql
mysql> # find departments where no employee works;
Query OK, 0 rows affected (0.00 sec)


mysql> SELECT departments.dept_id, departments.dept_name, employees.eid 
       FROM  departments 
       LEFT JOIN employees  
       ON departments.dept_id = employees.dept_id;
       
+---------+-----------+------+
| dept_id | dept_name | eid  |
+---------+-----------+------+
|     100 | Marketing | 5801 |
|     100 | Marketing | 5800 |
|     200 | Sales     | 5803 |
|     200 | Sales     | 5802 |
|     300 | Software  | 5804 |
|     400 | Hardware  | NULL |
|     500 | HR        | NULL |
|     500 | Analytics | NULL |
+---------+-----------+------+
8 rows in set (0.00 sec)

SELECT departments.dept_id, departments.dept_name, employees.eid 
       FROM  departments LEFT JOIN employees  
       ON departments.dept_id = employees.dept_id 
       where employees.eid is NULL;
       
+---------+-----------+------+
| dept_id | dept_name | eid  |
+---------+-----------+------+
|     400 | Hardware  | NULL |
|     500 | HR        | NULL |
|     500 | Analytics | NULL |
+---------+-----------+------+
3 rows in set (0.00 sec)

mysql> SELECT departments.dept_id, departments.dept_name 
       FROM  departments 
       LEFT JOIN employees  
       ON departments.dept_id = employees.dept_id 
       where employees.eid is NULL;
       
+---------+-----------+
| dept_id | dept_name |
+---------+-----------+
|     400 | Hardware  |
|     500 | HR        |
|     500 | Analytics |
+---------+-----------+
3 rows in set (0.00 sec)
~~~
