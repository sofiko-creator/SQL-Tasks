-- session 1
-- start transaction READ COMMITTED
SHOW TRANSACTION ISOLATION LEVEL;
begin;
-- session 2
-- start transaction READ COMMITTED
SHOW TRANSACTION ISOLATION LEVEL;
begin;
-- session 1
-- update data
update pizzeria
set rating = 2.2
where id = 1;
-- session 2
-- update data
update pizzeria
set rating = 1.4
where id = 2;
-- session 1
-- update data 
update pizzeria
set rating = 4.2
where id = 2;
-- session 2
-- update data with ERROR!
update pizzeria
set rating = 4.0
where id = 1;
-- session 1
-- result: COMMIT
commit;
-- session 2 
-- result: ROLLBACK
commit;