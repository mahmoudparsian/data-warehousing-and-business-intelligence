# Practice SQL JOINS: A Hands-on Tutorial

SQL INNER JOIN Example

![Alt text](https://www.programiz.com/sites/tutorial2program/files/inner-join-in-sql.png)

![Alt text](https://lh4.googleusercontent.com/ZaF77tpvsDLgQgWHqOdbzJVPDJ2EAmp4OSSmbk0sSFe4TcsS3jtxY7EmyfMQ3ta6WIs7bg_ZvKsUZOHkXETHRltRXC5YNi4brzpchn4HBzq4dThms2jAyU9E2KohfEL7j0fOevT5PeMdOdKEJj24C1Y)

![Alt text](https://www.tutorialspoint.com/sql/images/innerjoin_2.jpg)

https://www.programiz.com/sites/tutorial2program/files/inner-join-in-sql.png

https://lh4.googleusercontent.com/ZaF77tpvsDLgQgWHqOdbzJVPDJ2EAmp4OSSmbk0sSFe4TcsS3jtxY7EmyfMQ3ta6WIs7bg_ZvKsUZOHkXETHRltRXC5YNi4brzpchn4HBzq4dThms2jAyU9E2KohfEL7j0fOevT5PeMdOdKEJj24C1Y

https://www.tutorialspoint.com/sql/images/innerjoin_2.jpg

# Understanding INNER Join

## Table structure for employees

~~~sql
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `eid` int,
  `ename` text,
  `dept_id` int,
  `salary` int
);
~~~

## Records of employees

~~~sql
INSERT INTO `employees` (`eid`, `ename`, `dept_id`, `salary`)
 VALUES 
(5800, 'Alex', 100, 34000), 
(5801, 'Bob',  100, 35000), 
(5802, 'Jane', 200, 37000), 
(5803, 'Alex', 200, 38000), 
(5804, 'David', 300, 34000);
~~~

## Table structure for departments

~~~sql
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `dept_id` int,
  `dept_name` text,
  `dept_location` text
);
~~~

## Records of departments

~~~sql
INSERT INTO `departments` (`dept_id`, `dept_name`, `dept_location`)
 VALUES 
(100, 'Marketing', 'Sunnyvale'), 
(200, 'Sales',  'Stanford'), 
(300, 'Software', 'Ames'), 
(400, 'Hardware', 'Ames'), 
(500, 'HR', 'Cupertino'),
(500, 'Analytics', 'Palo Alto');
~~~

## View employees


~~~sql
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
~~~

## View departments

~~~sql
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

## Join of employees and departments on `dept_id`

~~~sql
mysql> select e.ename, e.dept_id, d.dept_name 
       from employees e, 
            departments d 
        where e.dept_id = d.dept_id;
        
+-------+---------+-----------+
| ename | dept_id | dept_name |
+-------+---------+-----------+
| Bob   |     100 | Marketing |
| Alex  |     100 | Marketing |
| Alex  |     200 | Sales     |
| Jane  |     200 | Sales     |
| David |     300 | Software  |
+-------+---------+-----------+
5 rows in set (0.00 sec)
~~~

OR

~~~sql
mysql> select E.ename, E.dept_id, D.dept_name 
       FROM employees E 
       INNER JOIN departments D 
       ON E.dept_id = D.dept_id;
       
+-------+---------+-----------+
| ename | dept_id | dept_name |
+-------+---------+-----------+
| Bob   |     100 | Marketing |
| Alex  |     100 | Marketing |
| Alex  |     200 | Sales     |
| Jane  |     200 | Sales     |
| David |     300 | Software  |
+-------+---------+-----------+
5 rows in set (0.00 sec)
~~~


# Music Streaming Service


	Imagine we’re working with a music streaming 
	service’s database, packed with these tables:

		users
		
		songs
		
		plays
		
		
# users table
	
	This table defines users of the music streaming service

	user_id: The unique identifier of the user
	user_name: The name of the user
	email: The email address of the user
	country: The country where the user is located
	plan: The subscription plan of the user, either ‘free’ or ‘premium’

# songs table

	This table hits the right notes with details on 
	the service’s song library. It includes:

	song_id: The unique identifier of the song
	title: The title of the song
	artist: The name of the artist who performed the song
	genre: The genre of the song
	duration: The duration of the song in seconds

# plays table

	And here, we track every time a user plays a song. 
	It’s filled with information on:

	play_id: The unique identifier of the play
	user_id: The user who played the song
	song_id: The song that was played
	time_stamp: The date and time when the song was played
	device: The device used to play the song, either ‘mobile’ or ‘desktop’


# Questions and Answers

	Now, let’s see how we can use SQL joins 
	to answer some questions based on the 
	data from the case study.

## Q0: How many songs did each user play?

Return result by user_id

~~~sql		
     SELECT user_id, COUNT(play_id) AS num_of_plays
		from plays 
		GROUP BY user_id;
~~~


## Q1: How many songs did each user play?
Return result by user_name

	1. We’re going to look at the number of 
	   times users have hit play.

	2. To do this, we need to bring the 
	   ‘users’ and ‘plays’ tables together, 
	   like linking hands, where ‘user_id’ is our handshake.

	3. We’ll use an INNER JOIN for this task.

	4. Then, by grouping our users with the ‘GROUP BY’ clause, 
	   we can keep everything neat and tidy.

	5. Lastly, we’ll call on the COUNT function to reveal 
	   the total plays for each user.

Here is the SQL query:

~~~sql		
     SELECT U.user_name, COUNT(P.play_id) AS num_of_plays
        FROM users U
		INNER JOIN plays P
        ON U.user_id = P.user_id
		GROUP BY U.user_name;
~~~

OR

~~~sql
     SELECT U.user_name, COUNT(P.play_id) AS num_of_plays
        FROM users U,
		     plays P
        where 
             U.user_id = P.user_id
		GROUP BY U.user_name;
~~~

Output:

		user_name   num_of_plays
		---------   ------------
		Alice       2
		Bob         7
		Jane        5
		...         ...
		

## Q1.5: How many distinct/unique songs did each user play?

~~~sql
     SELECT U.user_name, COUNT(distinct P.song_id) AS num_of_plays
        FROM users U,
		     plays P
        where 
             U.user_id = P.user_id
		GROUP BY U.user_name;
~~~

How about getting `user_id` in the result

~~~sql
     SELECT U.user_name, U.user_id, COUNT(distinct P.song_id) AS num_of_plays
        FROM users U,
		     plays P
        where 
             U.user_id = P.user_id
		GROUP BY U.user_name, U.user_id;
~~~

How about just getting by `user_id` only in the result

~~~sql
     SELECT U.user_id, COUNT(distinct P.song_id) AS num_of_plays
        FROM users U,
		     plays P
        where 
             U.user_id = P.user_id
		GROUP BY U.user_id;
~~~

## Q2: What are the titles and genres of the songs played by Alex?

	1. we need to find the titles and genres of 
	   songs that Alex jammed to.

    2. Here’s how we’re going to break it down: 
       we’ll be diving into the ‘users’, ‘plays’, and ‘songs’ 
       tables, connecting them with ‘user_id’ and ‘song_id’ as 
       our key pieces.

    3. We’ll be using an INNER JOIN.

~~~sql
SELECT S.title, S.genre
   FROM users U
   INNER JOIN plays P  ON U.user_id = P.user_id
   INNER JOIN songs S  ON P.song_id = S.song_id
   WHERE U.user_name = 'Alex';
~~~

OR

~~~sql
SELECT S.title, S.genre
   FROM 
       users U,
       plays P, 
       songs S  
       
   WHERE 
         U.user_id = P.user_id AND
         P.song_id = S.song_id AND
         U.user_name = 'Alex';
~~~

Output:

		title           genre
		------------    ------------
		Shape of You    Pop   
		Thunder         Rock
		...

## Q2.5: What are the distinct (titles and genres) of the songs played by Alex?

~~~sql
SELECT S.title, S.genre, count(*) as count
   FROM users U
   INNER JOIN plays P  ON U.user_id = P.user_id
   INNER JOIN songs S  ON P.song_id = S.song_id
   WHERE U.user_name = 'Alex'
   group by S.title, S.genre;
   
+--------------------+---------+-------+
| title              | genre   | count |
+--------------------+---------+-------+
| The 1              | country |     3 |
| Afterglow          | country |     2 |
| Please Please Me   | rock    |     5 |
| 2step              | pop     |     3 |
| The A Team         | pop     |     2 |
| Requiem In D Minor | classic |     2 |
| Piano Concerto     | classic |     3 |
+--------------------+---------+-------+
7 rows in set (0.01 sec)
~~~

OR

~~~sql
-- Default JOIN = INNER JOIN
SELECT S.title, S.genre, count(*) as count
   FROM 
       users U,
       plays P,
       songs S  
   WHERE       
        U.user_id = P.user_id AND
        P.song_id = S.song_id AND
        U.user_name = 'Alex'
   group by S.title, S.genre;

+--------------------+---------+-------+
| title              | genre   | count |
+--------------------+---------+-------+
| The 1              | country |     3 |
| Afterglow          | country |     2 |
| Please Please Me   | rock    |     5 |
| 2step              | pop     |     3 |
| The A Team         | pop     |     2 |
| Requiem In D Minor | classic |     2 |
| Piano Concerto     | classic |     3 |
+--------------------+---------+-------+
7 rows in set (0.01 sec)
~~~

	
		
## Q3: Which users have played songs by Ed Sheeran?

	Now, Let’s figure out which users have been tuning 
	into Ed Sheeran’s hits.

	To solve this, we’re going to sift through the 
	‘users’, ‘plays’, and ‘songs’ tables, linking them 
	up using ‘user_id’ and ‘song_id’.

	We’ll keep using an INNER JOIN, our go-to move for 
	making sure we only spotlight rows where there’s a 
	match across the board.

	Then, to find Ed Sheeran’s audience, we’ll dial in 
	with the WHERE clause, focusing squarely on his tracks.
	
~~~sql
-- ALL user_name(s)
SELECT u.user_name
FROM users U

INNER JOIN plays P
ON U.user_id = P.user_id

INNER JOIN songs S
ON P.song_id = S.song_id

WHERE s.artist = 'Ed Sheeran';
~~~

OR

~~~sql
SELECT u.user_name
FROM 
     users U,
     plays P,
     songs S
WHERE 
     U.user_id = P.user_id AND
     P.song_id = S.song_id AND
     s.artist = 'Ed Sheeran';
~~~

Find Distinct users

~~~sql
SELECT distinct u.user_name
FROM users U

INNER JOIN plays P
ON U.user_id = P.user_id

INNER JOIN songs S
ON P.song_id = S.song_id

WHERE s.artist = 'Ed Sheeran';
~~~

## Q3.5 Find Distinct users and count

Find Distinct users and count

~~~sql
SELECT u.user_name, count(*) as count
FROM users U

INNER JOIN plays P
ON U.user_id = P.user_id

INNER JOIN songs S
ON P.song_id = S.song_id

WHERE s.artist = 'Ed Sheeran'

GROUP BY u.user_name;

+-----------+-------+
| user_name | count |
+-----------+-------+
| alex      |     5 |
| jane      |     4 |
| betty     |     4 |
| rafa      |     6 |
| ted       |     3 |
| al        |     5 |
| david     |     3 |
| carlos    |     5 |
| fiona     |     3 |
| albert    |     3 |
+-----------+-------+
10 rows in set (0.00 sec)
~~~



## Q4: Which songs have not been played by any users?

	1. Let’s dive into discovering which tracks 
	have NOT yet had the chance to grace anyone’s 
	playlist.

	2. We’re going to explore the ‘songs’ and ‘plays’ tables, 
	connecting them through the ‘song_id’.

	3. For this task, we’ll use a LEFT JOIN.
	
		If a song doesn’t match with any plays, 
		it remains empty, indicated by NULL in 
		the ‘plays’ table columns related to it.
		
	4. To highlight these yet-to-be-played tracks, 
	   we’ll employ the WHERE clause, looking 
	   specifically for those instances where 
	   ‘play_id’ is a telling NULL.

	5. What is the case for using LEFT-JOIN:

		Common use cases for LEFT JOIN include: 
		Displaying all items: When you want to 
		display all items from the left table, 
		even if there are NO corresponding items 
		in the right table. 
	
	6. Handling missing data: 
			When you need to handle situations where 
			data might be missing or incomplete in 
			one of the tables.

Here is the SQL query:

~~~sql
-- left table: songs
-- right table: plays

      SELECT S.song_id, S.title, S.artist
         FROM songs S
         LEFT JOIN plays P
         ON s.song_id = p.song_id

         WHERE p.play_id IS NULL;
~~~

~~~sql
-- for debugging and testing:

      SELECT S.song_id, S.title, S.artist, P.play_id
         FROM songs S
         LEFT JOIN plays P
         ON s.song_id = p.song_id
~~~


## Q5: Which users have a premium plan and have played songs on a mobile device?


	1. To get this task started, we’re going to merge 
	   information from the ‘users’ and ‘plays’ tables, 
	   connecting them with the ‘user_id’ as our linking point.
	   
	2. For this journey, an INNER JOIN is our ticket.
	   It helps us find those exact matches where the 
	   details in both tables sync up perfectly.
	   
	3. But here’s where it gets interesting: we’ll use 
	   the WHERE clause to fine-tune our search.
	
	   We’re looking for the elite group of users who have 
	   premium access and prefer their beats on the go, 
	   using their mobiles.
	

Here is the SQL query:

~~~sql
SELECT U.user_name, U.email
FROM users U
INNER JOIN plays P
ON U.user_id = P.user_id
WHERE U.plan = 'premium'
AND p.device = 'mobile';
~~~

OR

~~~sql
SELECT U.user_name, U.email
FROM 
     users U,
     plays P
WHERE
     U.user_id = P.user_id AND
     U.plan = 'premium'    AND
     P.device = 'mobile';
~~~

Find Distinct users

~~~sql
SELECT distinct U.user_name, U.email
FROM users U
INNER JOIN plays P
ON U.user_id = P.user_id
WHERE U.plan = 'premium'
AND p.device = 'mobile';
~~~

OR

~~~sql
SELECT distinct U.user_name, U.email
FROM 
     users U,
     plays P
WHERE
     U.user_id = P.user_id AND
     U.plan = 'premium'    AND
     P.device = 'mobile';
~~~



## Q6: Prerequisite: INTERSECT Clause

	INTERSECT limits the result from 
	multiple query blocks to those rows 
	which are common to all. 

~~~sql
mysql> TABLE a;
+------+------+
| m    | n    |
+------+------+
|    1 |    2 |
|    2 |    3 |
|    3 |    4 |
+------+------+
3 rows in set (0.00 sec)

mysql> TABLE b;
+------+------+
| m    | n    |
+------+------+
|    1 |    2 |
|    1 |    3 |
|    3 |    4 |
+------+------+
3 rows in set (0.00 sec)

mysql> TABLE c;
+------+------+
| m    | n    |
+------+------+
|    1 |    3 |
|    1 |    3 |
|    3 |    4 |
+------+------+
3 rows in set (0.00 sec)
~~~

## TABLE a INTERSECT TABLE b

~~~sql
mysql> TABLE a INTERSECT TABLE b;
+------+------+
| m    | n    |
+------+------+
|    1 |    2 |
|    3 |    4 |
+------+------+
2 rows in set (0.00 sec)
~~~

## TABLE a INTERSECT TABLE c

~~~sql
mysql> TABLE a INTERSECT TABLE c;
+------+------+
| m    | n    |
+------+------+
|    3 |    4 |
+------+------+
1 row in set (0.00 sec)
~~~

## Q6: Which songs have been played by both Alex and Jane?

	1. So, identifying the songs that both Alex and Jane 
	   have rocked out to? —
	
	2. We’re going to sift through the 
	  ‘users’, ‘plays’, and ‘songs’ tables, 
	  using ‘user_id’ and ‘song_id’ as our 
	  guides to connect the dots.

	3. We’ll stick with an INNER JOIN for this task.

	But that’s just the start. 
	
	4. To pinpoint our musical duo, Alex and Jane, 
	   we’ll bring in the WHERE clause, filtering 
	   the data to focus exclusively on them.

	5. And here’s where the magic happens: 
	   we’ll use the INTERSECT operator.
	
	6. This tool helps us uncover the songs that 
	    both Alice and Bob have enjoyed, showing 
	    us where their musical tastes intersect.

Here is the SQL query:

~~~sql
SELECT s.title, s.artist
FROM users u
INNER JOIN plays p
ON u.user_id = p.user_id
INNER JOIN songs s
ON p.song_id = s.song_id
WHERE u.user_name = 'Alex'

INTERSECT

SELECT s.title, s.artist
FROM users u
INNER JOIN plays p
ON u.user_id = p.user_id
INNER JOIN songs s
ON p.song_id = s.song_id
WHERE u.user_name = 'Jane';
~~~

OR

~~~sql
SELECT s.title, s.artist
FROM users u,
     plays p,
     songs s
WHERE
      u.user_id = p.user_id  AND
      p.song_id = s.song_id  AND
      u.user_name = 'Alex'

INTERSECT

SELECT s.title, s.artist
FROM users u,
     plays p,
     songs s
WHERE
      u.user_id = p.user_id  AND
      p.song_id = s.song_id  AND
      u.user_name = 'Jane';
~~~

# Q7: Which users have played songs from different genres?

	1. We’ll navigate this by linking the 
	   ‘users’, ‘plays’, and ‘songs’ tables, 
	   with ‘user_id’ and ‘song_id’ serving 
	   as our trusted guides.

	2. An INNER JOIN is our tool of choice here, 
	   ensuring we only consider rows where the 
	   connections are clear and consistent across 
	   all tables involved.

	3. Now, to get a real sense of each user’s musical 
	   adventure, we’ll organize our data with the 
	   GROUP BY clause, clustering the information by user.
	   
	4. But we’re not stopping there. To identify those 
	   adventurers who’ve ventured through various musical 
	   landscapes, we’ll use the HAVING clause.
	   
Here is the SQL query:

~~~sql
--
-- select with count of genre
--
SELECT u.user_name, u.country, COUNT(DISTINCT s.genre)
FROM users u
INNER JOIN plays p
ON u.user_id = p.user_id
INNER JOIN songs s
ON p.song_id = s.song_id
GROUP BY u.user_name, u.country
HAVING COUNT(DISTINCT s.genre) > 1;
~~~


~~~sql
--
-- select without count of genre
--
SELECT u.user_name, u.country
FROM users u
INNER JOIN plays p
ON u.user_id = p.user_id
INNER JOIN songs s
ON p.song_id = s.song_id
GROUP BY u.user_name, u.country
HAVING COUNT(DISTINCT s.genre) > 1;
~~~

OR

~~~sql
--
-- select with count of genre
--
SELECT u.user_name, u.country, COUNT(DISTINCT s.genre)
FROM users u,
     plays p,
     songs s
WHERE
      u.user_id = p.user_id  AND
      p.song_id = s.song_id  

GROUP BY u.user_name, u.country

HAVING COUNT(DISTINCT s.genre) > 1;
~~~
