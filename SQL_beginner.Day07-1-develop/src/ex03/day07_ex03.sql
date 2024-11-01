SELECT task1.name,
    coalesce(task1.count, 0) + coalesce(task2.count, 0) AS total_count
FROM (
        (
            SELECT pizzeria.name,
                count(person_id) AS count
            FROM pizzeria
                JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
            GROUP BY pizzeria.name
            ORDER BY count desc
        ) AS task1
        FULL JOIN (
            SELECT pizzeria.name,
                count(person_id) AS count
            FROM pizzeria
                JOIN menu ON pizzeria.id = menu.pizzeria_id
                JOIN person_order ON menu.id = person_order.menu_id
            GROUP BY pizzeria.name
            ORDER BY count desc
        ) AS task2 ON task1.name = task2.name
    )
ORDER BY total_count desc,
    name