SELECT business_id, name, AVG(reviews.stars) AS avg_stars, count(review_id) AS num_reviews FROM Business
    LEFT JOIN Reviews USING(business_id)
    LEFT JOIN Categories USING(business_id)
    WHERE city="Boulder" AND state="CO"
    GROUP BY business_id;

SELECT * FROM Business
    LEFT JOIN Reviews USING(business_id) 
    WHERE business_id='6iYb2HFDywm3zjuRg0shjw';

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
