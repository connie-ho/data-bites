SET foreign_key_checks = 0;
DROP TABLE IF EXISTS Ambience;
DROP TABLE IF EXISTS Attributes;
DROP TABLE IF EXISTS Best_Nights;
DROP TABLE IF EXISTS Business_Parking;
DROP TABLE IF EXISTS Dietary_Restrictions;
DROP TABLE IF EXISTS Good_For_Meals;
DROP TABLE IF EXISTS Hair_Specializes_In;
DROP TABLE IF EXISTS Music;
DROP TABLE IF EXISTS Attributes;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Business_Hours;
DROP TABLE IF EXISTS Businesses;
DROP TABLE IF EXISTS Checkins;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS Tips;
DROP TABLE IF EXISTS Tip_Compliments;
DROP TABLE IF EXISTS User_Compliments;
DROP TABLE IF EXISTS User_Friends;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS User_Elite;
SET foreign_key_checks = 1;

CREATE TABLE Businesses (
    business_id char(22) NOT NULL,
    name varchar(70) NOT NULL,
	-- max is 64
    address varchar(110) NOT NULL,
	-- max is 107
    city varchar(40) NOT NULL,
	-- max is 35
    state char(2) NOT NULL, 
	-- max is 2; there is one incorrect entry with 3 letters
    postal_code char(7) NOT NULL,
	-- max is 7 with few postal-codes missing all values (missing last number)
    latitude decimal(13,10) NOT NULL,
    longitude decimal(13,10) NOT NULL,
    stars float,
    review_count int,
    is_open BOOLEAN,
    PRIMARY KEY(business_id)
);

CREATE TABLE Users (
    user_id char(22) NOT NULL,
    name varchar(35),
	-- max is 32
    review_count int DEFAULT 0,
    yelping_since datetime,
    useful int DEFAULT 0, -- same for all the tags
    funny int DEFAULT 0,
    cool int DEFAULT 0,
    fans int DEFAULT 0,
    average_stars int DEFAULT 0,
    compliment_hot int DEFAULT 0,
    compliment_more int DEFAULT 0,
    compliment_profile int DEFAULT 0,
    compliment_cute int DEFAULT 0,
    compliment_list int DEFAULT 0,
    compliment_note int DEFAULT 0,
    compliment_plain int DEFAULT 0,
    compliment_cool int DEFAULT 0,
    compliment_funny int DEFAULT 0,
    compliment_writer int DEFAULT 0,
    compliment_photos int DEFAULT 0,
    PRIMARY KEY (user_id)
);

CREATE TABLE User_Elite(
    user_id char(22) NOT NULL,
    elite int(4) NOT NULL,
    PRIMARY KEY (user_id, elite)
    -- elite is the year i.e. 2012; 2015
);

CREATE TABLE User_Friends(
    user_id char(22) NOT NULL,
    friend_id char(22) NOT NULL,
    PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE Checkins(
    business_id char(22) NOT NULL,
    date datetime NOT NULL,
    PRIMARY KEY (business_id, date),
    FOREIGN KEY (business_id) REFERENCES Businesses(business_id)
);

CREATE TABLE Tips (
    user_id char(22) NOT NULL,
    business_id char(22) NOT NULL,
    text text,
    -- max is 500
    date datetime DEFAULT '1970-01-01 00:00:00',
    compliment_count int DEFAULT 0, -- remove if number is small
    PRIMARY KEY (user_id, business_id, date)
);

CREATE TABLE Tip_Compliments(
    user_id char(22) NOT NULL,
    business_id char(22) NOT NULL,
    complimenter_id char(22) NOT NULL,
    PRIMARY KEY (user_id, business_id, complimenter_id)
);

CREATE TABLE User_Compliments(
    user_id char(22) NOT NULL,
    complimenter_id char(22) NOT NULL, 
    PRIMARY KEY (user_id, complimenter_id)
);

CREATE TABLE Reviews (
    review_id char(22) NOT NULL,
    user_id char(22) NOT NULL,
    business_id char(22) NOT NULL,
    stars int DEFAULT 0,
    useful int DEFAULT 0, 
    funny int DEFAULT 0,
    cool int DEFAULT 0,
    text text,
    -- max is 5000
    date datetime,
    PRIMARY KEY (review_id),
    UNIQUE (business_id, user_id)
);

CREATE TABLE Business_Hours (
    business_id char(22) NOT NULL,
    Monday char(11),
    Tuesday char(11),
    Wednesday char(11),
    Thursday char(11),
    Friday char(11),
    Saturday char(11),
    Sunday char(11),
	-- max is 11
	-- i.e. 11:0-7:0
	-- Maybe alter opening / closing time for each day
    PRIMARY KEY (business_id)
 );

CREATE TABLE Attributes (
    business_id char(22) NOT NULL,
    attribute char(30) NOT NULL,
    PRIMARY KEY (business_id, attribute)
    -- max is 27
);

CREATE TABLE Ambience (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL,
    PRIMARY KEY (business_id, attribute)
);

CREATE TABLE Best_Nights (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL,
    PRIMARY KEY (business_id, attribute)
);

CREATE TABLE Business_Parking (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL,
    PRIMARY KEY (business_id, attribute)
);

CREATE TABLE Dietary_Restrictions (
    business_id char(22) NOT NULL,
    attribute char(15) NOT NULL,
    PRIMARY KEY (business_id, attribute)
);

CREATE TABLE Good_For_Meals (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL,
    PRIMARY KEY (business_id, attribute)
);

CREATE TABLE Hair_Specializes_In (
    business_id char(22) NOT NULL,
    attribute char(20) NOT NULL,
    PRIMARY KEY (business_id, attribute)
);

CREATE TABLE Music (
    business_id char(22) NOT NULL,
    attribute char(20) NOT NULL,
    PRIMARY KEY (business_id, attribute)
);

CREATE TABLE Categories (
	business_id char(22) NOT NULL,
	categories varchar(40),
    PRIMARY KEY (business_id, categories)
);

