CREATE DATABASE FASHION
USE  FASHION

CREATE TABLE BRANDS(B_ID INT PRIMARY KEY IDENTITY, B_NAME VARCHAR(20), ITEM_TYPE VARCHAR(20), PRICE NUMERIC(10), 
SIZE TEXT)

INSERT INTO BRANDS VALUES ('GUCCI', 'CLOTHS', 10000, 'L')
INSERT INTO BRANDS VALUES ('NIKE', 'SHOES', 5000, 'ALL')
INSERT INTO BRANDS VALUES ('MANISH', 'CLOTHS', 10500, 'ALL')
INSERT INTO BRANDS VALUES ('MOCHI', 'SHOES', 10550, 'L')
INSERT INTO BRANDS VALUES ('ZARA', 'COSMATICS', 19000, 'ALL')
INSERT INTO BRANDS VALUES ('NAYKA', 'BEAUTY', 10000, 'L')
INSERT INTO BRANDS VALUES ('WOODLAND', 'SHOES', 15000, 'ALL')
INSERT INTO BRANDS VALUES ('JACK', 'CLOTHS', 1000, 'L')
INSERT INTO BRANDS VALUES ('MUFTI', 'CLOTHS', 18000, 'ALL')
INSERT INTO BRANDS VALUES ('HRX', 'CLOTHS', 1050, 'ALL')

SELECT * FROM BRANDS

CREATE TABLE CELEBRITY(C_ID INT PRIMARY KEY IDENTITY(101,1), C_NAME VARCHAR(20), PHONENO NUMERIC(10))

INSERT INTO CELEBRITY VALUES ('SARUKH', 1234567897)
INSERT INTO CELEBRITY VALUES ('AKSHAY', 123456767)
INSERT INTO CELEBRITY VALUES ('SALMAN', 123455677)
INSERT INTO CELEBRITY VALUES ('ALIA', 1234568987)
INSERT INTO CELEBRITY VALUES ('KATRINA', 12457697)
INSERT INTO CELEBRITY VALUES ('VARUN', 123567987)
INSERT INTO CELEBRITY VALUES ('RITIK', 124567345)
INSERT INTO CELEBRITY VALUES ('HEMA', 124556497)
INSERT INTO CELEBRITY VALUES ('DEPIKA', 137657897)
INSERT INTO CELEBRITY VALUES ('SARUKH', 239757897)

SELECT * FROM CELEBRITY

CREATE TABLE ENDORSEMENT(E_ID INT PRIMARY KEY IDENTITY(1001,1), C_ID INT, B_ID INT,constraint fk_cid foreign key (C_ID) 
references CELEBRITY(C_ID) ,constraint fk_b_id foreign key (B_ID) references BRANDS(B_ID))

INSERT INTO ENDORSEMENT VALUES (101,1)
INSERT INTO ENDORSEMENT VALUES (102,2)
INSERT INTO ENDORSEMENT VALUES (103,3)
INSERT INTO ENDORSEMENT VALUES (104,4)
INSERT INTO ENDORSEMENT VALUES (105,5)
INSERT INTO ENDORSEMENT VALUES (106,6)
INSERT INTO ENDORSEMENT VALUES (107,7)
INSERT INTO ENDORSEMENT VALUES (108,8)
INSERT INTO ENDORSEMENT VALUES (109,9)
INSERT INTO ENDORSEMENT VALUES (110,10)
INSERT INTO ENDORSEMENT VALUES (101,5)
INSERT INTO ENDORSEMENT VALUES (101,8)
INSERT INTO ENDORSEMENT VALUES (103,6)
INSERT INTO ENDORSEMENT VALUES (109,1)
INSERT INTO ENDORSEMENT VALUES (104,1)
INSERT INTO ENDORSEMENT VALUES (108,3)
INSERT INTO ENDORSEMENT VALUES (106,1)
INSERT INTO ENDORSEMENT VALUES (107,5)
INSERT INTO ENDORSEMENT VALUES (107,5)
INSERT INTO ENDORSEMENT VALUES (105,10)

SELECT * FROM ENDORSEMENT

create table brand_log(logID int identity(100,1),bid int,operation nvarchar(20),updateddate Datetime)
select * from brand_log

create table celebrity_log(logID int identity(100,1),cid int,operation nvarchar(20),updateddate Datetime)
select * from celebrity_log

create table endorsed_log(logID int identity(100,1),eid int,operation nvarchar(20),updateddate Datetime)
select * from endorsed_log


--INSERT TRIGGER
CREATE TRIGGER BrandInsertTrigger
ON BRANDS
FOR INSERT
AS
INSERT INTO celebrity_log(bid,operation,updateddate)
SELECT B_ID,'Data Inserted',GETDATE() FROM inserted

INSERT INTO BRANDS VALUES('CAMPUS','SHOES',10000,'L')
INSERT INTO BRANDS VALUES('SPARK','SHOES',1055,'X')

SELECT * FROM brand_log


CREATE TRIGGER CelebrityInsertTrigger
ON CELEBRITY
FOR INSERT
AS
INSERT INTO celebrity_log(cid,operation,updateddate)
select C_ID,'Data Inserted',GETDATE() from inserted

INSERT INTO CELEBRITY VALUES('PREM',1234567890)
INSERT INTO CELEBRITY VALUES('RATAN',1234876890)

SELECT * FROM celebrity_log



--UPDATE TRIGGER
CREATE TRIGGER BrandsUpdateTrigger
ON BRANDS
AFTER UPDATE
AS
INSERT INTO brand_log(cid,operation,updateddate)
SELECT B_ID,'Data Updates',GETDATE() from deleted

UPDATE BRANDS SET B_NAME='ADDIDAS' WHERE B_ID=7
UPDATE BRANDS SET B_NAME='PUMA' WHERE B_ID=3

SELECT * FROM brand_log



CREATE TRIGGER CelebrityUpdateTrigger
ON CELEBRITY
AFTER UPDATE
AS
INSERT INTO celebrity_log(cid,operation,updateddate)
SELECT C_ID,'Data Updates',GETDATE() FROM deleted

UPDATE CELEBRITY SET C_NAME='ALU ARJUN' WHERE C_ID=9

SELECT * FROM celebrity_log


--DELETE TRIGGER
CREATE TRIGGER BrandDeleteTrigger
ON BRANDS
AFTER DELETE
AS
INSERT INTO brand_log(bid,operation,updateddate)
SELECT B_ID,'Data Deleted',GETDATE() FROM deleted

DELETE FROM BRANDS WHERE B_ID=6

SELECT * FROM brand_log 



CREATE TRIGGER CelebrityDeleteTrigger
ON CELEBRITY
AFTER DELETE
AS
INSERT INTO celebrity_log(cid,operation,updateddate)
SELECT C_ID,'Data Deleted',GETDATE() FROM deleted

DELETE FROM CELEBRITY WHERE C_ID=6
SELECT * FROM celebrity_log 