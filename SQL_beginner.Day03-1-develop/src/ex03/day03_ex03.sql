WITH female_table (pizzeria_id, count_female) AS (
    SELECT pizzeria.id AS pizzeria_id,
        COUNT (person.gender) AS count_female
    FROM person
        JOIN person_visits ON person.id = person_visits.person_id
        JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
    GROUP BY pizzeria.id,
        person.gender
    HAVING person.gender = 'female'
),
male_table (pizzeria_id, count_male) AS (
    SELECT pizzeria.id AS pizzeria_id,
        COUNT (person.gender) AS count_male
    FROM person
        JOIN person_visits ON person.id = person_visits.person_id
        JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
    GROUP BY pizzeria.id,
        person.gender
    HAVING person.gender = 'male'
)
SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
    JOIN female_table ON female_table.pizzeria_id = pizzeria.id
    JOIN male_table ON male_table.pizzeria_id = pizzeria.id
WHERE female_table.count_female <> male_table.count_male
ORDER BY pizzeria_name