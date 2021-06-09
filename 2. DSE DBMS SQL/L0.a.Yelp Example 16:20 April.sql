-- A business unit represents a commercial enterprise characterized by name and address (street, postal code, neighborhood, city)
-- About a city, we know the corresponding country
-- About a business, we know
	• latitude and longitude details
	• the stars featuring the services 
	• the number of received reviews
——————————
-- Name of table/ Name of Attributes:  should be single name/ not multiple name
-- No use upper case
-- Name of attributes should not with blank space
-- Editor: Notepad, notepad++, sublime, textranker for mac?

————————
-- given a business, how many addresses? just one
-- PK: primary key
-- one-to-many association between business and address
_________
DEFNITION in DATABASE
-- SUPERKEYS: where we dont have need of minimality of attribites
-- KEYS: where we include the notion of minnimality
SUPERKEYS la tap me cua KEYS (# attribute cua superkeys >= of keys)
-- PRIMARY KEYS: is a KEYS without NULL Values (entity integrity constraint: thuc the - toan ven)
___________

business(id(PK), name, address, stars, review_count, catergories) #as the below table #trong dap an cua thay co ca #is_active


address (id(PK), street, latitude,longitude, postal_code, neighborhood, city)
-- one - to - many association between address and city
city(id(PK),name, country)

-- many-to-many association is defined between business and categories
incat((business, category)PK)
category (name(PK) ) #attribute name of category is unique



alternative solutions:
incat.id as PK #su dung option nay khi minh can dung bang nay cho mot bang khac
incat.business, incat.category as PK # trong bai nay thay dung bang nay
-----------------------
category
name
--------
software
computer science
dressing
phone
... 
---------------------
incat #table
business 		| category
--------------------------
1				software
2				computer science	
2				software
2				phone


---------------------------addition requirements we satisfied
-- We distinguish between active/inactive businesses
-- businesses are classified into catergories (multiple catergories are possible for a biz)
-- ###this is called atomic value (a value each cell)
-- we know the schedule of opening hours of each business. Different openings hours od a biz are possible a long week days

-- how many records of table 'schedule' are related to each specific record of business table? Many rows
--Answer: maybe 7 rows. so we add in biz table one more attribute: schedules. Not possible
--We consider another sol: Howmany records of the table 'busines' are related to each specific record of 'scheudle'?
schedule((business, day, open_hour)PK, close_hour) #We need something to cnnect this table to business table
-- alternative: create id for schedule but its not sufficient because setting the biz, day, open is PK iis much simpler.  
----------------we should use a group of attributes as Identifizer instead of always creating ID column

schedule
business | day | open_hour |  close_hour
1			MON		8:00		12:00
1			TUE		8:00		19:00
2			MON		9:00		15:00
2			TUE		8:00		19:00
...

# If we want to avoid the duplicate the repeating dat/open_hour/close_hour, we can create a new table of time. However, this is costly, we avoid it by doing as here
___________
-- A set of services/features can be associated with businesses. A feature has a name and a description (multiple features are possible for a business)

feature(name(PK, description) _________
#how many business for a feature? many
# how many features of a business? many
service(business, feature)
_________
-- Businesses are reviewed by reviewers by assigning a certain number of stars in the range [1-5]. A business can be reviewed by a certain reviewer multiple times in different dates
-- About a review, we know the number of users that consider the review as useful/funny/cool
#### Many to Many (business vs reviewer)
reviewer(id(PK), name, rdate, n_reviews, n_useful, n_funny, n_cool, n_fans, avg_stars) #id(PK) or name(PK) are depend on designer. name when you need to reflect the name of reviewer. ID if you want to identifier as numerical and syntetic, shorter than 'string or tuble'. In certain Table, you can have one and ONLY one PK
review((business, reviewer, r_date)PK, stars, n_useful, n_funny, n_cool) #a person can review once a day #we dont need id(PK) because this table, review, will not be related to any other table, this is a single review.



-- A reviewer is characterized by:
--- name
--- date of registration in Yelp
--- number of submitted reviews
---  number of reviews that are considered as useful/funny/cool by other users
--- number of fans/followers
---  average number of stars provided in the submitted reviews
_________
--A reviewer can be friend with other reviewers
------ friend is a self-relationship over reviewers 
# friend (symetric relation. So if asymatric relation, how will we do? See last minute of video on 20th Aplril)
friend((reviewer_a, reviewer_b)PK)
-----------
Revierer_1 | Revierer_2
Revierer_1 | Revierer_3
Revierer_1 | Revierer_4 #duplicate
Revierer_2 | Revierer_3
Revierer_3 | Revierer_4
Revierer_4 | Revierer_1 #we need to detect and avoid this situation manually by writing a function (code)
-- please, extract the friends of Reviewer_1
extraction 1: get the records where reviewer_a = 'Revierer_1'
UNION
extraction 2: get the records where reviewer_b = 'Revierer_1'




INSERT: Reviewer_4 | Reviewer_1 - skip the insertion
------------------
-- Biz and address
------------------

business
id		| Name 	| address 	| cat 1				| cat 2
--------------
	1	| IBM     | 2		| software
	2	| APPLE   | 1		| computer science  | software 
	3	| ZALANDO | 2		| dressing			

address
id		| street		| postal_code | neighborhood | city	
---------------------------------------------------------------
1		| Appleroad	  		234566			Pasadina	1 		
2		| 1st street	    777777			Bronx		2 	

-------------------
-- City and country
-------------------
id		| city 	| country
-----------------
1		| LA 		| USA
2		| NY		| USA
3		| Miami		| USA
4		| Rome		| Italy
5		| Venice 	| USA
6		| Venice 	| Italy


-- reference (relationship between different tables)
references across tables (FOREIGN KEY):
business.address -> address.id
address.city -> city.id

## thay viet:
alternative solutions:
business.id as PK #more synthetic, more compact, with only one number we can call the infomation // easy to use
(business.name, business.address) as PK # this sol is unconformtable because we might not syntetic, not compact


