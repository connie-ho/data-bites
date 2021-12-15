ALTER TABLE Business ADD PRIMARY KEY (business_id);
ALTER TABLE Business ADD CONSTRAINT check_state_char CHECK(state REGEXP('[A-Za-z][A-Za-z]'));
ALTER TABLE Business ADD CONSTRAINT check_city_char CHECK(city REGEXP('[A-Za-z]+'));
ALTER TABLE Business ADD CONSTRAINT check_latitude CHECK(latitude >= -90 AND latitude <= 90);
ALTER TABLE Business ADD CONSTRAINT check_longitude CHECK(longitude >= -180 AND longitude <= 180);
ALTER TABLE Business ADD CONSTRAINT check_stars CHECK(stars >= 0 AND stars <= 5);

ALTER TABLE User ADD PRIMARY KEY (user_id);
ALTER TABLE User ADD CONSTRAINT check_year_started CHECK(YEAR(yelping_since) >= 2004 AND YEAR(yelping_since) <= 2100);
ALTER TABLE User ADD CONSTRAINT check_user_average_stars CHECK(average_stars >= 0 AND average_stars <= 5);

ALTER TABLE UserElite ADD FOREIGN KEY (user_id) REFERENCES User(user_id);
ALTER TABLE UserElite ADD CONSTRAINT check_year_elite CHECK(YEAR(elite) >= 2004 AND YEAR(elite) <= 2100);

ALTER TABLE UserFriends ADD FOREIGN KEY (user_id) REFERENCES User(user_id);
-- ALTER TABLE UserFriends ADD FOREIGN KEY (friend_id) REFERENCES User(user_id);
-- 80+% of friend_ids are not in user_ids... 

-- About 8 business_ids in checkin are not present in Business so we remove them
DELETE FROM Checkin WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE Checkin ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

-- About 8 business_ids in checkin are not present in Business so we remove them
DELETE FROM Tips WHERE business_id NOT IN (SELECT business_id from Business);
-- Not sure what PK should be because user_id, business_id and their combo are not unique
-- Maybe include date as well?
-- Need to update time to Nulls to add FKs
UPDATE Tips SET date = NULL WHERE CAST(date AS CHAR(20)) = '0000-00-00 00:00:00';
ALTER TABLE Tips ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);
ALTER TABLE Tips ADD FOREIGN KEY (user_id) REFERENCES User(user_id);

-- About 8 business_ids in checkin are not present in Business so we remove them
DELETE FROM Reviews WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE Reviews ADD PRIMARY KEY (review_id);
ALTER TABLE Reviews ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);
ALTER TABLE Reviews ADD FOREIGN KEY (user_id) REFERENCES User(user_id);

-- About 8 business_ids in checkin are not present in Business so we remove them
DELETE FROM Business_Hours WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE Business_Hours ADD PRIMARY KEY (business_id);
ALTER TABLE Business_Hours ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM Attributes WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE Attributes ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM Ambience WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE Ambience ADD PRIMARY KEY (business_id);
ALTER TABLE Ambience ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM BestNights WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE BestNights ADD PRIMARY KEY (business_id);
ALTER TABLE BestNights ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM BusinessParking WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE BusinessParking ADD PRIMARY KEY (business_id);
ALTER TABLE BusinessParking ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM DietaryRestrictions WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE DietaryRestrictions ADD PRIMARY KEY (business_id);
ALTER TABLE DietaryRestrictions ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM GoodForMeal WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE GoodForMeal ADD PRIMARY KEY (business_id);
ALTER TABLE GoodForMeal ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM HairSpecializesIn WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE HairSpecializesIn ADD PRIMARY KEY (business_id);
ALTER TABLE HairSpecializesIn ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM Music WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE Music ADD PRIMARY KEY (business_id);
ALTER TABLE Music ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

DELETE FROM Categories WHERE business_id NOT IN (SELECT business_id from Business);
ALTER TABLE Categories ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);
