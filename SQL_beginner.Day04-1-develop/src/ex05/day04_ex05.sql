CREATE VIEW v_price_with_discount AS
SELECT person.name,
    menu.pizza_name,
    menu.price,
    (menu.price - 0.1 * menu.price)::integer AS discount_price
FROM person
    JOIN person_order ON person.id = person_order.person_id
    JOIN menu ON menu.id = person_order.menu_id
ORDER BY person.name,
    menu.pizza_name