SET GLOBAL local_infile = 1;

select '---------------------------------------------------------------------------------------' as '';
select 'Create Businesses' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business.csv' 
IGNORE
INTO TABLE Businesses
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    name,
    address,
    city,
    state,
    postal_code,
    latitude,
    longitude,
    stars,
    review_count,
    is_open
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Users' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_user.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_user.csv' 
IGNORE
INTO TABLE Users
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    user_id,
    name,
    review_count,
    yelping_since,
    useful,
    funny,
    cool,
    fans,
    average_stars,
    compliment_hot,
    compliment_more,
    compliment_profile,
    compliment_cute,
    compliment_list,
    compliment_note,
    compliment_plain,
    compliment_cool,
    compliment_funny,
    compliment_writer,
    compliment_photos
);


select '---------------------------------------------------------------------------------------' as '';
select 'Create UserElite' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_user_elite.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_user_elite.csv' 
IGNORE
INTO TABLE User_Elite
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    user_id,
    elite
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create UserFriends' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_user_friends.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_user_friends.csv' 
IGNORE
INTO TABLE User_Friends
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    user_id,
    friend_id
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Checkins' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_checkin.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_checkin.csv' 
IGNORE
INTO TABLE Checkins
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    date
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Tips' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_tips.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_tips.csv'
IGNORE
INTO TABLE Tips
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    user_id,
    business_id,
    text,
    date,
    compliment_count
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Reviews' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_review.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_review.csv'
IGNORE
INTO TABLE Reviews
CHARACTER SET latin1
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    review_id,
    user_id,
    business_id,
    stars,
    useful, 
    funny,
    cool,
    text,
    date
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create BusinessHours' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_hours.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_hours.csv' 
IGNORE
INTO TABLE Business_Hours
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    monday,
    tuesday,
    wednesday,
    thursday, 
    friday,
    saturday,
    sunday
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Attributes' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_attributes.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_exploded.csv' 
IGNORE
INTO TABLE Attributes
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Ambience' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_Ambience.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_Ambience.csv' 
IGNORE
INTO TABLE Ambience
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @touristy,
    @hipster,
    @romantic,
    @divey,
    @intimate,
    @trendy,
    @upscale,
    @classy,
    @casual
)
SET touristy = IF(@touristy = 'True',1,0),
    hipster = IF(@hipster='True', 1,0),
    romantic = IF(@romantic='True',1,0),
    divey = IF(@divey='True',1,0),
    intimate = IF(@intimate='True',1,0),
    trendy = IF(@trendy='True',1,0),
    upscale = IF(@upscale='True',1,0),
    classy = IF(@classy='True',1,0),
    casual = IF(@casual='True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create BestNights' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_BestNights.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_BestNights.csv' 
IGNORE
INTO TABLE Best_Nights
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @monday,
	@tuesday,
	@friday,
	@wednesday,
	@thursday,
	@sunday,
	@saturday
)
SET
	monday = IF(@monday='True',1,0),
	tuesday = IF(@tuesday='True',1,0),
	friday = IF(@friday='True',1,0),
	wednesday = IF(@wednesday='True',1,0),
	thursday = IF(@thursday='True',1,0),
	sunday = IF(@sunday='True',1,0),
	saturday = IF(@saturday='True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create BusinessParking' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_BusinessParking.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_BusinessParking.csv' 
IGNORE
INTO TABLE Business_Parking
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @garage,
	@street,
	@validated,
	@lot,
	@valet
)
SET
	garage = IF(@garage='True',1,0),
	street = IF(@street='True',1,0),
	validated = IF(@validated='True',1,0),
	lot = IF(@lot='True',1,0),
	valet = IF(@valet='True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create DietaryRestrictions' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_DietaryRestrictions.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_DietaryRestrictions.csv' 
IGNORE
INTO TABLE Dietary_Restrictions
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @dairy_free,
	@gluten_free,
	@vegan,
	@kosher,
	@halal,
	@soy_free,
	@vegetarian
)
SET
	dairy_free = IF(@dairy_free='True',1,0),
	gluten_free = IF(@gluten_free='True',1,0),
	vegan = IF(@vegan='True',1,0),
	kosher = IF(@kosher='True',1,0),
	halal = IF(@halal='True',1,0),
	soy_free = IF(@soy_free='True',1,0),
	vegetarian = IF(@vegetarian='True',1,0)
;


select '---------------------------------------------------------------------------------------' as '';
select 'Create GoodForMeal' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_GoodForMeal.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_GoodForMeal.csv' 
IGNORE
INTO TABLE Good_For_Meals
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @dessert,
	@latenight,
	@lunch,
	@dinner,
	@brunch,
	@breakfast
)
SET
	dessert = IF(@dessert='True',1,0),
	latenight = IF(@latenight='True',1,0),
	lunch = IF(@lunch='True',1,0),
	dinner = IF(@dinner='True',1,0),
	brunch = IF(@brunch='True',1,0),
	breakfast = IF(@breakfast='True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create HairSpecializesIn' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_HairSpecializesIn.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_HairSpecializesIn.csv' 
IGNORE
INTO TABLE Hair_Specializes_In
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @straightperms,
	@coloring,
	@extensions,
	@africanamerican,
	@curly,
	@kids,
	@perms,
	@asian
)
SET
	straightperms = IF(@straightperms='True',1,0),
	coloring = IF(@coloring='True',1,0),
	extensions = IF(@extensions='True',1,0),
	africanamerican = IF(@africanamerican='True',1,0),
	curly = IF(@curly='True',1,0),
	kids = IF(@kids='True',1,0),
	perms = IF(@perms='True',1,0),
	asian = IF(@asian='True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create Music' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_Music.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_Music.csv' 
IGNORE
INTO TABLE Music
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @dj,
	@background_music,
	@no_music,
	@jukebox,
	@live,
	@video,
	@karaoke
)
SET
	dj = IF(@dj='True',1,0),
	background_music = IF(@background_music='True',1,0),
	no_music = IF(@no_music='True',1,0),
	jukebox = IF(@jukebox='True',1,0),
	live = IF(@live='True',1,0),
	video = IF(@video='True',1,0),
	karaoke = IF(@karaoke='True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create Categories' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_categories_raw.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_categories_exploded.csv' 
IGNORE
INTO TABLE Categories
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    categories
);