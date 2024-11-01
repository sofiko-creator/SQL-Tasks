INSERT INTO person_discounts
SELECT ROW_NUMBER() OVER () AS id,
    person_id,
    pizzeria_id,
    CASE
        WHEN amount_of_orders = 1 THEN 10.5
        WHEN amount_of_orders = 2 THEN 22
        ELSE 30
    END
FROM (
        SELECT person_order.person_id,
            pizzeria.id AS pizzeria_id,
            COUNT(person_order.id) AS amount_of_orders
        FROM person_order
            JOIN menu ON menu.id = person_order.menu_id
            JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
        GROUP BY person_id,
            pizzeria.id
    )