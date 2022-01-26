-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/1iEot4
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `arrestee_all` (
    `OFFENSE_TYPE_ID` int  NOT NULL ,
    `ARR_AGE_NUM` int  NOT NULL ,
    `ARR_SEX_CODE` varchar  NOT NULL ,
    `ARR_RACE_ID` int  NOT NULL ,
    `ARR_RESIDENT_CODE` varchar  NOT NULL ,
    `ARRESTEE_ID` int  NOT NULL ,
    `INCIDENT_ID` int  NOT NULL ,
    PRIMARY KEY (
        `OFFENSE_TYPE_ID`,`INCIDENT_ID`
    )
);

CREATE TABLE `incident_all` (
    `INCIDENT_DATE` date  NOT NULL ,
    `INCIDENT_HOUR` int  NOT NULL ,
    `AGENCY_ID` int  NOT NULL ,
    `INCIDENT_ID` int  NOT NULL ,
    PRIMARY KEY (
        `AGENCY_ID`,`INCIDENT_ID`
    )
);

CREATE TABLE `offense_all` (
    `INCIDENT_ID` int  NOT NULL ,
    `OFFENSE_ID` int  NOT NULL ,
    `LOCATION_ID` int  NOT NULL ,
    PRIMARY KEY (
        `INCIDENT_ID`,`OFFENSE_ID`,`LOCATION_ID`
    )
);

CREATE TABLE `using_all` (
    `SUSPECT_USING_ID` int  NOT NULL ,
    `OFFENSE_ID` int  NOT NULL ,
    PRIMARY KEY (
        `OFFENSE_ID`
    )
);

CREATE TABLE `agency_2020` (
    `AGENCY_ID` int  NOT NULL ,
    `AGENCY_TYPE_NAME` varchar  NOT NULL ,
    `POPULATION` int  NOT NULL ,
    `SUBURBAN_AREA_FLAG` varchar  NOT NULL ,
    `TOTAL_EMPLOYEES` int  NOT NULL ,
    `COUNTY_NAME` varchar  NOT NULL ,
    PRIMARY KEY (
        `AGENCY_ID`
    )
);

CREATE TABLE `offense_type` (
    `OFFENSE_TYPE_ID` int  NOT NULL ,
    `CRIME_AGAINST` varchar  NOT NULL ,
    PRIMARY KEY (
        `OFFENSE_TYPE_ID`
    )
);

CREATE TABLE `NIBRS_LOCATION_TYPE` (
    `LOCATION_ID` int  NOT NULL ,
    `LOCATION_CODE` varchar  NOT NULL ,
    `LOCATION_NAME` varchar  NOT NULL ,
    `Location_Type` varchar  NOT NULL ,
    PRIMARY KEY (
        `LOCATION_ID`
    )
);

ALTER TABLE `arrestee_all` ADD CONSTRAINT `fk_arrestee_all_OFFENSE_TYPE_ID` FOREIGN KEY(`OFFENSE_TYPE_ID`)
REFERENCES `offense_type` (`OFFENSE_TYPE_ID`);

ALTER TABLE `arrestee_all` ADD CONSTRAINT `fk_arrestee_all_INCIDENT_ID` FOREIGN KEY(`INCIDENT_ID`)
REFERENCES `incident_all` (`INCIDENT_ID`);

ALTER TABLE `incident_all` ADD CONSTRAINT `fk_incident_all_AGENCY_ID` FOREIGN KEY(`AGENCY_ID`)
REFERENCES `agency_2020` (`AGENCY_ID`);

ALTER TABLE `offense_all` ADD CONSTRAINT `fk_offense_all_INCIDENT_ID` FOREIGN KEY(`INCIDENT_ID`)
REFERENCES `incident_all` (`INCIDENT_ID`);

ALTER TABLE `offense_all` ADD CONSTRAINT `fk_offense_all_LOCATION_ID` FOREIGN KEY(`LOCATION_ID`)
REFERENCES `NIBRS_LOCATION_TYPE` (`LOCATION_ID`);

ALTER TABLE `using_all` ADD CONSTRAINT `fk_using_all_OFFENSE_ID` FOREIGN KEY(`OFFENSE_ID`)
REFERENCES `offense_all` (`OFFENSE_ID`);

