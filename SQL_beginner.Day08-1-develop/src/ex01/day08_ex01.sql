-- session 1
begin;
--start transaction
--result "read committed"
SHOW TRANSACTION ISOLATION LEVEL;
select *
from pizzeria
where name = 'Pizza Hut';
-- rating = 5
update pizzeria
set rating = 4
where name = 'Pizza Hut';
-- update rating
commit;
-- fix change
select *
from pizzeria
where name = 'Pizza Hut';
-- rating = 3.6
-- session 2
--start transaction
begin;
select *
from pizzeria
where name = 'Pizza Hut';
-- rating = 5
update pizzeria
set rating = 3.6
where name = 'Pizza Hut';
-- update rating
commit;
-- fix change
select *
from pizzeria
where name = 'Pizza Hut';
-- rating = 3.6