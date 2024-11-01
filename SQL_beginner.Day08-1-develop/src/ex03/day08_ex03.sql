-- session 1
begin; -- start transaction
SHOW TRANSACTION ISOLATION LEVEL; -- result "read committed"
-- before commit session2 
select * from pizzeria where name = 'Pizza Hut'; -- rating = 4
-- after commit session2 
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.6
commit;
select * from pizzeria where name = 'Pizza Hut'; -- rating = 3.6

-- session 2
begin; -- start transaction
SHOW TRANSACTION ISOLATION LEVEL; -- result "read committed"
update pizzeria set rating=3.6 where name='Pizza Hut'; -- update rating
commit; -- fix change
select * from pizzeria where name = 'Pizza Hut';  -- rating = 3.6 