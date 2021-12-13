SET GLOBAL local_infile = 1;

select '---------------------------------------------------------------------------------------' as '';
select 'Create Business' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business.csv' 
IGNORE
INTO TABLE Business
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
    @is_open
)
SET is_open = IF(@is_open = 'True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create User' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_user.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_user.csv' 
IGNORE
INTO TABLE User
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_user_elite.csv' 
IGNORE
INTO TABLE UserElite
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_user_friends.csv' 
IGNORE
INTO TABLE UserFriends
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    user_id,
    friends
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Checkin' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_checkin.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_checkin.csv' 
IGNORE
INTO TABLE Checkin
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_tips.csv'
IGNORE
INTO TABLE Tips
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    user_id,
    text,
    date,
    compliment_count
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Reviews' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_review.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_review.csv'
IGNORE
INTO TABLE Reviews
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_hours.csv' 
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes.csv' 
IGNORE
INTO TABLE Attributes
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    @RestaurantsTableService,
    WiFi,
    @BikeParking,
    @BusinessAcceptsCreditCards,
    @RestaurantsReservations,
    @WheelchairAccessible,
    @Caters,
    @OutdoorSeating,
    @RestaurantsGoodForGroups,
    @HappyHour,
    @BusinessAcceptsBitcoin,
    RestaurantsPriceRange2,
    @HasTV,
    Alcohol,
    @DogsAllowed,
    @RestaurantsTakeOut,
    NoiseLevel,
    RestaurantsAttire,
    @RestaurantsDelivery,
    @GoodForKids,
    @ByAppointmentOnly,
    @AcceptsInsurance,
    @GoodForDancing,
    @BYOB,
    @CoatCheck,
    Smoking,
    @DriveThru,
    @BYOBCorkage,
    @Corkage,
    @RestaurantsCounterService,
    AgesAllowed,
    @Open24Hours
)
SET RestaurantsTableService = IF(@RestaurantsTableService = 'True',1,0),
    BikeParking = IF(@BikeParking='True', 1,0),
    BusinessAcceptsCreditCards = IF(@BusinessAcceptsCreditCards='True',1,0),
    RestaurantsReservations = IF(@RestaurantsReservations='True',1,0),
    WheelchairAccessible = IF(@WheelchairAccessible='True',1,0),
    Caters = IF(@Caters='True',1,0),
    OutdoorSeating = IF(@OutdoorSeating='True',1,0),
    RestaurantsGoodForGroups = IF(@RestaurantsGoodForGroups='True',1,0),
    HappyHour = IF(@HappyHour='True',1,0),
    BusinessAcceptsBitcoin = IF(@BusinessAcceptsBitcoin='True',1,0),
    HasTV = IF(@HasTV='True',1,0),
    DogsAllowed = IF(@DogsAllowed='True',1,0),
    RestaurantsTakeOut = IF(@RestaurantsTakeOut='True',1,0),
    RestaurantsDelivery = IF(@RestaurantsDelivery='True',1,0),
    GoodForKids = IF(@GoodForKids='True',1,0),
    ByAppointmentOnly = IF(@ByAppointmentOnly='True',1,0),
    AcceptsInsurance = IF(@AcceptsInsurance='True',1,0),
    GoodForDancing = IF(@GoodForDancing='True',1,0),
    BYOB = IF(@BYOB='True',1,0),
    CoatCheck = IF(@CoatCheck='True',1,0),
    DriveThru = IF(@DriveThru='True',1,0),
    BYOBCorkage = IF(@BYOBCorkage='True',1,0),
    Corkage = IF(@Corkage='True',1,0),
    RestaurantsCounterService = IF(@RestaurantsCounterService='True',1,0),
    Open24Hours = IF(@Open24Hours='True',1,0)
;

select '---------------------------------------------------------------------------------------' as '';
select 'Create Ambience' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_Ambience.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_Ambience.csv' 
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_BestNights.csv' 
IGNORE
INTO TABLE BestNights
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_BusinessParking.csv' 
IGNORE
INTO TABLE BusinessParking
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_DietaryRestrictions.csv' 
IGNORE
INTO TABLE DietaryRestrictions
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_GoodForMeal.csv' 
IGNORE
INTO TABLE GoodForMeal
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_HairSpecializesIn.csv' 
IGNORE
INTO TABLE HairSpecializesIn
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_Music.csv' 
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
