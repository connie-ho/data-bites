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
    is_open BOOLEAN
);

CREATE TABLE Users (
    user_id char(22) NOT NULL,
    name varchar(35),
	-- max is 32
    review_count int DEFAULT 0, -- if review count is small, then drop column, if it is large, then leave
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
    compliment_photos int DEFAULT 0
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
    date datetime,
    compliment_count int DEFAULT 0, -- remove if number is small
    PRIMARY KEY (user_id, business_id, date)
);

CREATE TABLE Tip_Compliments(
    user_id char(22) NOT NULL,
    business_id char(22) NOT NULL,
    complimenter_id char(22) NOT NULL -- populate with fake user 22x0s
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

CREATE TABLE Restaurants ( -- make into rows with these attributes as enums
    business_id char(22) NOT NULL,
    table_service BOOLEAN,
    reservations BOOLEAN,
    good_for_groups BOOLEAN, 
    price_range BOOLEAN,
    takeout BOOLEAN,
    attire BOOLEAN,
    delivery BOOLEAN,
    counter_service BOOLEAN
);

CREATE TABLE Ambience (
    business_id char(22) NOT NULL,
    touristy BOOLEAN,
    hipster BOOLEAN,
    romantic BOOLEAN,
    divey BOOLEAN,
    intimate BOOLEAN,
    trendy BOOLEAN,
    upscale BOOLEAN,
    classy BOOLEAN,
    casual BOOLEAN
);

CREATE TABLE Best_Nights (
    business_id char(22) NOT NULL,
    monday BOOLEAN,
    tuesday BOOLEAN,
    friday BOOLEAN,
    wednesday BOOLEAN,
    thursday BOOLEAN,
    sunday BOOLEAN,
    saturday BOOLEAN
);

CREATE TABLE Business_Parking (
    business_id char(22) NOT NULL,
    garage BOOLEAN,
    street BOOLEAN,
    validated BOOLEAN,
    lot BOOLEAN,
    valet BOOLEAN
);

CREATE TABLE Dietary_Restrictions (
    business_id char(22) NOT NULL,
    dairy_free BOOLEAN,
    gluten_free BOOLEAN,
    vegan BOOLEAN,
    kosher BOOLEAN,
    halal BOOLEAN,
    soy_free BOOLEAN,
    vegetarian BOOLEAN
);

CREATE TABLE Good_For_Meals (
    business_id char(22) NOT NULL,
    dessert BOOLEAN,
    latenight BOOLEAN,
    lunch BOOLEAN,
    dinner BOOLEAN,
    brunch BOOLEAN,
    breakfast BOOLEAN
);

CREATE TABLE Hair_Specializes_In (
    business_id char(22) NOT NULL,
    straightperms BOOLEAN,
    coloring BOOLEAN,
    extensions BOOLEAN,
    africanamerican BOOLEAN,
    curly BOOLEAN,
    kids BOOLEAN,
    perms BOOLEAN,
    asian BOOLEAN
);

CREATE TABLE Music (
    business_id char(22) NOT NULL,
    dj BOOLEAN,
    background_music BOOLEAN,
    no_music BOOLEAN,
    jukebox BOOLEAN,
    live BOOLEAN,
    video BOOLEAN,
    karaoke BOOLEAN
);

-- Change this 
-- col 1= business; col enum_string
CREATE TABLE Categories (
	business_id char(22) NOT NULL,
	categories varchar(500)
);

