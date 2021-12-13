SELECT business_id, name, AVG(reviews.stars) AS avg_stars, count(review_id) AS num_reviews FROM Business
    LEFT JOIN Reviews USING(business_id)
    LEFT JOIN Categories USING(business_id)
    WHERE city="Boulder" AND state="CO"
    GROUP BY business_id;

INSERT INTO Business (business_id, name, address, city, state, postal_code, longitude, latitude)
VALUES ("6iYb2HFDywm3zjuRg0shjw", "Oskar Blues Taproom", "921 Pearl St", "Boulder", "CO", "80302", "40.0175444","-105.2833481");