SET foreign_key_checks = 0;
DROP TABLE IF EXISTS Ambience;
DROP TABLE IF EXISTS Best_Nights;
DROP TABLE IF EXISTS Business_Parking;
DROP TABLE IF EXISTS Dietary_Restrictions;
DROP TABLE IF EXISTS Good_For_Meal;
DROP TABLE IF EXISTS Hair_Specializes_In;
DROP TABLE IF EXISTS Music;
DROP TABLE IF EXISTS Attributes;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Business_Hours;
DROP TABLE IF EXISTS Business;
DROP TABLE IF EXISTS Checkin;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Tips;
DROP TABLE IF EXISTS User_Friends;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS User_Elite;
SET foreign_key_checks = 1;

CREATE TABLE Business (
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
    is_open BOOLEAN
);

CREATE TABLE User (
    user_id char(22) NOT NULL,
    name varchar(35),
	-- max is 32
    review_count int, -- if review count is small, then drop column, if it is large, then leave
    yelping_since datetime,
    useful int, -- same for all the tags
    funny int,
    cool int, 
    fans int,
    average_stars int,
    compliment_hot int,
    compliment_more int,
    compliment_profile int,
    compliment_cute int,
    compliment_list int,
    compliment_note int,
    compliment_plain int,
    compliment_cool int,
    compliment_funny int,
    compliment_writer int,
    compliment_photos int
);

CREATE TABLE User_Elite(
    user_id char(22) NOT NULL,
    elite int(4) NOT NULL
    -- elite is the year i.e. 2012; 2015
);

CREATE TABLE User_Friends(
    user_id char(22) NOT NULL,
    friend_id char(22) NOT NULL
);

CREATE TABLE Checkin(
    business_id char(22) NOT NULL,
    date datetime NOT NULL
);

CREATE TABLE Tips (
    user_id char(22) NOT NULL,
    business_id char(22) NOT NULL,
    text varchar(500),
    -- max is 500
    date datetime,
    compliment_count int -- remove if number is small
);

CREATE TABLE Tip_Compliments(
    user_id char(22) NOT NULL,
    business_id char(22) NOT NULL,
    complimenter_id char(22) NOT NULL -- populate with fake user 22x0s
)

CREATE TABLE Reviews (
    review_id char(22) NOT NULL,
    user_id char(22) NOT NULL,
    business_id char(22) NOT NULL,
    stars int,
    useful int, 
    funny int,
    cool int,
    text varchar(5000),
    -- max is 5000
    date datetime
);

CREATE TABLE Business_Hours (
    business_id char(22) NOT NULL,
    Monday char(11),
    Tuesday char(11),
    Wednesday char(11),
    Thursday char(11),
    Friday char(11),
    Saturday char(11),
    Sunday char(11)
	-- max is 11
	-- i.e. 11:0-7:0
	-- Maybe alter opening / closing time for each day
 );

-- attributes=lowercase ask on Tuesday
CREATE TABLE Attributes (
    business_id char(22) NOT NULL,
    attribute char(30) NOT NULL
    -- max is 27
);

-- As we talked about this is gonna remain part of attributes

-- CREATE TABLE Restaurants ( -- make into rows with these attributes as enums
--     business_id char(22) NOT NULL
--     table_service BOOLEAN,
--     reservations BOOLEAN,
--     good_for_groups BOOLEAN, 
--     price_range BOOLEAN,
--     takeout BOOLEAN,
--     attire BOOLEAN,
--     delivery BOOLEAN,
--     counter_service BOOLEAN
-- );

-- Below are now in rows

CREATE TABLE Ambience (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL
);

CREATE TABLE Best_Nights (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL
);

CREATE TABLE Business_Parking (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL
);

CREATE TABLE Dietary_Restrictions (
    business_id char(22) NOT NULL,
    attribute char(15) NOT NULL
);

CREATE TABLE Good_For_Meal (
    business_id char(22) NOT NULL,
    attribute char(10) NOT NULL
);

CREATE TABLE Hair_Specializes_In (
    business_id char(22) NOT NULL,
    attribute char(20) NOT NULL
);

CREATE TABLE Music (
    business_id char(22) NOT NULL,
    attribute char(20) NOT NULL
);

-- Change this 
-- col 1= business; col enum_string
CREATE TABLE Categories (
	business_id char(22) NOT NULL,
	categories varchar(500)
);

