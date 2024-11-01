CREATE OR REPLACE FUNCTION 
fnc_person_visits_and_eats_on_date(pperson varchar default 'Dmitriy', 
								   pprice numeric default 500, pdate date default '2022-01-08')
RETURNS TABLE (pizzeria_name varchar) AS $$
BEGIN
    RETURN QUERY SELECT DISTINCT pizzeria.name AS pizzeria_name FROM person
	JOIN person_order ON person.id = person_order.person_id
	JOIN menu ON menu.id = person_order.menu_id
	JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
	JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
	WHERE person.name = pperson AND menu.price < pprice AND person_order.order_date = pdate; 
END;
$$ LANGUAGE plpgsql;

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Denis', pprice := 1000);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');

