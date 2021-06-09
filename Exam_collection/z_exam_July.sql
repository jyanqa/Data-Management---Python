Person (id serial PK, 
		name VARCHAR (50) not null
		nationality varchar(3));

Concert (id serial PK, 
	singer integer  REFERENCES singer (code), 
	nation char (3));

Singer( code integer PK, 
	references PERSON (id), popularity singer,
 		Foreign key (code) References person (id) on update cascade on delete cascade);
 
Audience (concert integer REFERENCES concert(id),
 			person integer REFERENCES  person (id),
			primary key (concert, person),
			foreign key (concert) REFERENCES concert (id) on delete cascade,
			foreign key (person) REFERENCES person (id) on update cascade );

## 1. Which error?bum (
A. update audience set concert = 10 where concert = 3;
		(concert.id = 10 exist in concert)
B. update person SET id = 10 where id =9;
		(person.id = 10 not exist in the table concert)
C. Delete from concert WHERE id = 123
D. Delete from Audience where person =  9

## 2. Concert music -> choose ‘false’ option
A. A singer can belong to audience  of concert.
B. A concert can have only one singer.
C. A person can exist that is not a singer and she /he does not belong to any audience. 
D. A singer can sing in at most 1 concert per nation

## EX1.
Album(xxxx, length , singer)
- singer references code of a singer in table singer of DB music
- a singer can not have 2 album xxx the same time
- length is number of album .xx. cannot be NULL
- length always > 0
- when code of a singer is update, album singer is updated automaticly
- Its not possible to delete singer when he/she has album

-- Giai: Tu lam ##
CREARE TABLE album (
title varchar,
length integer NOT NULL CHECK (length > 0),
singer  integer REFERENCES singer(code) ON UPDATE CASCADE ON DELETE NO ACTION,
PRIMARY KEY (title, singer)
);

## Ex2. Consider music table ### Tui tu lam, nen xem lai
1. Retrieve name of singer that played concert in his/her nation of origin
Select person.name
from singer inner join concert on singer.code = concert.singer inner join person on person.id = singer.code
where concer.nation = person.pertionality;
2. Retrieve no. of audiences for each concert
Select concert.id, count(*) as "number of audience for each concert"
from audience inner join concert on audience.concert = concert.id
group by concert.id
/* Ex3. Music collection*/
 { “_id” : 	object id (“sjsjsjs”),
		concert_id: 101,
		singer: {
				id:1001,
				name: 
				nationality
				population: 5
				},
		nation: ITA,
		audience : [ { 	id: 1002
						name:	
						nationality: },
					{	 id: 1003
						name:	
						nationality: } ] }

/*A. Retrieve concerts of singer with popularity between 3&5*/
##xemlai nhee-------------- moit u lam 10/11
db.musiccollection.find({
		"$and" : [
			{ "population":{$gte: 3},
			{"population": {$lte: 5}
		]},
	{
	 "_id": 0,
	 "singer": 1,
	 "population": 1
	});
/*B. Retrieve overal number of Italian attendees for all concerts of Italian singers. */
db.musiccollection.aggregate([
		{"$unwind": "$audience"}, {"$unwind": "$singer"}
		{"$match": "$and": [
							{"singer.nationality": "ITA", },
							{"audience.nationality": "ITA"}]
		},
		{"$group": {"_id" = "$singer", "numberof Italian attendees": {"$sum": 1}}}
]); /*KIEM TRA LAI XEM DUNG KHONG*/


/*## Choose query that xxx no. of concert issued in ITA by Italian singers.*/
A. db.music.find ({ “$group”: {“_id”: {nation:ITS}}, “num_concert:{“$sum”:1}}
B. db.music.find (“singer.nationality”: ITS. nation: ‘ITA’, {‘_id:0’, num_concert:’$sum”})
C. db.music.aggregate ([{ 
“$project”: {“singer.nationality: ITA, nation:ITA}},
{“$group:{“_id”:{nation:ITA}, “num_concert”: {$sum”: 1}}} ])

D. db.music.aggregate ([  
{“$match”: {singer.nationality: ITA, nation: ITA }},
{ $group : {“_id”: {nation: “$nation”, “number of concert “: “ {$sum”:1}}}
  ])


-------------------------------
	--DETHI 15/9-------

Player(id, name, at p-points)

Match( player1, player2, c-name, c-country,c-year, result)
 	Foreign key: player
 	PK: all attributes

Competition (name, country, year)
	PK name/country/year

---mongodb---





















