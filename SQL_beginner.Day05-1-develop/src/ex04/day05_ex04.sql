CREATE UNIQUE INDEX idx_menu_unique ON menu (pizzeria_id, pizza_name);
set Enable_seqscan = off;
EXPLAIN ANALYSE (
    SELECT DISTINCT person_order.order_date
    FROM person_order
        JOIN menu ON menu.id = person_order.menu_id
    WHERE pizzeria_id = 2
        AND pizza_name = 'sicilian pizza'
)