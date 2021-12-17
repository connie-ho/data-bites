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

ERROR 1062 (23000): Duplicate entry '--UNNdnHRhsyFUbDgumdtQ-2016-05-20 03:31:03' for key 'checkins.PRIMARY'
+------------+
|            |
+------------+
| Alter Tips |
+------------+
1 row in set (0.00 sec)

Query OK, 143 rows affected (1.38 sec)

Query OK, 46 rows affected (0.44 sec)
Rows matched: 46  Changed: 46  Warnings: 0

ERROR 1062 (23000): Duplicate entry '51Yfy5Xv27dHi74E3XJ-oQ-Bd374WlV8Sz3v_117_3Q7g-2011-07-18 00:34:1' for key 'tips.PRIMARY'