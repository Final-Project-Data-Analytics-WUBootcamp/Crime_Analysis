# Federal Bureau of Investigation's Crime Data Explorer

"The FBI's Crime Data Explorer (CDE) aims to provide transparency, create easier access, and expand awareness of criminal, and noncriminal, law enforcement data sharing; improve accountability for law enforcement; and provide a foundation to help shape public policy with the result of a safer nation. Use the CDE to discover available data through visualizations, download data in .csv format, and other large data files."

## Working Question:

### Can we predict  the type of of crime that will take place based on a variety of spatial, temporal and categorical factors?

*Type of crime will be a classified as crime against persons, society or property*

## Google Slides
https://docs.google.com/presentation/d/1QLSF3Q7AoVnUGJ1b3vpzSRCFdUsbW5BrnfG1aPIo6k0/edit#slide=id.g10d9a689256_0_80
[Google Slides](https://docs.google.com/presentation/d/1QLSF3Q7AoVnUGJ1b3vpzSRCFdUsbW5BrnfG1aPIo6k0/edit#slide=id.g10d9a689256_0_80)


## Data Selection

Crime Incident-Based Data by State

Source Publication: Federal Bureau of Investigation

Source URL: https://crime-data-explorer.app.cloud.gov/pages/downloads

![image](https://user-images.githubusercontent.com/88041368/146853633-d96c30dd-5495-42ef-8a9d-f4cd29496695.png)

## Reason for Data Selection:

Becky pitched the initial idea to research available crime data and came across the FBI’s data explorer. The available datasets are incredibly robust and the schemas are both well documented and consistent across multiple years and states. Utilizing data like this allowed us to consider many different questions as well as adjust the scope of our project after meeting together as a team to discuss the direction we wanted to take our project.


## Scope

For the purposes of our analysis we will be exploring the relationship between time of day and types of crimes being committed that have resulted in an arrest. This data does not represent all reported crimes, only those where an arrest took place. The geographical extent of our analysis will focus on the state of Texas and we will utilize data published from 2017-2020. Prior to 2017 a slightly different schema and file naming system was used; after reviewing the amount of data 4 years provided, it was determine the additional steps of schema and file mapping was not necessary for our purposes.

## Technologies

python: pandas, matplotlib, scikitlearn, numpy, pyspark

AWS: S3, postgres, pgadmin

Tableau, css, javascript, flask ,html, Excel, quickdatabasediagrams.com (ERD), bootstrap

Google Colab, Jupyter Notebook, R, Github, Gitbash

IDE: python3; mlenv

## First Segment Goal

Sketch It Out: Decide on your overall project, select your question, and build a simple model. You'll connect the model to a fabricated database, using comma-separated values (CSV) or JavaScript Object Notation (JSON) files, to prototype your idea.

## Preprocessing Sample Data

Sample data selected: Texas 2017-2020

The initial data processing of the sample data was conducted in a Jupyter Notebook (see: TX_2020.ipynb) using python to execute our ERD model. Our ERD model determined the required csv’s, the relevant columns and the relationships for merging the individual data frames together. We opted to merge the dataframes using python rather than SQL because the creation of our actual database on AWS wasn’t completed at the time. We intend to use SQL to combine the 4 csv files (one for each year) into a single table as part of our deliverable for Segment 2. Aly has since populated our S3 bucket with the output csv files generated from the python code as well as all the additional lookup tables included in the bulk download from the FBI website. We intend to create future table joins, post machine learning, to ensure any remaining coded values are properly related to their respective, tables.

python: Read in csv files of interest, remove extra columns in each df that are not necessary for data analysis, remove records that have NaN values from each df, merge df’s to flatten the hierarchal data structure to allow for initial data exploration

## Mockup Database

Create table relationships:

Data is published as several, separate tables of information

The tables are intended to be used in a relational database

Most of the categorical information has already been made numeric; therefore, many of the tables provided in the bulk download serve as lookup category tables

The information is hierarchal in nature; however, for the purpose of our initial analysis only a handful of the tables are necessary:

![QuickDBD-export (8)](https://user-images.githubusercontent.com/88041368/147418432-0d55ab60-7e09-433b-aae0-179cb7d86d00.png)


### Successful Upload Datasets PySpark ETL

Crime-data Dataset 2020 Upload Successful :white_check_mark:

![Data 2020](https://github.com/Final-Project-Data-Analytics-WUBootcamp/Crime_Analysis/blob/Alejandra/resources/Texas%202020.png)

Crime-data Dataset 2019 Upload Successful :white_check_mark:

![Data 2019](https://github.com/Final-Project-Data-Analytics-WUBootcamp/Crime_Analysis/blob/Alejandra/resources/Texas%202019.png)

Crime-data Dataset 2018 Upload Successful :white_check_mark:

![Data 2018](https://github.com/Final-Project-Data-Analytics-WUBootcamp/Crime_Analysis/blob/Alejandra/resources/Texas%202018.png)

Crime-data Dataset 2017 Upload Successful :white_check_mark:

![Data 2017](https://github.com/Final-Project-Data-Analytics-WUBootcamp/Crime_Analysis/blob/Alejandra/resources/Texas%202017.png)

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

![Join_Crime_tables](https://github.com/Final-Project-Data-Analytics-WUBootcamp/Crime_Analysis/blob/Alejandra/JOIN_TABLES.png#gh-dark-mode-only)


## Machine Learning

### Google Colab Link Main Model
#### Random Forest Model
https://colab.research.google.com/drive/1ezdCrXePPz7lmU7CXnlZGEi7A3TekzIT#scrollTo=lnpzkmNhWORW


### Google Colab Links to Other Models
#### SVM Model
https://colab.research.google.com/drive/1xrVmeHoE1cm7Y5gHZlM4VNrNR9gCYp4e#scrollTo=wnmIJh-53qV0
#### Neural Network
https://colab.research.google.com/drive/1Wjht48glkqfpHDe8giguAvLEaeCmaE91#scrollTo=wuxINuJNgfRK
#### Neural Network Random Foreset Model
https://colab.research.google.com/drive/1FpEZQJmgGxJiR9xBvtBUKDpNEJo-Il10#scrollTo=wcvYZEJJMPd4
#### Multinomial
https://colab.research.google.com/drive/1L5k4pgTMPa2MmlKBp3bMVV0ruvfL2qjM#scrollTo=V-lSUczsTcWg


For additional Models, please look under Matthew Lane's branch for jupyter notebook files

### Machine Learning Overview
Machine Learning is the field of study that gives computers the capability to learn without being explicitly programmed - Source: Geeks for Geeks

In this project we used Supervised Machine Learning models to predict our topic. 
- In supervised machine learning, the computer is fed example inputs and their desired outputs. Then the computer uses its learnings to generate a general rule that maps inputs and outputs. 
- The majority of practical machine learning uses supervised learning.

Like the main topic of this project. Our machine learning model is exploring crimes against in the state of Texas. Using the data from the last four years, we are able to create a supervised machine learning model by inputting large amounts of data for the model to train on so it can predict which type of crime against is going to be committed.

![SupervisedMachineLearning](/Images/SupervisedMachineLearningCrimesAgainst.PNG)

The Random Forest had the best results of the machine learning models. See below image for the accuracy scores of these models. 
- This model uses a Multiclass classification Random Decision Forest. The Random Forest creates a set of decision trees from a randomly selected subset of the training set. It then collects votes from each tree. Then the votes are counted to train the model and make predictions
- This model has a potential for weighting variables to highly because the data is categorical utilizing the random forest model. 

![SupervisedMachineLearning](/Images/AccuracyScore.PNG)

Some of the preprocessing to prep the model for machine learning includes:
- Importing Libraries
- Connecting to RDS database and bring in tables
- Checking data types
- Exclude any null values
- Look for the number of unique values in each column
- Bin data with large numbers of unique values
- Create a correlation matrix to find any columns that can be dropped
- Drop columns interfering with the accuracy score

If more time was available I would:
- Investigate bringing in new data sets to join in on the table to help increase the accuracy score. 
- Test additional machine learning algorithms that are great with multi-class classification categorical data types. 
- Run the machine learning model with a different dependent variable such as the “suspect using id”


## HEROKU  :pushpin:

### The **main branch** of the Crime_Analysis repo has been connected to ```Heroku Dashboard```. 
It is named [crime-dashboard-analysis](https://dashboard.heroku.com/apps/crime-dashboard-analysis). It is linked to this Git repo.

________________________________________________________________________________________________________________________________________________________________

# Segment 2 Deliverables for Data Analysis and Visualization (Becky)

After some data visualization attempts with our previous iterations of the dataset the following was identified:

•	Our data was incredibly skewed towards Crimes Against Persons, more specifically assaults, because we merged victim data information. When we did this, and removed NaN records, we removed all arrests where victim information was not available. In the Crimes Against category, there is often times not a victim for crime against property and/or society.

o	By correcting this error, the majority of our arrests are actually for crimes against society

## With Victim Information Joined to the Data
*1=Person, 2=Property, 3=Society*
![Adding_Victim_Info](https://user-images.githubusercontent.com/88041368/148650854-4eed1198-893e-499b-8476-e2c393654764.png)
## Without Victim Information Joined to the Data
*1=Person, 2=Property, 3=Society*
![Removing_Victim_Info](https://user-images.githubusercontent.com/88041368/148650853-e4a7a429-8b93-4e37-8e39-e7ab2e1cb7fc.png)


•	Our independent variables are mostly all categorical which is problematic for many machine learning models; linear regression is not an option. After some initial research, the best way forward may be to consider a logistic regression model. Specifically, a Multinomial Logistic Regression Model should be explored.
https://machinelearningmastery.com/multinomial-logistic-regression-with-python/

## Visualizations Conducted in Tableau to Further Explore our Data and Conduct Additional Analysis

![Slide1](https://user-images.githubusercontent.com/88041368/149043761-748acf72-cf89-4864-8e23-49e83d34ee42.JPG)

![Slide2](https://user-images.githubusercontent.com/88041368/149043762-ed817023-5630-4361-be97-795dc5febc00.JPG)

![Slide3](https://user-images.githubusercontent.com/88041368/149043763-f4ff8b79-0179-4f36-8d10-9a9b102f7ee1.JPG)

![Slide4](https://user-images.githubusercontent.com/88041368/149043759-3a1c7ffb-d486-40a2-b714-ee37f6e5cb00.JPG)

## Tableau dashboard initial draft is posted on Tableau Public so we can begin to discuss necessary changes and design our website's html around the embedded visualization.

### This dashboard is dynamic; when you click on a county, all the other data visualizations filter. The dashboard can be viewed here: https://public.tableau.com/app/profile/becky2270/viz/DRAFT_TEXAS_NIBRS_2017to2020_BJones/Dashboard1?publish=yes

I’ve conducted a Tableau Blend Relationship between the raw arrest data and additional sociodemographic data I was able to find on Texas counties. The additional sociodemographic data was produced by the CDC’s Agency for Toxic Substances and Disease Registry for the annual Social Vulnerability Study. SVI provides specific socially and spatially relevant information to help public health officials and local planners better prepare communities to respond to emergency events such as severe weather, floods, disease outbreaks, or chemical exposure. This data also allowed me to generate additional data fields specific to our crime data.

•	Arrest Rate per 100 Residents (Total Arrests per County/Total Population per County * 100)

•	Estimated Arrests per Officer (Total Arrests per County/Total Officers per County)

![TEXAS_NIBRS_2017to2020](https://user-images.githubusercontent.com/88041368/149702817-edf4556c-0ec3-44a1-9eb7-0eee3d4441fd.jpg)

