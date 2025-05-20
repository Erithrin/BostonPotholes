/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('silver.bos_pothole_repair_req', 'U') IS NOT NULL
    DROP TABLE silver.bos_pothole_repair_req;
GO

CREATE TABLE silver.bos_pothole_repair_req (
	case_enquiry_id nvarchar(50),
	open_date  datetime ,
	closed_date datetime ,
	time_taken DECIMAL(10,2),
	on_time nvarchar(50),
	case_status nvarchar(50),
	case_title nvarchar(300),
	neighborhood nvarchar(50),
	latitude nvarchar(50),
	longitude nvarchar(50),
	geo nvarchar(300),
	sources nvarchar(50)
);
GO 