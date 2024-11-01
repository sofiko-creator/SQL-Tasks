CREATE VIEW v_symmetric_union AS
SELECT person_id
FROM person
    JOIN person_visits ON person.id = person_visits.person_id
WHERE person_visits.visit_date = '2022-01-02'
EXCEPT (
        SELECT person_id
        FROM person
            JOIN person_visits ON person.id = person_visits.person_id
        WHERE person_visits.visit_date = '2022-01-06'
    )
UNION
(
    SELECT person_id
    FROM person
        JOIN person_visits ON person.id = person_visits.person_id
    WHERE person_visits.visit_date = '2022-01-06'
    EXCEPT (
            SELECT person_id
            FROM person
                JOIN person_visits ON person.id = person_visits.person_id
            WHERE person_visits.visit_date = '2022-01-02'
        )
)
ORDER BY person_id