SET GLOBAL local_infile = 1;

select '---------------------------------------------------------------------------------------' as '';
select 'Load Businesses' as '';

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
select 'Load Users' as '';

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
select 'Load UserElite' as '';

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
select 'Load UserFriends' as '';

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
select 'Load Checkins' as '';

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
select 'Load Tips' as '';

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
select 'Load Reviews' as '';

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
select 'Load BusinessHours' as '';

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
select 'Load Attributes' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_attributes_exploded.csv' 
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
select 'Load Ambience' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_Ambience_exploded.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_Ambience_exploded.csv' 
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
select 'Load BestNights' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_BestNights_exploded.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_BestNights_exploded.csv' 
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
select 'Load BusinessParking' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_BusinessParking_exploded.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_BusinessParking_exploded.csv' 
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
select 'Load DietaryRestrictions' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_DietaryRestrictions_exploded.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_DietaryRestrictions_exploded.csv' 
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
select 'Load GoodForMeal' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_GoodForMeal_exploded.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_GoodForMeal_exploded.csv' 
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
select 'Load HairSpecializesIn' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_HairSpecializesIn_exploded.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_HairSpecializesIn_exploded.csv' 
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
select 'Load Music' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_attributes_Music_exploded.csv' 
LOAD DATA CONCURRENT LOCAL INFILE '../yelp-dataset-csv/yelp_academic_dataset_business_attributes_Music_exploded.csv' 
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
select 'Load Categories' as '';

-- LOAD DATA CONCURRENT LOCAL INFILE '/var/lib/mysql-files/yelp_academic_dataset_business_categories_exploded.csv' 
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