
-------------------------------------------
-- creation of yelp database
CREATE DATABASE dse_yelp OWNER NguyenQA ENCODING=UTF8; 
#UTF8 is a common for Europe liscence?

-- CITY(id, name, country) #name of objects(tables) shoule be normalcase
-- char domain -character domain: texture domain fixed length- 256 chars (always 256 chars)
-- varchar domain - character varying: variable length- max is 256 chars (upto 256 chars)
CREATE TABLE city(
	id serial PRIMARY KEY, #creating unique value for this atrributes
	name varchar (100) NOT NULL, # number of characters are from 1 to 100
	country char(100) NOT NULL #if we use 80 characters, then 20 empty cells still in used
); 

-- CATEGORY (name)
CREATE TABLE category(
	name varchar PRIMARY KEY #not null
);

CREATE DOMAIN star_values AS integer CHECK (0 <= VALUE and VALUE <= 5);
-- BUSINESS (id, name, neighborhood, postal, street, city, lat, lon, stars, review_count, is_active)
CREATE TABLE business(
	id serial PRIMARY KEY, #serial is an integer
	neighborhood varchar,
	postal char(5), #char is more compact than integer(8 bites), sufficient and less space compared to interger. We don need fo any matimatical operation so it's still ok with char
	street varchar, #reduce the possibility of error, the char could be reached the max lenght 256 chars
	city integer REFERENCES city(id) ON UPDATE NO ACTION ON DELETE NO ACTION, #foreign key: input id attribute from table city. #PREVENT update or modify the ...
	lat float, #float is decimal number
	lon float,
	stars star_values, #we will need to apply mathematical operations to stars attribute. Also its length is different to postcode #CHECK is for adding one more requirement #between and includes the border
	# stars integer CHECK (VALUE BETWEEN 0 and 5)
	# stars integer CHECK (VALUE >= 0 and VALUE <= 5)
	# stars integer CHECK (VALUE IN (0, 1, 2, 3, 4, 5))
	# stars integer CHECK (0 <= VALUE <= 5)
	review_count integer,
	is_active boolean

);

--add gia tri vao
INSERT INTO category(name) VALUES ('drink');

-- integrity constraints (about foreign keys)
-- what happens when a city is deleted? if we have a record with business.city =1 then the record city.id = 1 cannot be deleted/modified
_______________
-- posssible values of intergrity constraints:
-- NO ACTION (default value)
-- CASCADE ------#XEM LAI VIDEO 27/4 1:01:00 
-- SET NULL (if there is any modify/delete action in table city attribute id then the coressponding in business table will be set to NULL)
-- SET DEFAULT
_________________________
-- business.name = 'Apple'
-- max legnth of business.name can be 256 chars
-- postal code: NO NEED to use INTEGER of postal code cuz NO NEED to apply any matematical operation.

_________________________
-- INCAT (business, category)
-- incat.business: the way to call a attributes in a table
-- incat(business): REFERENCES //// is used when we set PRIMARY KEY
CREATE TABLE  incat (
	business integer REFERENCES business(id) ON UPDATE CASCADE ON DELETE CASCADE,
	category varchar REFERENCES category(name)  ON UPDATE CASCADE ON DELETE NO ACTION,
	PRIMARY KEY (business, category) #PK is only one and combine both attributes
);


--------

-- SCHEDULE(business, dat, open, close)
-- FEATURE(name, description)
-- SERVICES(business, feature)
-- REVIEWER(id, name, review_count, yelp_since, useful, funny, cool, fans, avg_stars)
-- FRIEND(reviewer_a, reviewer_b)
-- REVIEW(reviewer, business, reviewer_date, stars, useful, funny, cool)






CREATE DATABASE yelp_dse OWNER nguyen ENCONDING=UTF8;
CREATE TABLE city (
	id serial PRIMARY KEY,
	name varchar(100) NOT NULL,
	country varchar(100) NOT NULL
);
----------
CREATE DOMAIN star_values AS integer CHECK (VALUE between 0 and 5);
----------
CREATE TABLE category( 
	name varchar PRIMARY KEY
);
----------
INSERT category(name) VALUES ('food');
----------
CREATE TABLE business (
	id serial PRIMARY KEY,
	name varchar,
	neighborhood varchar,
	postal char(5),
	street varchar,
	city integer REFERENCES city(id) ON UPDATE NO ACTION ON DELETE NO ACTION --prevent you from deleting/modifying from city table,
	lat float,
	lon float,
	stars star_values,
	review_count integer,
	is_active boolean
);
----------
CREATE TABLE incat(
	business integer REFERENCES business(id) ON UPDATE CASCADE ON DELETE CASCADE,
	category varchar REFERENCES category(name) ON UPDATE CASCADE ON DELETE NO ACTION,
	PRIMARY KEY (business, category)
);









