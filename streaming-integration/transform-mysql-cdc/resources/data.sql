CREATE SCHEMA ETL;

USE ETL;

CREATE TABLE ORDERS
(
    OrderID     varchar(45) NOT NULL,
    RetailerID  varchar(45) DEFAULT NULL,
    ProductIDs  varchar(45) DEFAULT NULL
);

CREATE TABLE RETAILERS
(
    RetailerID varchar(45) NOT NULL,
    Retailer  varchar(45) DEFAULT NULL
);

CREATE TABLE PRODUCTS
(
    ProductID     varchar(45) NOT NULL,
    Product varchar(45) DEFAULT NULL
);

CREATE TABLE ORDER_REPORTS
(
    OrderID      varchar(45) NOT NULL,
    Retailer     varchar(45) DEFAULT NULL,
    Products     varchar(90) DEFAULT NULL
);

INSERT INTO RETAILERS (`RetailerID`, `Retailer`) VALUES ('R01', 'Mystery Inc.');
INSERT INTO RETAILERS (`RetailerID`, `Retailer`) VALUES ('R02', 'Charley Ltd.');
INSERT INTO RETAILERS (`RetailerID`, `Retailer`) VALUES ('R03', 'Golden Org.');

INSERT INTO PRODUCTS (`ProductID`, `Product`) VALUES ('P001', 'iPhone X');
INSERT INTO PRODUCTS (`ProductID`, `Product`) VALUES ('P002', 'MacBook Pro 2019');
INSERT INTO PRODUCTS (`ProductID`, `Product`) VALUES ('P003', 'Oculus Rift');
