CREATE INDEX idx_name ON Businesses(name);
CREATE INDEX idx_loc_stars ON Businesses(state, city, stars);
CREATE INDEX idx_categories ON Categories(categories);