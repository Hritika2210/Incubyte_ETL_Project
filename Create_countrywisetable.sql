CREATE PROCEDURE CreateCountrywiseTables
AS
BEGIN
    DECLARE @Country NVARCHAR(255)
    DECLARE @TableName NVARCHAR(255)
    DECLARE @SQL NVARCHAR(MAX)

    -- Create a cursor to iterate through each distinct country
    DECLARE CountryCursor CURSOR FOR
    SELECT DISTINCT Country FROM tata_sky.[dbo].[Stg_tableview1]

    OPEN CountryCursor
    FETCH NEXT FROM CountryCursor INTO @Country

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Construct the table name by replacing spaces and other characters to be safe
        SET @TableName = REPLACE(@Country, ' ', '_')
        SET @TableName = REPLACE(@TableName, '-', '_')
        SET @TableName = REPLACE(@TableName, '.', '_')
        SET @TableName = LEFT(@TableName, 128) -- Ensure table name is not too long
        SET @TableName = '[' + @TableName + '_TABLE' + ']'
        
        -- Construct the SQL to drop and create a new table for the country
        SET @SQL = '
        IF OBJECT_ID(''dbo.' + @TableName + ''', ''U'') IS NOT NULL
        BEGIN
            DROP TABLE dbo.' + @TableName + ';
        END;

        CREATE TABLE dbo.' + @TableName + ' (
            Customer_Name NVARCHAR(255),
            Customer_ID CHAR(18),
            Open_Date CHAR(8),
            Last_Consulted_date DATE,
            Vaccination_type CHAR(5),
            Dr_Name NVARCHAR(255),
            State NVARCHAR(255),
            Country NVARCHAR(255),
            Post_code NVARCHAR(50),
            DOB DATE,
            Is_Active CHAR(1)
        );

        INSERT INTO dbo.' + @TableName + ' (
            Customer_Name,
            Customer_ID,
            Open_Date,
            Last_Consulted_date,
            Vaccination_type,
            Dr_Name,
            State,
            Country,
            Post_code,
            DOB,
            Is_Active
        )
        SELECT
            Customer_Name,
            Customer_ID,
            Open_Date,
            Last_Consulted_date,
            Vaccination_type,
            Dr_Name,
            State,
            Country,
            Post_code,
            DOB,
            Is_Active
        FROM tata_sky.[dbo].[Stg_tableview1]
        WHERE Country = @Country;'
        
        -- Execute the dynamic SQL
        EXEC sp_executesql @SQL, N'@Country NVARCHAR(255)', @Country

        -- Fetch the next country
        FETCH NEXT FROM CountryCursor INTO @Country
    END

    CLOSE CountryCursor
    DEALLOCATE CountryCursor
END
GO
