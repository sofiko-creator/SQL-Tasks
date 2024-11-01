insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');
WITH cte AS (
    SELECT COALESCE("user".name, 'not defined') AS name,
        COALESCE("user".lastname, 'not defined') AS lastname,
        COALESCE(
            (
                SELECT currency_tmp.name
                FROM currency AS currency_tmp
                WHERE currency_tmp.id = balance.currency_id
                    AND currency_tmp.updated = (
                        SELECT MAX(currency.updated)
                        FROM currency
                        WHERE currency.updated < balance.updated
                            AND currency.id = currency_tmp.id
                    )
            ),
            (
                SELECT currency_tmp.name
                FROM currency AS currency_tmp
                WHERE currency_tmp.id = balance.currency_id
                    AND currency_tmp.updated = (
                        SELECT MIN(currency.updated)
                        FROM currency
                        WHERE currency.updated >= balance.updated
                            AND currency.id = currency_tmp.id
                    )
            )
        ) AS currency_name,
        COALESCE(
            (
                (
                    SELECT currency_tmp.rate_to_usd
                    FROM currency AS currency_tmp
                    WHERE currency_tmp.id = balance.currency_id
                        AND currency_tmp.updated = (
                            SELECT MAX(updated)
                            FROM currency
                            WHERE currency.updated < balance.updated
                                AND currency.id = currency_tmp.id
                        )
                        AND currency_tmp.id = balance.currency_id
                )
            ),
            (
                (
                    SELECT currency_tmp.rate_to_usd
                    FROM currency AS currency_tmp
                    WHERE currency_tmp.id = balance.currency_id
                        AND currency_tmp.updated = (
                            SELECT MIN(updated)
                            FROM currency
                            WHERE currency.updated >= balance.updated
                                AND currency.id = currency_tmp.id
                        )
                        AND currency_tmp.id = balance.currency_id
                )
            )
        ) * sum(balance.money) AS currency_in_usd
    FROM "user"
        RIGHT JOIN balance ON "user".id = balance.user_id
    GROUP BY "user".id,
        balance.updated,
        balance.currency_id
    ORDER BY COALESCE("user".name, 'not defined') desc,
        COALESCE("user".lastname, 'not defined'),
        currency_name
)
SELECT *
FROM cte
WHERE currency_name IS NOT NULL

-- delete from currency where updated in ('2022-01-08 13:29', '2022-01-01 13:29')