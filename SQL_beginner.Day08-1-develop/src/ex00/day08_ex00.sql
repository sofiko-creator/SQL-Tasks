--session1
-- start transaction 
BEGIN;
-- update data
update pizzeria
set rating = 5
where name = 'Pizza Hut';
-- check update (rating = 5)
select *
from pizzeria
where name = 'Pizza Hut';
-- publish change
commit;
--session2
-- start transaction 
BEGIN;
--before commit
--rating = 4.6
select *
from pizzeria
where name = 'Pizza Hut';
--after commit
--rating = 5
select *
from pizzeria
where name = 'Pizza Hut';