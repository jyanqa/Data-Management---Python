--18/5--
-- retrieve the name of categories that are not associated to any business
-- HINT: use the LEFT JOIN operation (see slide n.44 of SQL slides)
SELECT name, incat.business
FROM incat RIGHT JOIN category ON incat.category = category.name
WHERE business is NULL;

-- HINT: this query can be solved also through the use of the EXCEPT operation:
SELECT name 
FROM category
EXCEPT -- ## kind of subtract operation
SELECT DISTINCT category
FROM incat;

-- HINT: this query can be solved also through a nested query:
SELECT name
FROM category
WHERE name NOT IN
(SELECT DISTINCT category
FROM incat);


-- retrieve the name of reviewers that are friends
-- HINT: use the TABLE ALIAS (see slide n.50 of SQL slides)
SELECT r1.name AS "reviewer name", r2.name AS "friend of the reviewer"
FROM friend INNER JOIN reviewer AS r1 ON reviewer_a = r1.id INNER JOIN reviewer AS r2 ON reviewer_b = r2.id;

-- retrieve the name of reviewers registered to yelp later than 'Alien' (name of a reviewer)
-- HINT: use the TABLE ALIAS (see slide n.50 of SQL slides)
SELECT r1.name, r1.yelp_since
FROM reviewer AS r1 INNER JOIN reviewer AS r2 ON r1.yelp_since > r2.yelp_since
WHERE r2.name = 'Alien'
ORDER BY r1.yelp_since;

-- alternative syntax:
SELECT r1.name, r1.yelp_since
FROM reviewer AS r1, reviewer AS r2 
WHERE (r2.name = 'Alien') AND (r1.yelp_since > r2.yelp_since)
ORDER BY r1.yelp_since;

--my syntax:
SELECT name, yelp_since
FROM reviewer
WHERE yelp_since > (SELECT yelp_since
	FROM reviewer 
	WHERE name = 'Alien'
); --nested method


-- retrieve the name of reviewers registered to yelp 
-- later than ALL the reviewers named 'Alien' 
SELECT name, yelp_since
FROM reviewer
WHERE yelp_since > 
(SELECT max(yelp_since) 
FROM reviewer
WHERE name = 'Alien');

??-- please, solve this query through the use of join operations (without a nested query)
SELECT r2.name, r2.id, max(r1.yelp_since)
FROM reviewer as r1, reviewer as r2
WHERE r1.name = 'Alien'
GROUP BY r2.id
HAVING max(r1.yelp_since) < r2.yelp_since;



-- retrieve the overall number of available categories
SELECT count(*) AS "number of categories"
FROM category;


-- retrieve the number of categories used by at least one business
SELECT count(DISTINCT category)
FROM incat;


-- for each business, retrieve the number of associated reviews and the max number of stars received in a review
SELECT business, count(*) AS "number of reviews", 
       max(stars) AS "max stars"
FROM review
GROUP BY business;



-- for each business categorized as "Food", retrieve the number of reviews with less than 3 stars
SELECT business.id, business.name, count(*)
FROM review INNER JOIN business ON review.business = business.id INNER JOIN incat ON business.id = incat.business
WHERE category = 'Food' AND review.stars < 3
GROUP BY business.id, business.name;

-- Tuilam
SELECT id, name, count(*)
FROM incat INNER JOIN business ON incat.business = business.id INNER JOIN review ON review.business = business.id
WHERE incat.category = 'Food' and review.stars < 3
GROUP by id;


-- for each reviewer, retrieve the number of performed reviews. Return also the name of the reviewer in the result
SELECT reviewer.id, reviewer.name, count(*)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY reviewer.id;
--tuilam
SELECT id, name, review_count
FROM reviewer
ORDER by name;


-- for each category, retrieve the number of associated businesses
SELECT category, count(*)
FROM incat
GROUP BY category;

-- retrieve name the businesses with more than 5 services offered

SELECT id, name, count(*)
FROM business INNER JOIN services ON business.id = services.business
GROUP BY id
HAVING count(*) > 5;

--Mehdi lam
SELECT name, business
FROM (SELECT business, count(*) FROM services GROUP BY business) AS srvcs
INNER JOIN business ON srvcs.business = business.id
WHERE count > 5;

-- retrieve the name of reviewers that performed more than 10 reviews with at least 3 stars
SELECT reviewer.id, reviewer.name, count(*)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
WHERE stars >= 3
GROUP BY reviewer.id
HAVING count(*) > 10;

--tuilam
SELECT name
FROM (SELECT name, count(*)
FROM reviewer INNER JOIN review ON review.reviewer = reviewer.id
WHERE stars >= 3 
GROUP BY id) as QA
WHERE QA.count > 10;


-- retrieve the name of reviewers that are unique in the database 
-- HINT: reviewers with unique name are those that have a group with just one record according to the name attribute
--tuilam
SELECT name, count(*)
FROM reviewer
GROUP by name
HAVING count(*) = 1;



