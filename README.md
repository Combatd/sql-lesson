# SQL Lesson 

## Objectives 

- Review SQL & database vocab
- SQL Basics (i.e. Syntax, Previewing data, DISTINCT, ORDER BY)
- Filter data using WHERE clause
- Aggregate Functions (SUM, COUNT, AVG, etc.)
- CASE Statements
- Joins/Unions 
- Subqueries (Common Table Expressions)



### What is SQL?

- SQL = Structured Query Language
- SQL lets you access and maniuplate databases 
- SQL is an ANSI (American National Standards Institute) standard



### What is a RDBMS?

- RDBMS = Relational Database Management System
- SQL is the standard language for Relation Database System. All relational database management systems like MySQL, MS Access, Oracle, PostgreSQL



### Database Types

- Data Types
  - Character datatypes: Think Text 'strings'
    - CHAR
    - NCHAR
  - Numeric Datatypes



### Fact Tables

- event based
- usually updated frequently 
- usually larger



### Dimension/Reference Tables

- hold descriptive info
- usually smaller
- updated less frequently 



### Keys

- A table referencing another table is a foreign key
- Foreign Keys can be different data types 



### Query List

- SELECT
- FROM
- JOIN
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- LIMIT

### DISTINCT 

- used to return only different values from a column 

- If you did multiple colums using DISTINCT , you'll get **unique** **combinations** of both those colums from a table 

  - ```sqlite
    SELECT DISTINCT vendor, category_name 
    FROM Sales 
    ```

    

### ORDER BY 

- Orders alphabetically/numerically based on selected column

- default is ascending (asc)

  -  descending is (desc) 

  - ```sqlite
    SELECT	DISTINCT vendor, category_name
    FROM		Sales
    ORDER BY vendor desc
    ```

- To customize order columns use numbers 

  - ```sqlite
    SELECT	DISTINCT vendor, category_name
    FROM		Sales
    ORDER BY 2, 1
    ```

  - This mneans order by category_name, vendor



### WHERE clause

- TEXT

  - ```sql
    SELECT		*
    FROM		sales
    WHERE		county = 'Scott'
    
    -- can also use lower() and upper() to standardize queries
    
    SELECT		*
    FROM		sales
    WHERE		lower(county) = 'scott' -- actually references to Scot
    ```

  - Using <u>%</u> 

  - ```sql
    SELECT 		*
    FROM 			sales
    WHERE			category_name LIKE '%VODKA%' 
    -- % are placeholders that represent any text 
    -- in this case, it is any text left or right of 'VODKA'
    
    SELECT 		*
    FROM 			sales
    WHERE			category_name NOT LIKE '%VODKA%' 
    -- nothing with vodka in it ^ 
    ```

    

- <u>OR</u>

  - ```sql
    SELECT		*
    FROM			sales
    WHERE			lower(county) = 'scott' OR county = 'Polk' OR county = 'Dallas'
    ```

  - short hand for above using <u>IN</u>

    - ```sql
      SELECT		*
      FROM			sales
      WHERE		 	county IN ('Scott', 'Polk', 'Dallas')
      ```

  - also there is <u>NOT IN</u>

    - ```sql
      SELECT		*
      FROM			sales
      WHERE	 		county NOT IN ('Scott', 'Polk', 'Dallas')
      ```

- Numeric

  - ```sql
    SELECT		*
    FROM 			sales
    WHERE			total > 1000
    ```

  - ```sql
    SELECT		*
    FROM 			sales
    WHERE			total > 1000 AND total < 3000
    ```

  - Short hand for above using <u>BETWEEN</u> 

    - ```sql
      SELECT		*
      FROM 			sales
      WHERE			total BETWEEN 1000 AND 3000
      ```

  - If numbers are formatted as TEXT ... use <u>CAST</u> (<column> as <data type>)

    - ```sql
      SELECT 		*
      FROM 			sales
      WHERE			CAST(total as numeric) BETWEEN 1000 AND 3000 
      ```





## Filtering, Functions, & Aggregation 

- Aggregations & Group By

  - Used to summarize the reuslts o a particular colum in the SELECT Statment
  - Usually accompanied by <u>GROUP BY</u>

- ```sql
  SELECT SUM(total), COUNT(total), AVG(total), MIN(total), MAX(total)
  From Sales 
  
  -- Count is the amount of rows 
  -- MIN is minimum total
  -- MAX is maximum total 
  
  -- you can use 'as' to rename columns temporarily 
  
  SELECT SUM(total) as total_sales
  From Sales 
  
  -- you can use 'ROUND' to round numbers to a decimal places 
  SELECT ROUND(AVG(total), 2) --round to 2 decimal places 
  From Sales 
  ```

- Using <u>SUM</u>(<column>)

  - ```sql
    SELECT SUM(total) FROM sales
    ```

- Using <u>GROUP BY</u>

  - ```sql
    SELECT 	vendor, SUM(total) 
    FROM 		sales
    GROUP BY vendor 
    ORDER BY SUM(total) desc -- or u could write 2 desc (2 being column 2)
    -- give me the total sums of each vendor
    ```

- Using <u>COUNT</u>

  ```sql
  SELECT COUNT(*) FROM sales -- how manny rows are in this table? 
  SELECT COUNT(category_name) FROM sales 
  SELECT COUNT(DISTINCT category_name) FROM sales
  ```



### Case Statements

- Case Statement Logic

  - ```sql 
    CASE WHEN [Value1_criteria] THEN 'Value1'
    		 WHEN [Value2_criteria] THEN 'Value2'
    		 WHEN [Value3_criteria] THEN 'Value3'
    		 ELSE 'NonCriteria_Value'
    		 END as Column_name
    ```



### Types of Joins

- Now we'll examine the difference between the left join and the inner join
- Left Join ~ Keeps all the records rom the first table (a), and appends the fields from the second table (b) where ther is a match.
  - Returns NULL where there is not match
- Inner Join ~ Only includes data where the comon value is in both tables 



### UNION

- Think of it as stacking tables on top of one another

- Deletes duplicate rows 

  - ```sql
    SELECT *
    FROM fy17p
    
    UNION
    
    SELECT * 
    FROM	fy18p
    ```

  - UNION ALL

    - does not remove duplicate rows while UNION does 

-  Must have <u>same number of columns</u> 

- Columns must have to carry the <u>same data type</u>



### Common Table Expressions - Subqueries 

- Sub query : query within a query

  - ```sql
    SELECT *
    FROM 
    (SELECT * FROM Stores Limit 5)
    ```

- Flexible simplified way to use subqueries
- 