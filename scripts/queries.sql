SELECT business_id, name, review_count, stars, categories FROM Businesses
    LEFT JOIN Categories USING(business_id)
    WHERE city="Boulder" AND state="CO" and categories IN ("Food,Restaurants")
    GROUP BY business_id;

SELECT * FROM Businesses
    LEFT JOIN Reviews USING(business_id) 
    WHERE business_id='6iYb2HFDywm3zjuRg0shjw';

INSERT INTO Businesses (business_id, name, address, city, state, postal_code, longitude, latitude)
VALUES ("6iYb2HFDywm3zjuRg0shjw", "Oskar Blues Taproom", "921 Pearl St", "Boulder", "CO", "80302", "40.0175444","-105.2833481");

select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME 
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'Tip_Compliments';

SELECT Tips.* 
FROM Tips 
LEFT JOIN Users 
  ON Users.user_id = Tips.user_id 
WHERE Users.user_id IS NULL;

set global local_infile=true;

DELETE t1 FROM Checkins t1
INNER JOIN Checkins t2 
WHERE 
    t1.business_id = t2.business_id AND 
    t1.date = t2.date;

 SELECT name, stars, review_count, address, city, state, postal_code, COUNT(date) as checkins
    FROM Businesses LEFT JOIN Checkins USING (business_id)
    WHERE business_id='i3YZocozAfEWTRIJX3HTQ' GROUP BY business_id;
    
EXPLAIN(SELECT review_id, user_id, name, stars, text, date, Reviews.useful, Reviews.funny, Reviews.cool FROM Reviews
INNER JOIN Users USING(user_id)
WHERE business_id="HcY5FBcFbuUkYh-4BM0YnQ");
    
INSERT INTO Business (business_id, name, address, city, state, postal_code, longitude, latitude)
VALUES ("6iYb2HFDywm3zjuRg0shjw", "Oskar Blues Taproom", "921 Pearl St", "Boulder", "CO", "80302", "40.0175444","-105.2833481");

-- Getting business ids with their respective attributes
SELECT business_id, stars, attribute FROM Business INNER JOIN Attributes USING (business_id) 
UNION ALL 
SELECT business_id, stars, attribute FROM Business INNER JOIN Ambience USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Business INNER JOIN Best_Nights USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Business INNER JOIN Business_Parking USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Business INNER JOIN Dietary_Restrictions USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Business INNER JOIN Good_For_Meal USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Business INNER JOIN Hair_Specializes_In USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Business INNER JOIN Music USING (business_id)
INTO OUTFILE '/home/andy/Documents/data-bites/database/mysql/business_attributes_stars.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
