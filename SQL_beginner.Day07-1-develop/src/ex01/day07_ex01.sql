SELECT person.name,
    count(person_visits.person_id) AS count_of_visits
FROM person_visits
    JOIN person ON person.id = person_visits.person_id
GROUP BY person.name
ORDER BY count_of_visits desc,
    person.name
LIMIT 4;