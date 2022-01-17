# **Crime_Analysis** :oncoming_police_car:
## Big Data Analysis of FBI Crime Data Explorer :computer:

### Task List -> Week 27-17th
- [x] Push the data into pgAdmin
- [x] Run SQL queries to join the schemas created

## AWS connecting with PostgreSQL

### Google Colab Link ETL process from AWS to pdAdmin
[AWS_database_connect_pgAdmin](https://colab.research.google.com/drive/14BlO0zgqK5SQ78v0lvVnbCD664GdwQ6f#scrollTo=bvY30Mslbgis)

### Proof of work in two tables running SQL commands in pgAdmin

```
--- FIRST CREATE THE SCHEMA

CREATE TABLE Jan8_TX_data_for_ML (
    INCIDENT_MONTH INT NOT NULL,
    INCIDENT_HOUR INT NOT NULL,
    ARR_AGE_NUM INT NOT NULL,
    ARR_SEX_CODE INT NOT NULL,
    ARR_RACE_ID INT NOT NULL,
    ARR_RESIDENT_CODE INT NOT NULL,
    LOCATION_ID INT NOT NULL,
    SUSPECT_USING_ID INT NOT NULL,
    AGENCY_TYPE_NAME INT NOT NULL,
    POPULATION INT NOT NULL,
    SUBURBAN_AREA_FLAG INT NOT NULL,
    TOTAL_EMPLOYEES INT,
    OFFENSE_TYPE_ID INT NOT NULL,
    AGENCY_ID INT NOT NULL,
    CRIME_AGAINST INT NOT NULL,
    FOREIGN KEY (ARR_RACE_ID) REFERENCES final_REF_RACE (RACE_ID)  
);

CREATE TABLE final_REF_RACE (
    RACE_ID INT NOT NULL,
    RACE_CODE VARCHAR NOT NULL,
    RACE_DESC VARCHAR NOT NULL,
    SORT_ORDER INT NOT NULL,
    START_YEAR INT,
    END_YEAR INT,
    NOTES VARCHAR,
    PRIMARY KEY (RACE_ID)
);

--- THEN, JOIN THOSE TWO TABLES

SELECT DISTINCT j.ARR_RACE_ID, f.RACE_DESC
FROM Jan8_TX_data_for_ML AS j
LEFT JOIN  final_REF_RACE AS f
ON f.RACE_ID = j.ARR_RACE_ID
ORDER BY j.ARR_RACE_ID;

```
### Sucessful LEFT JOIN in PostgreSQL

![Join_Crime_tables](JOIN_TABLES.png#gh-dark-mode-only)



### Task List -> Week 19-26th
- [x] Mock the scenario using four datasets stored in S3 and set in a RDS database.
- [x] Run the datasets from 2017, 2018, 2019 and 2020 by using Spark to write directly to our Postgres database.
- [x] Import SparkFiles from PySpark into [^1]: Move your ETL process to the cloud. Files: [Colab Crime_data_pgAdmin notebook](https://colab.research.google.com/drive/1fM4oXPtmu0VE950IbB4zbEU86xDZ5qt4?usp=sharing) and [Colab Crime TWO DATASETS all included](https://colab.research.google.com/drive/14BlO0zgqK5SQ78v0lvVnbCD664GdwQ6f#scrollTo=bvY30Mslbgis).
- [x] Load the DataFrames into the table. Configuration set up to allow the connection between PgAdmin and AWS Server.

### Successful Upload Datasets PySpark ETL :trackball:

Crime-data Dataset 2020 Upload Successful :white_check_mark:

![Data 2020](resources/Texas%202020.png)

Crime-data Dataset 2019 Upload Successful :white_check_mark:

![Data 2019](resources/Texas%202019.png)

Crime-data Dataset 2018 Upload Successful :white_check_mark:

![Data 2018](resources/Texas%202018.png)

Crime-data Dataset 2017 Upload Successful :white_check_mark:

![Data 2017](resources/Texas%202017.png)
