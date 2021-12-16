ALTER TABLE Categories MODIFY COLUMN categories VARCHAR(40);

ALTER TABLE User DROP compliment_hot;
ALTER TABLE User DROP compliment_more;
ALTER TABLE User DROP compliment_profile;
ALTER TABLE User DROP compliment_cute;
ALTER TABLE User DROP compliment_list;
ALTER TABLE User DROP compliment_note;
ALTER TABLE User DROP compliment_plain;
ALTER TABLE User DROP compliment_cool;
ALTER TABLE User DROP compliment_funny;
ALTER TABLE User DROP compliment_writer;
ALTER TABLE User DROP compliment_photos;

ALTER TABLE User DROP useful;
ALTER TABLE User DROP funny;
ALTER TABLE User DROP cool;
ALTER TABLE User DROP fans;
ALTER TABLE User DROP review_count;
