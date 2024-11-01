-- session 1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- start transaction REPEATABLE READ
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.6
update pizzeria set rating=4 where name='Pizza Hut'; -- update rating
commit; -- fix change
select * from pizzeria where name = 'Pizza Hut'; -- rating = 4

-- session 2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- start transaction REPEATABLE READ
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.6
update pizzeria set rating=3.6 where name='Pizza Hut'; -- update rating with error
commit; 
select * from pizzeria where name = 'Pizza Hut'; -- rating = 4