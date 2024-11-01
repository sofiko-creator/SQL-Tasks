CREATE INDEX idx_person_order_order_date ON person_order(person_id, menu_id)
WHERE order_date = '2022-01-01';
set Enable_seqscan = off;
EXPLAIN ANALYZE(
    SELECT menu.price
    FROM menu
        JOIN person_order ON menu.id = person_order.menu_id
    WHERE person_order.person_id = 1
        AND person_order.menu_id = 2
        AND order_date = '2022-01-01'
)