SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
    JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
    JOIN person ON person.id = person_visits.person_id
WHERE (person.name = 'Andrey')
EXCEPT (
        SELECT pizzeria.name AS pizzeria_name
        FROM person
            JOIN person_order ON person.id = person_order.person_id
            JOIN menu ON menu.id = person_order.menu_id
            JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
        WHERE (person.name = 'Andrey')
    )
ORDER BY pizzeria_name