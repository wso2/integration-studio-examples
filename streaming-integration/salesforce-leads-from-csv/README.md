# Insert Salesforce Leads from CSV Files
This example shows how to load lead information from CSV files to Salesforce while eliminating duplicates, using WSO2 Streaming Integrator's file reading and batching capabilities.

### Assumptions
This document assumes that you are familiar with WSO2 Streaming Integrator Tooling's interface, and configuring properties of elements from the Design View.

### Example Use Case
This document explains about a business that collects information of leads containing their email, first name, last name and the company, in CSV files. When a CSV file is put to the appropriate directory, these leads are inserted to Salesforce, after eliminating duplicate leads based on the email address.

<img src="../../resources/images/streaming/salesforce-leads-from-csv-use-case.png">

### Set Up and Run the Example

#### Configuring the Siddhi App
1. Start WSO2 Streaming Integrator Tooling by going to the `<SI_HOME>/bin` directory, and executing `./tooling.sh` command.
2. Open the provided Siddhi app `SalesforceLeadsFromCSV.siddhi`, and save it as `SalesforceLeadsFromCSV.siddhi`.
3. Switch to the design view by clicking the **Design View** button.
4. Update the following properties of the **file** source:
    - dir.uri: `file:/path/to/your/source-dir`
    - move.after.process: `file:/path/to/your/moved-dir`
5. Configure each **http-call** sink to be updated with the following values:
    - publisher.url: `https://<your_salesforce_instance>.salesforce.com/...`.
    - headers: `'Authorization: Bearer <your_salesforce_access_token>'`
6. Switch back to the code view by clicking the **Code View** button, and save the Siddhi app.

#### Running the Example and Observing the Results
1. Start the Siddhi app. You will see the message `SalesforceLeadsFromCSV.siddhi -  Started Successfully!` in your console.
2. Drop the `leads.csv` file to `/path/to/your/source-dir`. This file contains 5 new leads.
3. The following log will be shown when each record is processed:
```
SalesforceLeadsFromCSV: Processing Lead, StreamEvent{ timestamp=1591880257515, beforeWindowData=null, onAfterWindowData=null, outputData=[charles@gmail.com, Charles, Dickens, CharlesLtd, false, /path/to/your/source-dir/leads.csv], type=CURRENT, next=null}
```
4. The following log will be shown after processing all the records in `leads.csv`:
```
File Summary : 5 New Leads in File: /path/to/your/source-dir/leads.csv
```
5. Verify that 5 new leads have been added in your Salesforce.
6. Drop the `leads_with_duplicates.csv` file to `/path/to/your/source-dir`. This file contains 3 new leads, and 2 duplicate leads that have been already loaded from `leads.csv`.
7. The following log will be shown after processing all the records in `leads_with_duplicates.csv`:
```
File Summary : 3 New Leads in File: /path/to/your/source-dir/leads_with_duplicates.csv
File Summary : 2 Duplicate Leads in File: /path/to/your/source-dir/leads_with_duplicates.csv
```
8. Verify that 3 new leads have been added to your Salesforce.

### How it Works
The following steps outline how each lead is inserted to Salesforce from CSV files.
1. The file source listens to the source directory for CSV files that have values for columns: email, first name, last name, and company.
2. When a CSV file is put to the source directory, it is processed line by line. Each record's email is checked whether it is had by an existing lead in Salesforce, i.e, a duplicate lead. 
3. The lead is added to Salesforce only if it is not a duplicate lead.
4. A file is treated as a single batch, where number of new leads and duplicate leads are calculated per batch.
