
/*
==================================
DDL Script : Create Bronze Table
==================================

Scripts : These DDL scripts are used to create a table in the BRONZE schema 
Warning : If table exists, the table will be dropped and will be newly created
*/

IF OBJECT_ID('bronze.bos_pothole_repair_req', 'U') IS NOT NULL
    DROP TABLE bronze.bos_pothole_repair_req;
GO

CREATE TABLE bronze.bos_pothole_repair_req (
	case_enquiry_id NVARCHAR(50)
	,open_dt DATETIME
	,sla_target_dt DATETIME
	,closed_dt DATETIME
	,on_time NVARCHAR(50)
	,case_status NVARCHAR(50)
	,closure_reason NVARCHAR(4000)
	,case_title NVARCHAR(300)
	,subjects NVARCHAR(50)
	,reason NVARCHAR(50)
	,typed NVARCHAR(50)
	,queued NVARCHAR(1000)
	,department NVARCHAR(50)
	,submitted_photo NVARCHAR(1300)
	,closed_photo NVARCHAR(1300)
	,locations NVARCHAR(300)
	,fire_district NVARCHAR(500)
	,pwd_district NVARCHAR(1000)
	,city_council_district NVARCHAR(50)
	,police_district NVARCHAR(50)
	,neighborhood NVARCHAR(50)
	,neighborhood_services_district NVARCHAR(50)
	,ward NVARCHAR(50)
	,precinct NVARCHAR(50)
	,location_street_name NVARCHAR(150)
	,location_zipcode NVARCHAR(50)
	,latitude NVARCHAR(50)
	,longitude NVARCHAR(50)
	,geom_4326 NVARCHAR(300)
	,sources NVARCHAR(2000)
	);