-- session 1
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- start transaction SERIALIZABLE
-- before commit session 2
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.6
-- after commit session 2
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.6
commit; -- fix change
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.0

-- session 2
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- start transaction SERIALIZABLE
update pizzeria set rating=3.0 where name='Pizza Hut'; -- update data 
commit; -- fix change
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.0