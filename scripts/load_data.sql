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
    is_open
);

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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_user_friends.csv' 
IGNORE
INTO TABLE User_Friends
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
    user_id,
    business_id,
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_exploded.csv' 
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
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_Ambience_exploded.csv' 
IGNORE
INTO TABLE Ambience
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create BestNights' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_BestNights.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_BestNights_exploded.csv' 
IGNORE
INTO TABLE Best_Nights
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create BusinessParking' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_BusinessParking.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_BusinessParking_exploded.csv' 
IGNORE
INTO TABLE Business_Parking
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create DietaryRestrictions' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_DietaryRestrictions.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_DietaryRestrictions_exploded.csv' 
IGNORE
INTO TABLE Dietary_Restrictions
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);


select '---------------------------------------------------------------------------------------' as '';
select 'Create GoodForMeal' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_GoodForMeal.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_GoodForMeal_exploded.csv' 
IGNORE
INTO TABLE Good_For_Meal
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create HairSpecializesIn' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_HairSpecializesIn.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_HairSpecializesIn_exploded.csv' 
IGNORE
INTO TABLE Hair_Specializes_In
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Music' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_Music.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_attributes_Music_exploded.csv' 
IGNORE
INTO TABLE Music
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    business_id,
    attribute
);

select '---------------------------------------------------------------------------------------' as '';
select 'Create Categories' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_categories_raw.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '/home/andy/Documents/data-bites/yelp_dataset_csv/yelp_academic_dataset_business_categories_exploded.csv' 
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