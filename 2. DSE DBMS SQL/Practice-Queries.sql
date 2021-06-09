######### QUERY

#a meaningless database instance: missing avalue, negative number: This is advantages of DBMS because these errors are prevented by the define step
# SUPERKEYS KEYS PRIMARY KEY
# FOREIGN KEY (integrity constraint: whatshappenifI delete one row in this table) 
  --no action(default), cascade, set null, set default
# char vs varchar
# CREATE DATABASE-CREATE TABLE-CREATE DOMAIN-INSERT INTO 
# domain la tap xac dinh cua gia tri nao do

CITY(id, name, country)
CATEGORY (name)
BUSINESS (id, name, neighborhood, postal, street, city, lat, lon, stars, review_count, is_active)
INCAT (business, category): table show category of each biz
SCHEDULE(business, dat, open, close)
FEATURE(name, description)
SERVICES(business, feature)
REVIEWER(id, name, review_count, yelp_since, useful, funny, cool, fans, avg_stars)
FRIEND(reviewer_a, reviewer_b)
REVIEW(reviewer, business, reviewer_date, stars, useful, funny, cool)
------------------------------- L1 -----------------------------------------------------------------
-- creation of yelp database
-- CITY(id, name, country)
-- star_values
-- CATEGORY (name)			 --add Value into category
-- BUSINESS (id, name, neighborhood, postal, street, city, lat, lon, stars, review_count, is_active)
-- INCAT (business, category): table show category of each biz
------------------------------- L2 -----------------------------------------------------------------
-- retrieve the name of reviewers registered from 2016
-- retrieve the name of reviewers with more than 10 reviews and average stars higher than 3
-- retrieve the name of reviewers with less fans than reviews
-- retrieve the name of businesses with at least 3 stars
-- retrieve name, city, country of businesses with at least 3 stars
-- retrieve name, city of businesses in Nevada (NV) with at least 3 stars
-- retrieve name, city of businesses in Nevada (NV) or Arizona (AZ) with at least 3 stars
-- retrieve name, city of businesses in Nevada (NV) with at least 3 stars OR businesses in Arizona (AZ) with at least 4 stars
-- retrieve the city names where businesses of Nevada with at least 3 stars are placed
-- retrieve the features without a description
-- retrieve the name of businesses with corresponding services
-- retrieve the services of business with id = 't2GtB-aiOzrNnuGxZV190g'
-- retrieve the name of businesses with corresponding services (including businesses without services)
-- retrieve the data about businesses that are not associated with any service

------17/5/2020
-- retrieve the businesses whose name is about Pizza
-- retrieve the number of businesses about Pizza Hut
-- retrieve the overall amount of reviews given to all the Pizza Hut
-- retrieve the stars of the worst/best Pizza Hut(lower/higher stars) 
-- retrieve the average stars of all the Pizza Hut

------------------------------- L3 -----------------------------------------------------------------
#LEFT JOIN - EXCEPT - NESTED operation
#TABLE ALIAS --- INNER JOIN ... ON r1.xxx > r2.xxx
#SELECT name, max(xxx) thi bat buoc dung GROUP BY id
#neu co INNER JOIN thi phai GROUP BY id - NEu ko co inner join, co the GROUPBY business hay bat ki attribute nao neu muon
#HAVING COUNT(*) > 10
# muon su duong count(), max() o muc SELECT thi phai dung HAVING 

-- retrieve the name of categories that are not associated to any business
-- HINT: use the LEFT JOIN operation (see slide n.44 of SQL slides)
-- HINT: this query can be solved also through the use of the EXCEPT operation:
-- HINT: this query can be solved also through a nested query:

-- retrieve the name of reviewers that are friends
-- HINT: use the TABLE ALIAS (see slide n.50 of SQL slides)

-- retrieve the name of reviewers registered to yelp later than 'Alien' (name of a reviewer)
---- HINT: use the TABLE ALIAS (see slide n.50 of SQL slides
---- alternative syntax:
---- my syntax --nested method:

-- retrieve the name of reviewers registered to yelp later than ALL the reviewers named 'Alien' 
-----nested method
???-- please, solve this query through the use of join operations (without a nested query)
-- retrieve the overall number of available categories
-- retrieve the number of categories used by at least one business
-- for each business, retrieve the number of associated reviews and the max number of stars received in a review -from review table/business table
##nen xem video thay giai thich tai sao groupby nhu vay

-- for each business categorized as "Food", retrieve the number of reviews with less than 3 stars
-- for each reviewer, retrieve the number of performed reviews. Return also the name of the reviewer in the result
-- for each category, retrieve the number of associated businesses
-- retrieve the businesses with more than 5 services offered
-- retrieve the name of reviewers that performed more than 10 reviews with at least 3 stars
-- retrieve the name of reviewers that are unique in the database 
---- HINT: reviewers with unique name are those that have a group with just one record according to the name attribute
--tuilam
------------------------------- L4 -----------------------------------------------------------------

-- retrieve the name of inactive business units that are placed in the same city
SELECT b1.name, b2.name, b1.city, b2.city
FROM business b1 INNER JOIN business b2 ON (b1.city = b2.city AND b1.id <> b2.id)
WHERE b1.is_active = False AND b2.is_active = False;


-- retrieve the name of inactive business units that are placed in the same country
SELECT b1.name AS "business name", c1.name AS "city", b2.name AS "business name", c2.name AS "city", c1.country --, c2.country
FROM business AS b1
	INNER JOIN city AS c1 ON b1.city = c1.id
	INNER JOIN business AS b2
	INNER JOIN city AS c2 ON b2.city = c2.id
	ON b1.id <> b2.id AND c1.country = c2.country
WHERE b1.is_active = FALSE AND b2.is_active = FALSE;



-- retrieve the other categories associated with business units about "Food"
SELECT * 
FROM incat i1 INNER JOIN incat i2 ON (i1.business = i2.business AND i1.category <> i2.category)
WHERE i2.category = 'Food';
--tuilam
SELECT i2.category, i1.category
FROM incat AS i1 INNER JOIN incat AS i2 ON (i1.business =i2.business AND i2.category <> 'Food')
WHERE i1.category ='Food';
----
SELECT DISTINCT category
FROM incat
WHERE business IN 
(SELECT business 
FROM incat
WHERE category = 'Food');


-- retrieve the id of business units that have been reviewed by the same reviewer after October 2017
SELECT DISTINCT r1.business AS "business 1", r2.business AS "business 2", r1.reviewer AS "reviewer 1", r2.reviewer AS "reviewer 2"
FROM review AS r1 INNER JOIN review AS r2 ON (r1.business <> r2.business AND r1.reviewer = r2.reviewer)
WHERE r1.review_date >= '2017-11-01' AND r2.review_date >= '2017-11-01';


-- retrieve the id of reviewers that reviewed the same business after October 2017
SELECT DISTINCT r1.reviewer AS "reviewer 1", r2.reviewer AS "reviewer 2", r1.business AS "business 1", r2.business AS "business 2"
FROM review AS r1 INNER JOIN review as r2 ON (r1.business = r2.business AND r1.reviewer <> r2.reviewer)
WHERE r1.review_date >= '2017-11-01' AND r2.review_date >= '2017-11-01';


-- retrieve the id of business units that received a number of reviews higher than average
SELECT name, review_count
FROM business
WHERE review_count >
(SELECT avg(review_count)
FROM business);


-- retrieve the name of businesses in Las Vegas (NV) OR Kent (OH)
SELECT business.name AS business
FROM business INNER JOIN city ON business.city = city.id
WHERE (city.name = 'Las Vegas' AND country = 'NV') OR 
	(city.name = 'Kent' AND country = 'OH');
	
-- alternative solution through the UNION set operation:
SELECT business.name AS business
FROM business INNER JOIN city ON business.city = city.id
WHERE (city.name = 'Las Vegas' AND country = 'NV') 
UNION
SELECT business.name AS business
FROM business INNER JOIN city ON business.city = city.id
WHERE (city.name = 'Kent' AND country = 'OH');
	

-- retrieve the name of businesses in Las Vegas (NV) AND Kent (OH)
SELECT DISTINCT business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE city.name = 'Las Vegas' AND country = 'NV'
INTERSECT
SELECT DISTINCT business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE city.name = 'Kent' AND country = 'OH';

-- alternative solution through nested queries: CHUA THU
SELECT DISTINCT business.name AS business
FROM business INNER JOIN city ON business.city = city.id
WHERE (city.name = 'Las Vegas' AND country = 'NV') 
AND business.name IN 
(SELECT business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE (city.name = 'Kent' AND country = 'OH')); 


-- retrieve the services non offered by the businesses of Las Vegas (NV)
SELECT name
FROM feature
EXCEPT
SELECT DISTINCT feature
FROM services INNER JOIN business ON business.id = services.business INNER JOIN city ON business.city = city.id
WHERE city.name = 'Las Vegas' AND country = 'NV';
--tuilam
SELECT name
FROM feature
WHERE feature NOT IN (
	SELECT DISTINCT feature
	FROM business INNER JOIN services ON business.id = services.business 
				  INNER JOIN city ON city.id = business.city
	WHERE city.name = 'Las Vegas' and city.country ='NV');


-- retrieve the services offered by the businesses Las Vegas (NV) AND Kent (OH) COI LAI!!!!!!

SELECT DISTINCT feature
FROM services INNER JOIN business ON business.id = services.business INNER JOIN city ON business.city = city.id
WHERE city.name = 'Las Vegas' AND country = 'NV'
INTERSECT
SELECT DISTINCT feature
FROM services INNER JOIN business ON business.id = services.business INNER JOIN city ON business.city = city.id
WHERE city.name = 'Kent' AND country = 'OH';

--tuilam
SELECT b1.name, b1.name, c1.name, c2.name
FROM business b1 INNER JOIN city c1 ON b1.city = c1.id
INNER JOIN business b2 INNER JOIN city c2 ON b2.city = c2.id  ON b1.name = b2.name
WHERE (c1.name = 'Las Vegas' AND c1.country = 'NV') AND 
	(c2.name = 'Kent' AND c2.country = 'OH');


-- ?????????? retrieve the name of reviewers that did not perform any review
--TAISAODAPAN BANG 0

-- ????????? retrieve the name of businesses that did not receive any review
--- TAI SAO DAP AN BANG 0

-- retrieve the category with the highest number of business units
SELECT category, count(*)
FROM incat
GROUP BY category
HAVING count(*) >= ALL
(SELECT count(*)
FROM incat
GROUP BY category);

--tuilam duoc den day
SELECT count(category), category
FROM incat
GROUP by category;



-- retrieve the business with the highest number of associated services
SELECT business, count(*)
FROM services
GROUP BY business
HAVING count(*) >=  ALL(
							SELECT count(*)
							FROM services
							GROUP BY business);












------------------------------- L5 -----------------------------------------------------------------










