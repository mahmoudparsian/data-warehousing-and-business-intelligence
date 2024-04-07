# Access MySQL from Jupyter

# 1. Invoke Jupyter

For example, you may invoke Jupyter from command line as:

	jupyter notebook


# 2. Then automatically Jupyter browser will be launched as:

	http://localhost:8888/tree


# 3. Create a New Python3 (ipykernel) window 

Click on "New" and then select "Python3 (ipykernel)" 
from drop-down:

This will launch a new browser window such as:

	http://localhost:8888/notebooks/Untitled57.ipynb


# 4. Install `ipython-sql`

To connect to MySQL database, the first thing we 
need to do is load the extension. Run the following 
command in the Jupyter notebook:

Inside new browser window, execute the following:

	%pip install ipython-sql


# 5. Thn execute:

	%load_ext sql


# 6. Then execute

	%pip install mysqlclient


# 7. Create a Connection to MySQL Database as 

Here we connect to the `test` database:

	%sql mysql://<db-user>:<db-password>@127.0.0.1/test

	for example:

	%sql mysql://root:mypassword@127.0.0.1/test


# 8. Now you can execute SQL queries using your MySQL Database:

	%sql show tables;

	%sql select * from sales;
