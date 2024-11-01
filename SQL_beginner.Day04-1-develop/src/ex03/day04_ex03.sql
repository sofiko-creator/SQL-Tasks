SELECT generated_date AS missing_date
FROM v_generated_dates
EXCEPT (
        SELECT DISTINCT generated_date AS missing_date
        FROM v_generated_dates
            JOIN person_visits ON (visit_date = generated_date)
    )
ORDER BY missing_date