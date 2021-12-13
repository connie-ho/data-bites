ALTER TABLE Business ADD PRIMARY KEY (business_id);

ALTER TABLE User ADD PRIMARY KEY (user_id);

ALTER TABLE UserElite ADD FOREIGN KEY (user_id) REFERENCES User(user_id);

ALTER TABLE UserFriends ADD FOREIGN KEY (user_id) REFERENCES User(user_id);
ALTER TABLE UserFriends ADD FOREIGN KEY (user_id) REFERENCES User(user_id);

ALTER TABLE Checkin ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE Tips ADD PRIMARY KEY (business_id, user_id);
ALTER TABLE Tips ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);
ALTER TABLE Tips ADD FOREIGN KEY (user_id) REFERENCES User(user_id);

ALTER TABLE Reviews ADD PRIMARY KEY (review_id);
ALTER TABLE Reviews ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);
ALTER TABLE Reviews ADD FOREIGN KEY (user_id) REFERENCES User(user_id);

ALTER TABLE Business_Hours ADD PRIMARY KEY (business_id);
ALTER TABLE Business_Hours ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE Attributes ADD PRIMARY KEY (business_id);
ALTER TABLE Attributes ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE Ambience ADD PRIMARY KEY (business_id);
ALTER TABLE Ambience ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE BestNights ADD PRIMARY KEY (business_id);
ALTER TABLE BestNights ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE BusinessParking ADD PRIMARY KEY (business_id);
ALTER TABLE BusinessParking ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE DietaryRestrictions ADD PRIMARY KEY (business_id);
ALTER TABLE DietaryRestrictions ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE GoodForMeal ADD PRIMARY KEY (business_id);
ALTER TABLE GoodForMeal ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE HairSpecializesIn ADD PRIMARY KEY (business_id);
ALTER TABLE HairSpecializesIn ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE Music ADD PRIMARY KEY (business_id);
ALTER TABLE Music ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);

ALTER TABLE Categories ADD PRIMARY KEY (business_id);
ALTER TABLE Categories ADD FOREIGN KEY (business_id) REFERENCES Business(business_id);