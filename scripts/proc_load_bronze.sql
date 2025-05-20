/*
=====================================================================
Stored Procedure : Loads bronze layer (Source ---> Bronze)

Script Purpose :
This procedure loads data from data.boston.gov source into the bronze tables. The source data is in csv files.

It performs the following actions :
1. Truncates bronze table before loading the data
2. Performs bulk insert to load the data from csv files to bronze table

Parameter: None. This procedure neither accepts any parameters nor does it return any value.

Usage : exec bronze.load_bronze
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
begin try
SET @batch_start_time = GETDATE();
PRINT '>> Truncating Table: bronze.bos_pothole_repair_req';
TRUNCATE TABLE bronze.bos_pothole_repair_req;

set @start_time = GETDATE();
PRINT '>> Inserting Year 2025 Data Into: bronze.bos_pothole_repair_req';
bulk insert bronze.bos_pothole_repair_req
		from 'D:\Professional Certificate for Data Analyst COurse\Projects\boston city 311\datasets\2025_311_data.csv'
		with 
		(
		firstrow = 2,
		fieldterminator = ',',
		rowterminator = '\n',
		tablock
		);
set @end_time = GETDATE();
PRINT '>> Load Duration for 2025 data: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';

set @start_time = GETDATE();
PRINT '>> Inserting Year 2024 Data Into: bronze.bos_pothole_repair_req';
bulk insert bronze.bos_pothole_repair_req
		from 'D:\Professional Certificate for Data Analyst COurse\Projects\boston city 311\datasets\2024_311_data.csv'
		with 
		(
		firstrow = 2,
		fieldterminator = ',',
		rowterminator = '\n',
		tablock
		);
set @end_time = GETDATE();
PRINT '>> Load Duration for 2024 data: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
PRINT '>> -------------';

SET @batch_end_time = GETDATE();
PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT 'Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';

end try
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH

end