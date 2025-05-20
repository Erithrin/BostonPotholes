/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/
CREATE
	OR

ALTER PROCEDURE silver.load_silver
AS
BEGIN
	DECLARE @start_time DATETIME
		,@end_time DATETIME
		,@batch_start_time DATETIME
		,@batch_end_time DATETIME;

	BEGIN TRY
		SET @batch_start_time = GETDATE();

		PRINT '>> Truncating Table: silver.bos_pothole_repair_req';

		TRUNCATE TABLE silver.bos_pothole_repair_req;

		SET @start_time = GETDATE();

		PRINT '>> Inserting Data Into: silver.bos_pothole_repair_req';

		INSERT INTO silver.bos_pothole_repair_req (
			case_enquiry_id
			,open_date
			,closed_date
			,on_time
			,case_status
			,case_title
			,neighborhood
			,latitude
			,longitude
			,geo
			,sources
			)
		SELECT case_enquiry_id
			,open_dt AS open_date
			,closed_dt AS closed_date
			,on_time
			,case_status
			,case_title
			,neighborhood
			,latitude
			,longitude
			,geom_4326 AS geo
			,sources
		FROM bronze.bos_pothole_repair_req
		WHERE neighborhood <> NULL
			OR neighborhood <> ''
			AND case_title LIKE '%othole%'

		SET @end_time = GETDATE();

		PRINT '>> Load Duration for data: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();

		PRINT '=========================================='
		PRINT 'Loading silver Layer is Completed';
		PRINT 'Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	END TRY

	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING silver LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END