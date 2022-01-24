# Federal Bureau of Investigation's Crime Data Explorer

"The FBI's Crime Data Explorer (CDE) aims to provide transparency, create easier access, and expand awareness of criminal, and noncriminal, law enforcement data sharing; improve accountability for law enforcement; and provide a foundation to help shape public policy with the result of a safer nation. Use the CDE to discover available data through visualizations, download data in .csv format, and other large data files."

## Project Overview

It has been widely reported that violent crime has been on the rise nationwide; a 5% increase between 2019 and 2020, according to FBI data. At a county level, violent crime rates are significantly impacted by the violence taking place in the country’s most dangerous cities. The intent of this project is to explore crime trends overall at the county level throughout the state of Texas. We utilized millions of reported offenses published by the FBI’s Crime Data Explorer between 2017 and 2020 to discover what variables may help us predict the likelihood that a particular type of crime may take place. We considered a variety of factors including arrestee demographics, temporal and seasonality trends, as well as considered locational characteristics of where an offense occurred. While there is certainly room for improving our machine learning models and adjusting the variables we initially considered, we have been able to gain new insights regarding overall crime trends in Texas.

## Working Question:

### Can we predict  the type of of crime that will take place based on a variety of spatial, temporal and categorical factors?

*Type of crime will be a classified as crime against persons, society or property*

## Google Slides - Crime Against Deck -> Final Presentation
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

_____________________________________________________________________________________________________________________________________________________________________________
# Initial Data Exploration

Initially, we planned consider victim related information into our analysis; however, after some data visualizations it became clear our data was highly skewed towards crimes against persons, especially assaults. I realized that by including victim information and removing all the data records where victim values were NaN in the data processing phase I was inadvertently removing a majority of our arrests. Often times crimes against society and/or property do not have an identified victim. In correcting this error, a majority of our arrests data now falls within the crimes against society category vs persons.

## With Victim Information Joined to the Data
*1=Person, 2=Property, 3=Society*
![Adding_Victim_Info](https://user-images.githubusercontent.com/88041368/148650854-4eed1198-893e-499b-8476-e2c393654764.png)
## Without Victim Information Joined to the Data
*1=Person, 2=Property, 3=Society*
![Removing_Victim_Info](https://user-images.githubusercontent.com/88041368/148650853-e4a7a429-8b93-4e37-8e39-e7ab2e1cb7fc.png)

# Data Processing Steps

Several data processing steps were required to prepare the raw FBI data files for machine learning and visualizations after conducting the initial logical data model. Raw csv files were read into Jupyter Notebook and multiple years’ worth of data were concatenated together. Columns in the new data frames that would not be used in our analysis were removed as well as any record that was populated with “unknown” or NaN values. We merged data frames containing information about the arrestee, the incident, the offense, suspect using (under the influence), location of incident, and arresting agency to generate a consolidated data frame with all of the variables we wanted to consider for our analysis. Lastly, we converted all categorical fields to numeric values to enable us to run various machine learning models on our data.

*The notebook and output data files are available in the Data_Processing folders*

![rawdata](https://user-images.githubusercontent.com/88041368/150701101-03772e77-5c7a-41e1-b52b-fc3d7acef50e.jpg)
![processeddata](https://user-images.githubusercontent.com/88041368/150701097-6effda53-079a-44aa-9c56-2f1179a7d4d7.jpg)

# Further Data Exploration

### Spatial Trends

Larger population sizes do not always yield more reported arrests

The proportion of arrests by crime type vary slightly based on the location; however, crime against society represents the largest proportion of arrests made in our sample data.

The NIBRS database where we obtained our data does not contain arrest related information for all of the counties in Texas; the lack of comprehensive coverage is unknown at this time.
![crimemap](https://user-images.githubusercontent.com/88041368/150701466-94e44849-4a25-484a-8ac3-1243ea8f87cd.PNG)
![loc](https://user-images.githubusercontent.com/88041368/150701299-9167a1c5-9914-4e9f-bc43-5ce45ad81389.jpg)
*1=Person, 2=Property, 3=Society*

### Seasonal and Temporal Trends

All three crime type categories follow a similar seasonal trend with fairly little variability from month to month.

An interesting pattern does appear to be emerging in April (4), when the crime trends appear to be on a steady incline but take an unexpected dip prior to shooting back up in May (5).

Temporally, the Crime Against categories of person and society follow similar trends, peaking in the late night/early morning hours. The property category varies in that it peaks in the late afternoon, evening hours.
![monthly](https://user-images.githubusercontent.com/88041368/150701293-89273f15-61e7-475b-ab59-eb7105ca35cf.jpg)
*1=Person, 2=Property, 3=Society*
![hourly](https://user-images.githubusercontent.com/88041368/150701301-61b31924-3650-4cb9-99c7-cdbf26f68898.jpg)
*1=Person, 2=Property, 3=Society*

### Probable Multicollinearity Between Some Independent Variables

From the coefficient heatmap we can see that there is likely a high correlation between the suburban area, population, and total police department employees’ independent variables. This makes sense given that more people live in urban areas and larger populations require larger police departments. We can remove two of these three variables for the purpose of our analyses.

### Measuring Additional Correlation Between Variables

Offense Type has a strong, negative correlation with Crime Against Type; however, this variable must be removed because it has a hierarchal relationship with our dependent variable.
![Heatmap_2 (1)](https://user-images.githubusercontent.com/88041368/150701298-bee29132-7d7d-471a-9d3b-801708aec98a.jpg)

# Data Visulaization with Tableau Dashboard

Additional csv files were generated during the data processing phase specifically for our Tableau Viz—data was aggregated at the county level to visualize our information spatially on the map. The county aggregation allowed us to relate additional county level details such as the median household income, unemployment rate, high school diploma rate, race/ethnicity break out and crime density. Aggregating at the county level enabled us to summarize our processed arrest data to provide an insightful and dynamic visualization.

I’ve conducted a Tableau Blend Relationship between the raw arrest data and additional sociodemographic data I was able to find on Texas counties. The additional sociodemographic data was produced by the CDC’s Agency for Toxic Substances and Disease Registry for the annual Social Vulnerability Study. SVI provides specific socially and spatially relevant information to help public health officials and local planners better prepare communities to respond to emergency events such as severe weather, floods, disease outbreaks, or chemical exposure. This data also allowed me to generate additional data fields specific to our crime data.

## Visualizations Conducted in Tableau to Further Explore our Data
![tabdash](https://user-images.githubusercontent.com/88041368/150701769-2b212d69-4756-4b93-b88b-c640866c44e8.PNG)
### This dashboard is dynamic; when you click on a county, all the other data visualizations filter. The dashboard can be viewed here: https://public.tableau.com/app/profile/becky2270/viz/DRAFT_TEXAS_NIBRS_2017to2020_BJones/Dashboard1?publish=yes

# Dashboard and Website Design

The published website can be accessed here: https://crime-dashboard-analysis.herokuapp.com/

### HTML template was modified to meet the needs of this project; original download source and credits below:
Template Name    : DevFolio - Developer Portfolio Template

Template Link    : https://htmlcodex.com/developer-portfolio-template

Template License : https://htmlcodex.com/license (or read the LICENSE.txt file)

Template Author  : HTML Codex
Author Website   : https://htmlcodex.com

About HTML Codex : HTML Codex is one of the top creators and publishers of Free HTML templates, HTML landing pages, HTML email templates and HTML snippets in the world. Read more at ( https://htmlcodex.com/about-us )
_____________________________________________________________________________________________________________________________________________________________________________
## Machine Learning

### Google Colab Link Main Model
#### [Random Forest Model](https://colab.research.google.com/drive/1ezdCrXePPz7lmU7CXnlZGEi7A3TekzIT#scrollTo=lnpzkmNhWORW)

### Google Colab Links to Other Models
- #### [SVM Model](https://colab.research.google.com/drive/1xrVmeHoE1cm7Y5gHZlM4VNrNR9gCYp4e#scrollTo=wnmIJh-53qV0) - This model was unable to process with the processing power of the free version of google colab. Though, in the future, it would be a great model to try with more processing power. 
- #### [Neural Network](https://colab.research.google.com/drive/1Wjht48glkqfpHDe8giguAvLEaeCmaE91#scrollTo=wuxINuJNgfRK)
- #### [Neural Network Random Foreset Model](https://colab.research.google.com/drive/1FpEZQJmgGxJiR9xBvtBUKDpNEJo-Il10#scrollTo=wcvYZEJJMPd4)
- #### [Multinomial](https://colab.research.google.com/drive/1L5k4pgTMPa2MmlKBp3bMVV0ruvfL2qjM#scrollTo=V-lSUczsTcWg)
- #### [Random Over Sampler](https://colab.research.google.com/drive/1pzY-EunwbphRaEXb_PaxAlGJcGqLmpbO?usp=sharing)
- #### [Naive_bayes](https://colab.research.google.com/drive/1iWdpXxuCS0Xm3H02soyBwmtnGpabCa2L?usp=sharing)


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

#### Some of the preprocessing to prep the model for machine learning includes:
- Importing Libraries
- Connecting to RDS database and bring in tables
- Checking data types
- Exclude any null values
- Look for the number of unique values in each column
- Bin data with large numbers of unique values
- Create a correlation matrix to find any columns that can be dropped
- Drop columns interfering with the accuracy score

#### Feature Engineering
The feature engineering was a process of trial and error. Figuring out which independent variables helped increase the accuracy score, precision score, and recall score the most with each machine learning model. Here are some of the variables that went into picking the feature selection:
- Excluding victim information as it was blank in many cases where the crime against was property. 
- Using a correlation function to exclude variables that we can predict one with the other. Selecting one of the variables helps speed up the machine learning model. 
- Bucketing arrest age variable to lower the number of unique instances. Grouping data can help increase accuracy scores.  

#### If more time was available:
- Investigate bringing in new data sets to join in on the table to help increase the accuracy score. 
- Test additional machine learning algorithms that are great with multi-class classification categorical data types. 
- Run the machine learning model with a different dependent variable such as the “suspect using id”

#### Splitting data into training and testing data sets
 - This data was split into 75% training and 25% testing
 - The random state was 1 meaning we would produce the same result each time the model is run.
 - Stratify was set to y meaning it will assure the same proportions of each dependent variables are in the training and testing data sets. 

#### Model choice, including limitations and benefits
The Random Forest Model ended up being our model choice after going through trial and error with multiple supervised machine learning models. Supervised machine learning models were pinpointed because we had a large amount of clean data to train and test, perfect for supervised machine learning models. Other supervised machine learning models tested were Multinomial, Random Over Sampler, SMOTE Over Sampler, and Neural Networks. 
- The Random Forest model had the best accuracy score, precision score, and recall score. 
- Some benefits include powerful, accurate, works well with non-linear data, runs efficiently on a large dataset, flexible to both classification and regression problems, works well with categorical and continuous values. 
- Some limitations include prone to overfitting and poor interpretability.

## HEROKU  :pushpin:

### The **main branch** of the Crime_Analysis repo has been connected to ```Heroku Dashboard```. 
Open heroku-app!
It is named [crime-dashboard-analysis](https://dashboard.heroku.com/apps/crime-dashboard-analysis). It is linked to this Git repo.

________________________________________________________________________________________________________________________________________________________________


