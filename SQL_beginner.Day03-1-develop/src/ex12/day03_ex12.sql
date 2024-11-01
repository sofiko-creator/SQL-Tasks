INSERT INTO person_order(id, person_id, menu_id, order_date)
SELECT (
        i + (
            SELECT MAX(person_order.id)
            FROM person_order
        )
    ) AS id,
    i AS person_id,
    menu.id,
    '2022-02-25'
FROM generate_series(
        1,
        (
            SELECT COUNT(person.id)
            FROM person
        )
    ) AS i
    JOIN menu ON menu.id = (
        SELECT menu.id
        FROM menu
        WHERE menu.pizza_name = 'greek pizza'
    )