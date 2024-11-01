DROP FUNCTION fnc_persons_male(), fnc_persons_female();

CREATE OR REPLACE FUNCTION fnc_persons(pgender varchar default 'female') 
RETURNS TABLE(id bigint, name varchar, age integer, gender varchar, address varchar) AS $$
	SELECT * FROM person WHERE gender = pgender;
$$ LANGUAGE sql;

select *
from fnc_persons(pgender := 'male');
 
select *
from fnc_persons();
