/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'BostonPotholes' after checking if it already exists. 
    If the database exists, it is dropped and recreated. 
	
WARNING:
    Running this script will drop the entire 'BostonPotholes' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


use master;
go

if exists(select 1 from sys.databases where name = 'BostonPotholes')
begin
	alter database BostonPotholes set single_user with rollback immediate;
	drop database BostonPotholes;
end;

create database BostonPotholes;
go

use BostonPotholes;
go

--create schema gold - ingestion layer
create schema bronze;
go

--create schema silver - transformation layer
create schema silver;
go

