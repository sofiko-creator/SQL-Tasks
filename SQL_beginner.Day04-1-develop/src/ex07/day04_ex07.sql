INSERT INTO person_visits(id, person_id, pizzeria_id, visit_date)
VALUES (
        (
            SELECT MAX(person_visits.id) + 1
            FROM person_visits
        ),
        (
            SELECT id
            FROM person
            WHERE name = 'Dmitriy'
        ),
        (
            SELECT MIN(menu.pizzeria_id)
            FROM menu
                JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
            WHERE (pizzeria.name <> 'Papa Johns')
                AND menu.price < 800
        ),
        '2022-01-08'
    );
refresh materialized view mv_dmitriy_visits_and_eats;