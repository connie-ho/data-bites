
select 'Alter Businesses' as '';
ALTER TABLE Businesses 
    ADD PRIMARY KEY (business_id),
    ADD CONSTRAINT check_state_char CHECK(state REGEXP('[A-Za-z][A-Za-z]')),
    ADD CONSTRAINT check_city_char CHECK(city REGEXP('[A-Za-z]+')),
    ADD CONSTRAINT check_latitude CHECK(latitude >= -90 AND latitude <= 90),
    ADD CONSTRAINT check_longitude CHECK(longitude >= -180 AND longitude <= 180),
    ADD CONSTRAINT check_stars CHECK(stars >= 0 AND stars <= 5);

select 'Alter Users' as '';
ALTER TABLE Users 
    ADD PRIMARY KEY (user_id),
    ADD CONSTRAINT check_year_started CHECK(YEAR(yelping_since) >= 2004 AND YEAR(yelping_since) <= 2100),
    ADD CONSTRAINT check_user_average_stars CHECK(average_stars >= 0 AND average_stars <= 5);

select 'Alter User_Elite' as '';
ALTER TABLE User_Elite
    ADD PRIMARY KEY (user_id, elite),
    ADD FOREIGN KEY (user_id) REFERENCES Users(user_id),
    ADD CONSTRAINT check_year_elite CHECK(YEAR(elite) >= 2004 AND YEAR(elite) <= 2100);

select 'Alter User_Friends' as '';
ALTER TABLE User_Friends 
    ADD PRIMARY KEY (user_id, friend_id),
    ADD FOREIGN KEY (user_id) REFERENCES Users(user_id);
-- ALTER TABLE UserFriends ADD FOREIGN KEY (friend_id) REFERENCES Users(user_id);
-- 80+% of friend_ids are not in user_ids... 

-- In some cases not all the data from the business csv is loaded but all the data for the remaining is
-- In my case 8 business_id's weren't loaded from Businesses but exist in every other table
-- Unsure why, tried different embeddings, line-terminations, different optional load parameters like Concurrent etc.
-- If all data is loaded appropriately the Delete from sql command shouldn't delete anything
select 'Alter Checkins' as '';
DELETE FROM Checkins WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Checkins 
    ADD PRIMARY KEY (business_id, date),
    ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Tips' as '';
DELETE FROM Tips WHERE business_id NOT IN (SELECT business_id from Businesses);
-- Not sure what PK should be because user_id, business_id and their combo are not unique
-- Maybe include date as well?
-- Need to update time to Nulls to add FKs
UPDATE Tips SET date = NULL WHERE CAST(date AS CHAR(20)) = '0000-00-00 00:00:00';
ALTER TABLE Tips
    ADD PRIMARY KEY (user_id, business_id, date),
    ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id),
    ADD FOREIGN KEY (user_id) REFERENCES Users(user_id);

select 'Alter Tip_Compliments' as '';
ALTER TABLE Tip_Compliments
    ADD PRIMARY KEY (user_id, business_id, complimenter_id),
    ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id),
    ADD FOREIGN KEY (user_id) REFERENCES Users(user_id);
    -- didn't add foreign key complimenter id because there will definitely be a lot of nulls

select 'Alter Reviews' as '';
DELETE FROM Reviews WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Reviews ADD PRIMARY KEY (review_id),
    ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id),
    ADD FOREIGN KEY (user_id) REFERENCES Users(user_id);

select 'Alter Business_Hours' as '';
DELETE FROM Business_Hours WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Business_Hours 
    ADD PRIMARY KEY (business_id),
    ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id),
    ADD Monday_Open char(5), ADD Monday_Close char(5),
    ADD Tuesday_Open char(5), ADD Tuesday_Close char(5),
    ADD Wednesday_Open char(5), ADD Wednesday_Close char(5),
    ADD Thursday_Open char(5), ADD Thursday_Close char(5),
    ADD Friday_Open char(5), ADD Friday_Close char(5),
    ADD Saturday_Open char(5), ADD Saturday_Close char(5),
    ADD Sunday_Open char(5), ADD Sunday_Close char(5);
WITH split AS (SELECT business_id, 
REGEXP_SUBSTR(Monday,'^[0-9]+:[0-9]+') AS Monday_Open, 
REGEXP_SUBSTR(Monday,'[0-9]+:[0-9]+$') AS Monday_Close,
REGEXP_SUBSTR(Tuesday,'^[0-9]+:[0-9]+') AS Tuesday_Open, 
REGEXP_SUBSTR(Tuesday,'[0-9]+:[0-9]+$') AS Tuesday_Close,
REGEXP_SUBSTR(Wednesday,'^[0-9]+:[0-9]+') AS Wednesday_Open, 
REGEXP_SUBSTR(Wednesday,'[0-9]+:[0-9]+$') AS Wednesday_Close,
REGEXP_SUBSTR(Thursday,'^[0-9]+:[0-9]+') AS Thursday_Open, 
REGEXP_SUBSTR(Thursday,'[0-9]+:[0-9]+$') AS Thursday_Close,
REGEXP_SUBSTR(Friday,'^[0-9]+:[0-9]+') AS Friday_Open, 
REGEXP_SUBSTR(Friday,'[0-9]+:[0-9]+$') AS Friday_Close,
REGEXP_SUBSTR(Saturday,'^[0-9]+:[0-9]+') AS Saturday_Open, 
REGEXP_SUBSTR(Saturday,'[0-9]+:[0-9]+$') AS Saturday_Close,
REGEXP_SUBSTR(Sunday,'^[0-9]+:[0-9]+') AS Sunday_Open, 
REGEXP_SUBSTR(Sunday,'[0-9]+:[0-9]+$') AS Sunday_Close
 FROM Business_Hours) UPDATE Business_Hours t1 INNER JOIN split t2 ON t1.business_id=t2.business_id 
 SET 
 t1.Monday_Open=t2.Monday_Open, t1.Monday_Close=t2.Monday_Close,
 t1.Tuesday_Open=t2.Tuesday_Open, t1.Tuesday_Close=t2.Tuesday_Close,
 t1.Wednesday_Open=t2.Wednesday_Open, t1.Wednesday_Close=t2.Wednesday_Close,
 t1.Thursday_Open=t2.Thursday_Open, t1.Thursday_Close=t2.Thursday_Close,
 t1.Friday_Open=t2.Friday_Open, t1.Friday_Close=t2.Friday_Close,
 t1.Saturday_Open=t2.Saturday_Open, t1.Saturday_Close=t2.Saturday_Close,
 t1.Sunday_Open=t2.Sunday_Open, t1.Sunday_Close=t2.Sunday_Close
 ;
ALTER TABLE Business_Hours
 DROP COLUMN Monday,
 DROP COLUMN Tuesday,
 DROP COLUMN Wednesday,
 DROP COLUMN Thursday,
 DROP COLUMN Friday,
 DROP COLUMN Saturday,
 DROP COLUMN Sunday
 ;

--  ALTER TABLE Business_Hours 
--  drop column Monday_Open, 
--  drop column Monday_Close, 
--  drop column Tuesday_Open, 
--  drop column Tuesday_Close, 
--  drop column Wednesday_Open, 
--  drop column Wednesday_Close, 
--  drop column Thursday_Open, 
--  drop column Thursday_Close, 
--  drop column Friday_Open, 
--  drop column Friday_Close, 
--  drop column Saturday_Open, 
--  drop column Saturday_Close, 
--  drop column Sunday_Open, 
--  drop column Sunday_Close
--  ;


-- MAKE ALL OF THESE LIKE USER FRIENDS AND THEN ENUM

select 'Attributes' as '';
DELETE FROM Attributes WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Attributes ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Restaurants' as '';
ALTER TABLE Restaurants 
    ADD PRIMARY KEY (business_id),
    ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Ambience' as '';
DELETE FROM Ambience WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Ambience ADD PRIMARY KEY (business_id);
ALTER TABLE Ambience ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Best_Nights' as '';
DELETE FROM Best_Nights WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Best_Nights ADD PRIMARY KEY (business_id);
ALTER TABLE Best_Nights ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Business_Parking' as '';
DELETE FROM Business_Parking WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Business_Parking ADD PRIMARY KEY (business_id);
ALTER TABLE Business_Parking ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Dietary_Restrictions' as '';
DELETE FROM Dietary_Restrictions WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Dietary_Restrictions ADD PRIMARY KEY (business_id);
ALTER TABLE Dietary_Restrictions ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Good_For_Meals' as '';
DELETE FROM Good_For_Meals WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Good_For_Meals ADD PRIMARY KEY (business_id);
ALTER TABLE Good_For_Meals ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Hair_Specializes_In' as '';
DELETE FROM Hair_Specializes_In WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Hair_Specializes_In ADD PRIMARY KEY (business_id);
ALTER TABLE Hair_Specializes_In ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Music' as '';
DELETE FROM Music WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Music ADD PRIMARY KEY (business_id);
ALTER TABLE Music ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);

select 'Alter Categories' as '';
DELETE FROM Categories WHERE business_id NOT IN (SELECT business_id from Businesses);
ALTER TABLE Categories ADD FOREIGN KEY (business_id) REFERENCES Businesses(business_id);
