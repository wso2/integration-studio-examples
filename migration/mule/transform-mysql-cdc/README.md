# MySQL Change Data Capture and Transformation
This example shows how to use WSO2 Streaming Integrator's Change Data Capturing capability to detect insertion of records in a MySQL table, transform the records with more information available in other MySQL tables, and insert the transformed record to another MySQL table. 

### Assumptions
This document assumes that you are familiar with WSO2 Streaming Integrator Tooling's interface, and configuring properties of elements from the Design View.

### Example Use Case ###
This document explains about a manufacturer who accepts product orders containing an order ID, retailer ID and product IDs from retailers, and creates order reports after identifying the retailer's name and product names, as soon as the order is received.

<img src="../../../docs/assets/images/migration-mule/transform-mysql-cdc-use-case.png">

### Set Up and Run the Example

To follow along with steps in this example, you must have MySQL installed on your computer, and binary logging should be enabled which you can do by following [this guide](https://debezium.io/docs/connectors/mysql/#enabling-the-binlog) if you haven't done.

#### Preparing the MySQL Database

1. Make sure to have a user with SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT privileges. You can create a user with: 
```
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'wso2' IDENTIFIED BY 'wso2123';
```
2. Run the provided `data.sql` in your MySQL instance to create the database and tables, and populate the tables with sample data. This will create a database called `ETL`, with tables: `RETAILERS`, `PRODUCTS`, `ORDERS`, `ORDER_REPORTS`. `RETAILERS` and `PRODUCTS` will be populated with sample data.

#### Configuring SI Tooling

1. Enable state persistence by setting `enabled: true` under `state.persistence` in `<SI_HOME>/conf/server/deployment.yaml`.
2. Start WSO2 Streaming Integrator Tooling by going to the `<SI_HOME>/bin` directory, and executing `./tooling.sh` command.
3. Go to _Tools -> Extension Installer_, search for the following extensions and install them:
  - Change Data Capture - MySQL
  - RDBMS - MySQL
4. Restart WSO2 Streaming Integrator Tooling, open the provided Siddhi app `TransformMySQLCDC.siddhi`, and save it as `TransformMySQLCDC.siddhi`.

The Siddhi app contains the following values configured by default. You can skip to **Running the Example and Observing the Results**, if these values are same with you.
- MySQL Host: `localhost`
- MySQL user's username: `wso2`
- MySQL user's password: `wso2123`

5. Switch to the design view by clicking the **Design View** button.
6. Provide values for the following fields of:
    * **cdc** source, **PRODUCTS** table, **RETAILERS** table and **ORDER_REPORTS** table.
        - jdbc.url: `jdbc:mysql://<MySQL_Host>:3306/etl?useSSL=false`
        - username: `<your_mysql_username>`
        - password: `<your_mysql_password>`
7. Switch back to the code view by clicking the **Code View** button, and save the Siddhi app.


#### Running the Example and Observing the Results

1. Start the Siddhi app. You will see the message `TransformMySQLCDC.siddhi -  Started Successfully!` in your console.
2. Verify that there are no existing records in the `ORDER_REPORTS` MySQL table, by executing the SQL query: `SELECT * FROM ORDER_REPORTS;` .
3. Insert a record into the `ORDERS` MySQL table using the following query: 
```
INSERT INTO ORDERS(OrderID, RetailerID, ProductIDs) VALUES ('101', 'R02', 'P001,P002');
```
4. Check the `ORDER_REPORTS` MySQL table by executing the SQL query: `SELECT * FROM ORDER_REPORTS;` . You will now see a record as follows:
```
+---------+--------------+---------------------------+
| OrderID | Retailer     | Products                  |
+---------+--------------+---------------------------+
| 101     | Charley Ltd. | iPhone X,MacBook Pro 2019 |
+---------+--------------+---------------------------+
```

### How it Works

The following steps outline how an inserted record is transformed.
1. The MySQL CDC source listens for insertions in the `ORDERS` table.
2. When a record is inserted in the `ORDERS` table, the retailer is matched by performing a join with the `RETAILERS` table.
3. Multiple product IDs are separated, and the product identified by each of them is matched by performing a join with the `PRODUCTS` table.
4. The record that has been transformed with required information will be inserted to the `ORDER_REPORTS` table.
