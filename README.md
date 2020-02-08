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

