CREATE INDEX idx_person_order_multi ON person_order(person_id, menu_id);
set Enable_seqscan = off;
EXPLAIN ANALYZE(
    SELECT person_id,
        menu_id,
        order_date
    FROM person_order
    WHERE person_id = 8
        AND menu_id = 19
);
EXPLAIN ANALYZE(
    SELECT person_id,
        menu_id,
        person.name,
        menu.pizza_name
    FROM person_order
        JOIN person ON person.id = person_order.person_id
        JOIN menu ON menu.id = person_order.menu_id
    WHERE person_id = 8
        AND menu_id = 8
);