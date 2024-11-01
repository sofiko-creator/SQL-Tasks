SELECT person.name
FROM person
    JOIN person_order ON person.id = person_order.person_id
    JOIN menu ON menu.id = person_order.menu_id
WHERE (menu.pizza_name = 'pepperoni pizza')
    AND (person.gender = 'female')
    AND (
        person.name IN (
            SELECT person.name
            FROM person
                JOIN person_order ON person.id = person_order.person_id
                JOIN menu ON menu.id = person_order.menu_id
            WHERE menu.pizza_name = 'cheese pizza'
        )
    )
ORDER BY person.name