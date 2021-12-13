Business Entity:
    - Remove stars: non-atomic attribute (average stars of all ratings/reviews)
    - Remove review_count: non-atomic attribute (count of all reviews)
    - Separate restaurant attributes from regular attributes
    - Remove, useful, funny, cool from user table 

Reviews Entity:
    - useful, funny, cool are integer values continually being updated, but we can't know which user liked the review ...

Tips Entity:
    - Get rid of compliment_count: non-atomic attribute (count of all user's attributes)

Things to think about
    - Business parking: columns or rows?
    - Reviews, text in separate table?