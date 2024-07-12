**Incubyte Assignment**

### 1. Data Exploration:

I started project with data exploration where the column variables were given in the assessment. After careful analysis, created sample dataset in CSV format (| delimeter) using open source tool. I made sure that the hospital dataset contains all the possible values with variable filled length.

### 2. Dashboard Development:

*Approach to designing and developing a ETL pipeline:*
**Designing Data Flow
1. *Source*: Added an OLE DB Source component and configure it to fetch data from  source. Here I selected source as flat file since our source file was in csv format.
 2. *Destination*:  Once the source established, dragged OLE DB destination to store data into the SQL table. For this I created an table structure that aligned with hospital dataset.
3. * Transformation and Load*: Now the dataset would have been load into the SQL table. As per assessment requirements where we need to create SQL table from Country column. To achieve this, I created a stored procedure where the distinct country will be stored in the variable and after looping through column , we created the table in the required format and inserted the country wise data into table in required format.
I have uploaded documentation that contains screenshot of the process along with Stored Procedure SQL query and SSIS file.
