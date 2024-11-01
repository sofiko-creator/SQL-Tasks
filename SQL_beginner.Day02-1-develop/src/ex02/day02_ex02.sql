WITH table_cte(visit_date) AS (
    SELECT '2022-01-01'::date + i AS visit_date
    FROM generate_series(0, 2) AS i
)
SELECT COALESCE(person.name, '-') AS person_name,
    table_cte.visit_date,
    COALESCE(pizzeria.name, '-') AS pizzeria_name
FROM table_cte
    LEFT JOIN person_visits ON person_visits.visit_date = table_cte.visit_date
    FULL JOIN person ON person_visits.person_id = person.id
    FULL JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
ORDER BY person_name,
    visit_date,
    pizzeria_name