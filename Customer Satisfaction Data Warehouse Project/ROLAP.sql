/****** Object:  Database ist722_hhkhan_cb4_dw    Script Date: 4/17/2020 7:57:19 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_hhkhan_cb4_dw
GO
CREATE DATABASE ist722_hhkhan_cb4_dw
GO
ALTER DATABASE ist722_hhkhan_cb4_dw
SET RECOVERY SIMPLE
GO
*/
USE ist722_hhkhan_cb4_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;



/* Drop table dbo.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimProduct 
;

/* Create table dbo.DimProduct */
CREATE TABLE dbo.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  varchar(500)   NOT NULL
,  [ProductName]  varchar(200)   NOT NULL
,  [ProductDepartment]  varchar(200)   NOT NULL
,  [ProductProducer]  varchar(200)   NOT NULL
,  [ProductReleaseYear]  int   NOT NULL
,  [ProductRating]  varchar(20) DEFAULT 'Unknown Rating' NOT NULL
,  [ProductRuntime]  int DEFAULT -1 NOT  NULL
,  [ProductType]  varchar(20) DEFAULT 'Unknown Type' NOT NULL
,  [ProductDvdAvailable]  bit DEFAULT 0 NOT NULL
,  [ProductBlurayAvailable]  bit DEFAULT 0 NOT NULL
,  [ProductPrice]  money DEFAULT 0 NOT NULL
,  [SourceCompany]  varchar(10)   NOT NULL
,  [RowIsCurrent]  bit DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime DEFAULT '1/1/1900'  NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)  NULL
, CONSTRAINT [PK_dbo.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;



SET IDENTITY_INSERT dbo.DimProduct ON
;
INSERT INTO dbo.DimProduct (ProductKey, ProductID, ProductName, ProductDepartment, ProductProducer, ProductReleaseYear, ProductRating, ProductRuntime, ProductType, ProductDvdAvailable, ProductBlurayAvailable, ProductPrice, SourceCompany, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'Unknown Name', 'Unknown Department', 'Unknown Producer', -1, 'Unknown Rating', -1, 'Unknown Type', 0, 0, 0, 'Unknown',1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimProduct OFF
;


/* Drop table dbo.DimTweetDictionary */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimTweetDictionary') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimTweetDictionary 
;

/* Create table dbo.DimTweetDictionary */
CREATE TABLE dbo.DimTweetDictionary (
   [TweetKey]  int IDENTITY  NOT NULL
,  [TweetID]  varchar(255)   NOT NULL
,  [CustomerEmail]  varchar(100)   NOT NULL
,  [Tweet]  nvarchar(255)   NOT NULL
,  [CustomerID]  int   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '1/1/1900' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimTweetDictionary] PRIMARY KEY CLUSTERED 
( [TweetKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT dbo.DimTweetDictionary ON
;
INSERT INTO dbo.DimTweetDictionary (TweetKey, TweetID, CustomerEmail, Tweet, CustomerID, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'No Email', 'No Tweet', -1, 1, '1/1/1900', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimTweetDictionary OFF
;



/* Drop table dbo.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimCustomer 
;

/* Create table dbo.DimCustomer */
CREATE TABLE dbo.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  int   NOT NULL
,  [CustomerName]  varchar(100)   NOT NULL
,  [CustomerEmail]  varchar(200) DEFAULT 'No Email Address' NOT  NULL
,  [CustomerAddress]  varchar(1000) DEFAULT 'Unknown Address' NOT NULL
,  [CustomerState]  varchar(20)   NOT NULL
,  [CustomerCity]  varchar(50)   NOT NULL
,  [CustomerZipCode]  varchar(20)   NOT NULL
,  [SourceCompany]  varchar(10)   NOT NULL
,  [RowIsCurrent]  bit DEFAULT 1  NOT NULL
,  [RowStartDate]  datetime DEFAULT '1/1/1900'  NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)  NULL
, CONSTRAINT [PK_dbo.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT dbo.DimCustomer ON
;
INSERT INTO dbo.DimCustomer (CustomerKey, CustomerID, CustomerName, CustomerEmail, CustomerAddress, CustomerState, CustomerCity, CustomerZipCode, SourceCompany, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown Name',  'No Email Available', 'Unknown Address', 'Unknown State', 'Unknown City', 'Unknown ZipCode', 'Unknown', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimCustomer OFF
;



/* Drop table dbo.FactCustomerSatisfaction */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactCustomerSatisfaction') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactCustomerSatisfaction 
;

/* Create table dbo.FactCustomerSatisfaction */
CREATE TABLE dbo.FactCustomerSatisfaction (
   [TweetKey]  int   NOT NULL
,  [ProductKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [ReviewDateKey]  int   NOT NULL
,  [Ratings]  int   NULL
,  [TwitterReview]  int   NULL
, CONSTRAINT [PK_dbo.FactCustomerSatisfaction] PRIMARY KEY NONCLUSTERED 
( [TweetKey],[ProductKey], [CustomerKey], [ReviewDateKey] )
) ON [PRIMARY]
;




/* Drop table northwind.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDate 
;

/* Create table northwind.DimDate */
CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  date   NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsWeekday]  bit  DEFAULT 0 NOT NULL
, CONSTRAINT [PK_northwind.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;


INSERT INTO dbo.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
VALUES (-1, '', 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, 0)
;

ALTER TABLE dbo.FactCustomerSatisfaction ADD CONSTRAINT
   FK_dbo_FactCustomerSatisfaction_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES dbo.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactCustomerSatisfaction ADD CONSTRAINT
   FK_dbo_FactCustomerSatisfaction_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES dbo.DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactCustomerSatisfaction ADD CONSTRAINT
   FK_dbo_FactCustomerSatisfaction_ReviewDateKey FOREIGN KEY
   (
   ReviewDateKey
   ) REFERENCES dbo.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE dbo.FactCustomerSatisfaction ADD CONSTRAINT
   FK_dbo_FactCustomerSatisfaction_TweetKey FOREIGN KEY
   (
   TweetKey
   ) REFERENCES DimTweetDictionary
   ( TweetKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
