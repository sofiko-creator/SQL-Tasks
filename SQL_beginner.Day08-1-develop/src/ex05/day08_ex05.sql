-- session 1
begin; -- start transaction READ COMMITTED
-- before commit session 2
select sum(rating) from pizzeria; -- sum(rating) = 21.9
-- after commit session 2
select sum(rating) from pizzeria; -- sum(rating) = 19.9
commit; -- fix change
select sum(rating) from pizzeria; -- sum(rating) = 19.9

-- session 2
begin; -- start transaction READ COMMITTED
update pizzeria set rating = 1 where name = 'Pizza Hut'; -- update data
commit; -- fix change
select sum(rating) from pizzeria; -- sum(rating) = 19.9