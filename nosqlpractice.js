db.business.find(
{
	"city": "Las Vegas",
	"country": "Nv"
}).pretty();

db.business.find(
{
	"city":"LV",
	"country": "Nv",
	"stars": {"$gt": 4}
},
{
	"_id": 0,
	"name": 1,
	"city": 1,
	"country": 1,
	"stars":1
})


db.business.find ({
	"name": /.*pizza*./i
},
{
	"name": 1,
	"_id": 0,
	"city": 1,
	"country": 1
});


/* retrieve name, city, country of businesses that are rated between 1 and 2 */
db.business.find({
	"$and": [
		{"stars": {"$gte": 1}},
		{"stars": {"$lte":2}}
	]
},
{	"_id": 0,
	"name":1,
	"city":1,
	"country": 1,
	"stars":1
})
/* retrieve name, city, country of businesses placed in Nevada (NV) or Arizona (AZ) that are rated between 1 and 2 */


db.business.find({
	"stars": {"$gte":1, "$lte":2},
	"$or": [
		{ "country": "NV"},
		{"country": "AZ"}
	]
},
{
	"_id": 0,
	"name": 1,
	"city": 1,
	"country": 1,
	"stars": 1

});

/* retrieve the name of businesses that have been reviewed on Nov 1st 2013 and sort the result by name */

db.business.find({
	"review.review_date": new Date("2013-11-01")
},
{
	"_id": 0,
	"name"
}).sort({"name": 1});

/* retrieve the name of businesses that have been reviewed with 5 stars on Nov 1st 2013 and sort the result by name in descending order */
db.business.find({
	"$and": [
		{'review.review_date': new Date("2013-11-01")},
		{"review.review_score": 5}
	]
};
{	"name":1,
"_id": 0

}.sort({"name": -1});
/* retrieve the businesses that are categorized as "Restaurants" */
/* as a further exercise, retrieve the businesses that are NOT categorized as "Restaurants" */

db.business.find({
	"category": {"$in": ["Restaurants"]}
},
{
	"_id": 0,
	"name":1,
	"category": 1
}).sort({"name": 1}).pretty();

db.business.find({
	"category": {"$nin": ["Restaurants"]}
},
{
	"_id": 0,
	"name": 1,
	"category": 1
}).sort({"name": 1});

/* retrieve the businesses that have not received any review */

db.business.find(
{
	"review": {"$exists": false}
}).pretty();


/* retrieve the number of businesses in Nevada */
db.business.find({
	"country": "NV"
}).count();

db.business.aggregate([
	{"$match": {"country": "NV"}},
	{"$group": {"_id": "$country", "business": {"$sum": 1}}}

]);


/* retrieve the number of businesses for each country */

db.business.aggregate(
	[
		{"$group": {"_id": {"country": "$country"}, "number of biz": {"$sum": 1}}},
		{"$sort": {"_id":1}}
	]);

/* retrieve the average number of stars for businesses of each country */
db.business.aggregate(
	[
		{"$group": {"_id": {"country": "$country"}, "average of stars": {"$avg": "$stars"}}},
		{"$sort": {"_id": 1}}
	]);
db.business.aggregate([
		{"$group": { "_id": {"country": "$country"}, "average": {"$avg": "$stars"} },
		{"$sort": {"_id": 1}}
	]);

/* retrieve the number of reviews for each business in Nevada */
db.business.aggregate([
		{"$match": {"country": "NV"}},
		{"$project": {"_id": 0, "country": 1, "name": 1, "number of reviews" : {"$size": "$reviews"}}}
	]);
/* retrieve the average number of businesses per country */
db.business.aggregate([
	{"$group": {"_id":{"country": "$country"}, "nobiz": {"$sum": 1}}},
	{"$project": {"_id": 1, "avaergae biz": {"$avg": "$nobiz"}}}

]);

/* retrieve the businesses that have been reviewed in Nov 2013 */
/* this is a correct solution */

db.business.aggregate([
		{"$unwind": "$review"},
		{"$match": { "$and": [
			{"reviews.review_date" : {"$gte": new Date("2013-11-01")}},
			{"reviews.review_date": {"$lte": new Date("2013-11-30")}}
		]

		}},
		{"$project": {"_id": 0, "name": 1, "reviews.review_date": 1}},
		{"$sort": {"_id": 1}}
]);

/* retrieve the average number of stars of each business according to the received reviews */
db.business.aggregate([
		{ "$unwind": "$reviews"},
		{ "$group": {"_id":"$_id", "name": "$name"}, "averagestars": {"$avg": "$reviews.review_score"}}
]);

/* retrieve the number of reviews provided by any reviewer */
db.business.aggregate([
		{"$unwind": "$reviews"},
		{"$group": {"_id": "$reviewers.reviewer_id", "num of reviews": {"$sum":1}}}
	]);

/* retrieve the reviewers that provided more than 10 reviews */
db.business.aggregate([
		{"$unwind": "$reviews"},
		{"$group": {"_id": "$reviews.reviewer_id", "number of reviews": {"$sum": 1}}},
		{"$match": {"number of reviews": {"$gt": 10}}}
]);

/* retrieve the whole number of reviews provided in 2013 */
db.business.aggregate([
		{"$unwind": "$reviews"},
		{"$project": {"$year": "$reviews.review_date"}},
		{"$match": {"year": 2013}},
		{"$group": {"_id": "$year", "whole number of reviews": {"$sum": 1}}}
]);
	
/* retrieve the whole number of reviews year by year */



db.business.aggregate([
	{"$unwind": "$reviews"},
	{"$project": {"$year": "$reviews.review_date"}},
	{"$group": {"_id": "$year", "norevieweach year": {"$sum": 1}}},
	{"$sort": {"_id": 1}}
]);
























