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
    attribute
);

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
    attribute
);

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
    attribute
);

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
    attribute
);


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
    attribute
);

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
    attribute
);

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
    attribute
);

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