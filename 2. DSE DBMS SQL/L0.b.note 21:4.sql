21/04/2020
\2.Relationaldb slide
- A meaningless database instance
- Integrity constraints: chinh truc
  predicate: thuoc tinh
- all kind of key:
\Superkey: group of attributes provide unique identification 			= key + at least one attribute.
\Key: provide unique identification with minimum attributes
\Primarykey:nminimal attribute superkeys, work well even 				if there are null values, There is no none value??	

\Foreignkey: movie.id is a foreign key of crew.movie. 					min:36.54 VIOLATION of referential integrity
\Concurrency: multiuser system. es.  two users withdraw money at the same time. database of bank changes at the smae time. Enforce enherently.
-- atomic: nguyên tử
\ACID: Atomic, consistent, isolation, durability: apply thì không trở lại được như cũ
\Transaction_outcome: commit and Rollback: neu transaction ko thuc hien duoc thi no tro ve trang thai truoc khi hanh dong dc execute.