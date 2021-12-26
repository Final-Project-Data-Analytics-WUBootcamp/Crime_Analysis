# Federal Bureau of Investigation's Crime Data Explorer

The FBI's Crime Data Explorer (CDE) aims to provide transparency, create easier access, and expand awareness of criminal, and noncriminal, law enforcement data sharing; improve accountability for law enforcement; and provide a foundation to help shape public policy with the result of a safer nation. Use the CDE to discover available data through visualizations, download data in .csv format, and other large data files.

## Working Question:

### What is the relationship between time of day and the type of crime being committed?

*Type of crime will be a classification of the data*

## Data Selection

Crime Incident-Based Data by State

Source Publication: Federal Bureau of Investigation

Source URL: https://crime-data-explorer.app.cloud.gov/pages/downloads

![image](https://user-images.githubusercontent.com/88041368/146853633-d96c30dd-5495-42ef-8a9d-f4cd29496695.png)

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

Initial data processing completed to identify relevant information to explore:

Read in csv files of interest, remove extra columns in each df that are not necessary for data analysis, remove records that have NaN values from each df, merge df’s to flatten the hierarchal data structure to allow for initial data exploration

## Mockup Database

Create table relationships:

Data is published as several, separate tables of information

The tables are intended to be used in a relational database

Most of the categorical information has already been made numeric; therefore, many of the tables provided in the bulk download serve as lookup category tables

The information is hierarchal in nature; however, there are a handful of tables that must be merged prior to the linkage to other, subsidiary tables of information
![image](https://user-images.githubusercontent.com/88041368/146854072-ce907d84-a40b-4a51-9f3c-7164b4e57d3b.png)
