# Federal Bureau of Investigation's Crime Data Explorer

The FBI's Crime Data Explorer (CDE) aims to provide transparency, create easier access, and expand awareness of criminal, and noncriminal, law enforcement data sharing; improve accountability for law enforcement; and provide a foundation to help shape public policy with the result of a safer nation. Use the CDE to discover available data through visualizations, download data in .csv format, and other large data files.

## Working Question:

### Can we predict the type of of crime that will take place based on a variety of spatial, temporal and categorical factors?

*Type of crime will be a classified as crime against persons, society or property*

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

## First Segment Role

Circle: The member in the circle role will create a mockup of a database with a set of sample data, or even fabricated data. This will ensure the database will work seamlessly with the rest of the project.

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

## Initial Data Exploration for Subset of Texas Crime: Assaults Only

![TX_Assaults_County_Map](https://user-images.githubusercontent.com/88041368/147013145-ce9da898-8f15-482c-a270-4a20cbcb8bde.jpg)
![TX_Assaults_Victim_Demographics](https://user-images.githubusercontent.com/88041368/147013143-f5336f15-6273-451e-9f40-4fa6e662aaa4.jpg)
![TX_Assaults_ArresteeVsVictim_Age](https://user-images.githubusercontent.com/88041368/147013144-424b52c9-2398-4dae-9dde-2818a6a20dd3.jpg)

# Segment 2 Deliverables

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

## Visualizations Conducted in Tableau to Further Explore our Data

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
