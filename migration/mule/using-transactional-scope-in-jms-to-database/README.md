# Using Transactional Scope In JMS To Database

This example illustrates the concept of transactions and a rollback-error handling strategy in a use case where data is sent from JMS to a MySQL database.

A transaction is a set of operations executed as a single unit. [Transaction Mediator](https://ei.docs.wso2.com/en/latest/micro-integrator/references/mediators/transaction-Mediator/) is used to manage transactions in WSO2 Enterprise Integrator.

### Assumptions ###

This document assumes that you are familiar with WSO2 EI and the 
[Integration Studio interface](https://ei.docs.wso2.com/en/latest/micro-integrator/overview/quick-start-guide/). To 
increase your familiarity with Integration Studio, consider completing one or more 
[WSO2 EI Tutorials](https://ei.docs.wso2.com/en/latest/micro-integrator/use-cases/integration-use-cases/).

### Example Use Case

In this example, messages are fetched from a JMS Queue named 'in' and is inserted into a MySQL database. Then, ID of the inserted record is logged in a file. If the file write is successful, the transaction is committed and the response is sent to another JMS queue named 'out'.
If the file write is failed, the transaction is rolled back. Hence, the record insertion is rolled back and the inserted record will not exist in the database.   

### Prerequisites

1. Install Apache ActiveMQ and MySQL.
2. Start Apache ActiveMQ server.
3. Start MySQL server, create a database, and establish a connection to the database.

### Set Up and Run the Example

1. Start WSO2 Integration Studio ([Installing WSO2 Integration Studio](https://ei.docs.wso2.com/en/latest/micro-integrator/develop/installing-WSO2-Integration-Studio/)).
2. In your menu in Studio, click the **File** menu. In the File menu select the **Import...** item.
3. In the Import window select the **Existing WSO2 Projects into workspace** under **WSO2** folder.
4. Browse and select the file path to the downloaded sample of this Github project 
(`integration-studio-examples/migration/mule/using-transactional-scope-in-jms-to-database/UsingTransactionalScopeInJMSToDatabaseRegistry`) and click **finish**.
5. Let's add the File connector into the workspace. Right click on the **UsingTransactionalScopeInJMSToDatabase** and select 
**Add or Remove Connector**. Keep the **Add connector** option selected and click **Next>**. Search for 'file' using the 
search bar and click the download button located at the bottom right corner of the File connector. Click **Finish**.
6. Open the **datasource.xml** under 
**using-transactional-scope-in-jms-to-database/OrdersDataSource/datasource** directory. 
Configure the following properties required for the MySQL Connection.
    - url
    - username
    - password
7. Create the database.
 
```
CREATE DATABASE test_db;
```

8. Create the table `orders`.

```
CREATE TABLE orders (
            item_id INTEGER NOT NULL,
            item_units INTEGER,
            customer_id INTEGER,
            PRIMARY KEY (item_id)
);
```

9. Configure the JMS transport for JMS listener and sender in EI as instructed [here](https://ei.docs.wso2.com/en/latest/micro-integrator/setup/brokers/configure-with-ActiveMQ/).
10. Run the sample by right click on the **UsingTransactionalScopeInJMSToDatabaseCompositeApplication** under the main 
**using-transactional-scope-in-jms-to-database** project and selecting **Export Project Artifacts and Run**.
11. Publish the following message to ActiveMQ `in` queue.

```xml
<order>
    <itemId>1</itemId>
    <itemUnits>2</itemUnits>
    <customerId>1</customerId>
</order>
```

12. The record will be roll backed as the file write fails. The file write process fails as the destination defined does not exist. Following logs can be observed in the console log.

```
STATUS = Inserting data to the Database...
.
.
.
STATUS = Rolling back transaction..., ERROR_MESSAGE = Error occured in the mediation of the class mediator
```

13. If you query the table using the following command, you can observe that the record has not been inserted.

```
SELECT * FROM orders;
```

14. If the following parameter of the file connector configuration `fileconnector.append` is updated with an existing location, the mediation will successfully complete and you can observe the message is inserted to the `out` queue.

```
<destination></destination>
```

### How It Works

The Inbound Endpoint `OrdersInboundEP` will listen on the JMS queue named `in` configured in Apache ActiveMQ. 

Upon receiving a message it will invoke `MainSequence` where the message is inserted into the database. 
Then, a record is appended to a file to indicate that the record was created using the File Connector. But this operation will fail with an error as the destination specified does not exist. As the transaction scope is defined from database insertion till the end of file write, the transaction is committed only after this operation has completed successfully.
Once the error is thrown, the `FaultSequence` will be invoked where the transaction is being rolled back. Hence, the database record will not exist and the message will not be forwarded to the `out` queue.

If the destination is updated with a correct location, the file write will succeed and the transaction will be committed. Then, the message is pushed to `out` queue and the record can be observed in the database table as well.

### Go Further

* Read about File Connector [here](https://docs.wso2.com/display/ESBCONNECTORS/File+Connector)
* Read more on [WSO2 connectors](https://docs.wso2.com/display/ESBCONNECTORS/WSO2+ESB+Connectors+Documentation)
