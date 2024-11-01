SELECT person.address,
    round(
        MAX(person.age) - MIN(person.age) / MAX(person.age)::numeric,
        2
    ) AS formula,
    round(AVG(person.age), 2) AS average,
    'true' AS comparison
FROM person
GROUP BY person.address
HAVING round(
        MAX(person.age) - (MIN(person.age) / MAX(person.age)),
        2
    ) > round(AVG(person.age), 2)
UNION
(
    SELECT person.address,
        round(
            MAX(person.age) - MIN(person.age) / MAX(person.age)::numeric,
            2
        ) AS formula,
        round(AVG(person.age), 2) AS average,
        'false' AS comparison
    FROM person
    GROUP BY person.address
    HAVING round(
            MAX(person.age) - (MIN(person.age) / MAX(person.age)),
            2
        ) <= round(AVG(person.age), 2)
)
ORDER BY address