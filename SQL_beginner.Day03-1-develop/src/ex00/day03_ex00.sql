SELECT menu.pizza_name,
    menu.price,
    pizzeria.name AS pizzeria_name,
    person_visits.visit_date
FROM menu
    JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
    JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
    JOIN person ON person.id = person_visits.person_id
WHERE (person.name = 'Kate')
    AND (
        menu.price BETWEEN 800 AND 1000
    )
ORDER BY menu.pizza_name,
    menu.price,
    pizzeria_name