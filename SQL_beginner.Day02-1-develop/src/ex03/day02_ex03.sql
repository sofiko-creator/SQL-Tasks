WITH table_cte(missing_date) AS (
    SELECT '2022-01-01'::date + i AS missing_date
    FROM generate_series(0, 9) AS i
)
SELECT missing_date
FROM table_cte
    LEFT JOIN person_visits ON (
        person_visits.visit_date = table_cte.missing_date
    )
    AND (
        person_visits.person_id = 1
        OR person_visits.person_id = 2
    )
WHERE (person_visits.visit_date IS NULL)
ORDER BY missing_date