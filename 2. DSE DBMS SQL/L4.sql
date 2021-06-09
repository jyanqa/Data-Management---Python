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











