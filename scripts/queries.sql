SELECT business_id, name, AVG(reviews.stars) AS avg_stars, count(review_id) AS num_reviews FROM Businesses
    LEFT JOIN Reviews USING(business_id)
    LEFT JOIN Categories USING(business_id)
    WHERE city="Boulder" AND state="CO"
    GROUP BY business_id;

SELECT * FROM Businesses
    LEFT JOIN Reviews USING(business_id) 
    WHERE business_id='6iYb2HFDywm3zjuRg0shjw';

INSERT INTO Businesses (business_id, name, address, city, state, postal_code, longitude, latitude)
VALUES ("6iYb2HFDywm3zjuRg0shjw", "Oskar Blues Taproom", "921 Pearl St", "Boulder", "CO", "80302", "40.0175444","-105.2833481");