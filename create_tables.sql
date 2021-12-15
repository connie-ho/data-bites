SET foreign_key_checks = 0;
DROP TABLE IF EXISTS Ambience;
DROP TABLE IF EXISTS BestNights;
DROP TABLE IF EXISTS BusinessParking;
DROP TABLE IF EXISTS DietaryRestrictions;
DROP TABLE IF EXISTS GoodForMeal;
DROP TABLE IF EXISTS HairSpecializesIn;
DROP TABLE IF EXISTS Music;
DROP TABLE IF EXISTS Attributes;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Business_Hours;
DROP TABLE IF EXISTS Business;
DROP TABLE IF EXISTS Checkin;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Tips;
DROP TABLE IF EXISTS UserFriends;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS UserElite;
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
    review_count int,
    yelping_since datetime,
    useful int,
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

CREATE TABLE UserElite(
    user_id char(22) NOT NULL,
    elite int(4) NOT NULL
    -- elite is the year i.e. 2012; 2015
);

CREATE TABLE UserFriends(
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
    compliment_count int
);

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

CREATE TABLE BestNights (
    business_id char(22) NOT NULL,
    monday BOOLEAN,
    tuesday BOOLEAN,
    friday BOOLEAN,
    wednesday BOOLEAN,
    thursday BOOLEAN,
    sunday BOOLEAN,
    saturday BOOLEAN
);

CREATE TABLE BusinessParking (
    business_id char(22) NOT NULL,
    garage BOOLEAN,
    street BOOLEAN,
    validated BOOLEAN,
    lot BOOLEAN,
    valet BOOLEAN
);

CREATE TABLE DietaryRestrictions (
    business_id char(22) NOT NULL,
    dairy_free BOOLEAN,
    gluten_free BOOLEAN,
    vegan BOOLEAN,
    kosher BOOLEAN,
    halal BOOLEAN,
    soy_free BOOLEAN,
    vegetarian BOOLEAN
);

CREATE TABLE GoodForMeal (
    business_id char(22) NOT NULL,
    dessert BOOLEAN,
    latenight BOOLEAN,
    lunch BOOLEAN,
    dinner BOOLEAN,
    brunch BOOLEAN,
    breakfast BOOLEAN
);

CREATE TABLE HairSpecializesIn (
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

