# Project Overview

It has been widely reported that violent crime has been on the rise nationwide; a 5% increase between 2019 and 2020, according to FBI data. At a county level, violent crime rates are significantly impacted by the violence taking place in the country’s most dangerous cities. The intent of this project is to explore crime trends overall at the county level throughout the state of Texas. We utilized millions of reported offenses published by the FBI’s Crime Data Explorer between 2017 and 2020 to discover what variables may help us predict the likelihood that a particular type of crime may take place. We considered a variety of factors including arrestee demographics, temporal and seasonality trends, as well as considered locational characteristics of where an offense occurred. While there is certainly room for improving our machine learning models and adjusting the variables we initially considered, we have been able to gain new insights regarding overall crime trends in Texas.

# Data Source

## Federal Bureau of Investigation's Crime Data Explorer

The FBI's Crime Data Explorer (CDE) aims to provide transparency, create easier access, and expand awareness of criminal, and noncriminal, law enforcement data sharing; improve accountability for law enforcement; and provide a foundation to help shape public policy with the result of a safer nation. Use the CDE to discover available data through visualizations, download data in .csv format, and other large data files.

## Data Selection

Crime Incident-Based Data by State

Source Publication: Federal Bureau of Investigation

Source URL: https://crime-data-explorer.app.cloud.gov/pages/downloads

![image](https://user-images.githubusercontent.com/88041368/146853633-d96c30dd-5495-42ef-8a9d-f4cd29496695.png)

## Reason for Data Selection:

Becky pitched the initial idea to research available crime data and came across the FBI’s data explorer. The available datasets are incredibly robust and the schemas are both well documented and consistent across multiple years and states. Utilizing data like this allowed us to consider many different questions as well as adjust the scope of our project after meeting together as a team to discuss the direction we wanted to take our project.

## Scope

For the purposes of our analysis we will be exploring the relationship between time of day and types of crimes being committed that have resulted in an arrest. This data does not represent all reported crimes, only those where an arrest took place. The geographical extent of our analysis will focus on the state of Texas and we will utilize data published from 2017-2020. Prior to 2017 a slightly different schema and file naming system was used; after reviewing the amount of data 4 years provided, it was determine the additional steps of schema and file mapping was not necessary for our purposes.

# Working Question:

### Can we predict the type of of crime that will take place based on a variety of spatial, temporal and categorical factors?

*Type of crime will be a classified as crime against persons, society or property*

# Technologies

python: pandas, matplotlib, scikitlearn, numpy, pyspark

AWS: S3, postgres, pgadmin

Tableau, css, javascript, flask ,html, Excel, quickdatabasediagrams.com (ERD), bootstrap

Google Colab, Jupyter Notebook, Github, Gitbash

IDE: python3; mlenv

Heroku

# Contributions

## Segment 1

Initial project design and data availability research

Development of the initial logical data model for the postgres database

Data processing to prepare for machine learning and data ingest into the postgres database

## Segment 2

Data exploration and visualization utilizing Tableau

Creation and publication of the project’s Tableau dashboard

## Segment 3

Website design including template selection, html and css scripts, and consolidation of team inputs

# Mockup Database

Create table relationships:

Data is published as several, separate tables of information

The tables are intended to be used in a relational database

Most of the categorical information has already been made numeric; therefore, many of the tables provided in the bulk download serve as lookup category tables

The information is hierarchal in nature; however, for the purpose of our initial analysis only a handful of the tables are necessary:

![QuickDBD-export (8)](https://user-images.githubusercontent.com/88041368/147418432-0d55ab60-7e09-433b-aae0-179cb7d86d00.png)

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

### Seasonal and Temporal Trends

All three crime type categories follow a similar seasonal trend with fairly little variability from month to month.

An interesting pattern does appear to be emerging in April (4), when the crime trends appear to be on a steady incline but take an unexpected dip prior to shooting back up in May (5).

Temporally, the Crime Against categories of person and society follow similar trends, peaking in the late night/early morning hours. The property category varies in that it peaks in the late afternoon, evening hours.

### Probable Multicollinearity Between Some Independent Variables

From the coefficient heatmap we can see that there is likely a high correlation between the suburban area, population, and total police department employees’ independent variables. This makes sense given that more people live in urban areas and larger populations require larger police departments. We can remove two of these three variables for the purpose of our analyses.

### Measuring Additional Correlation Between Variables

Offense Type has a strong, negative correlation with Crime Against Type; however, this variable must be removed because it has a hierarchal relationship with our dependent variable.

# Data Visulaization with Tableau Dashboard

Additional csv files were generated during the data processing phase specifically for our Tableau Viz—data was aggregated at the county level to visualize our information spatially on the map. The county aggregation allowed us to relate additional county level details such as the median household income, unemployment rate, high school diploma rate, race/ethnicity break out and crime density. Aggregating at the county level enabled us to summarize our processed arrest data to provide an insightful and dynamic visualization.

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



# Segment 3 Dashboard and Website Design
### Circle: Create a dashboard to display your findings.

![Main](https://user-images.githubusercontent.com/88041368/150041629-1b109cf2-3702-45ee-a9fa-d2a935c2cdc3.JPG)
![Question](https://user-images.githubusercontent.com/88041368/150041630-b525ba13-fb96-495f-b544-abda3661c7b4.JPG)
![DataExploration](https://user-images.githubusercontent.com/88041368/150041625-67518f2d-7d4a-485c-bc34-8081f56ca8cd.JPG)
![DataViz](https://user-images.githubusercontent.com/88041368/150041627-1576d19d-9aec-40d4-a288-6074d1487366.JPG)
![DatabaseDesign](https://user-images.githubusercontent.com/88041368/150041623-abf0179a-afdf-482f-b7f2-423078c46c2d.JPG)
![Workflow](https://user-images.githubusercontent.com/88041368/150041620-b88bdb96-13c8-46a4-a54f-76d06cefca71.JPG)
![Team](https://user-images.githubusercontent.com/88041368/150041619-59b58db2-1f8b-4580-a75f-4bfa04dd6158.JPG)

### HTML template was modified to meet the needs of this project; original download source and credits below:
Template Name    : DevFolio - Developer Portfolio Template

Template Link    : https://htmlcodex.com/developer-portfolio-template

Template License : https://htmlcodex.com/license (or read the LICENSE.txt file)

Template Author  : HTML Codex
Author Website   : https://htmlcodex.com

About HTML Codex : HTML Codex is one of the top creators and publishers of Free HTML templates, HTML landing pages, HTML email templates and HTML snippets in the world. Read more at ( https://htmlcodex.com/about-us )
