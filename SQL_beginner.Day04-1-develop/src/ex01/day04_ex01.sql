SELECT v_persons_female.name AS name
FROM v_persons_female
UNION
SELECT v_persons_male.name AS name
FROM v_persons_male
ORDER BY name