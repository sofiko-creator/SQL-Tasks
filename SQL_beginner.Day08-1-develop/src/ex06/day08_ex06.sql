-- session 1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- start transaction REPEATABLE READ
-- before commit session 2
select sum(rating) from pizzeria; -- sum(rating) = 19.9
-- after commit session 2
select sum(rating) from pizzeria; -- sum(rating) = 19.9
commit; -- fix change
select sum(rating) from pizzeria; -- sum(rating) = 23.9

-- session 2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- start transaction REPEATABLE READ
update pizzeria set rating = 5 where name = 'Pizza Hut'; -- update data
commit; -- fix change
select sum(rating) from pizzeria; -- sum(rating) = 23.9