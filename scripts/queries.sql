-- Getting business ids with their respective attributes
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Attributes USING (business_id) 
UNION ALL 
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Ambience USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Best_Nights USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Business_Parking USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Dietary_Restrictions USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Good_For_Meal USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Hair_Specializes_In USING (business_id)
UNION ALL 
SELECT business_id, stars, attribute FROM Businesses INNER JOIN Music USING (business_id)
INTO OUTFILE '/home/andy/Documents/data-bites/database/mysql/business_attributes_stars.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
