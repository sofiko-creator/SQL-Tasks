CREATE INDEX idx_person_name ON person(upper(name));
set Enable_seqscan = off;
EXPLAIN ANALYZE(
    SELECT person.name,
        menu.pizza_name
    FROM person
        JOIN person_order ON person.id = person_order.person_id
        JOIN menu ON person_order.menu_Id = menu.id
    WHERE (upper(person.name) = 'ANNA')
);