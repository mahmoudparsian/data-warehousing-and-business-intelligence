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

![Alt text](data:image/png;base64,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)

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
