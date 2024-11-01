WITH clear_currency AS (
	SELECT * FROM currency AS tmp_cur
	WHERE updated = (
		SELECT MAX(updated) FROM currency WHERE id = tmp_cur.id
	)
)

SELECT 
	COALESCE(outer_user.name, 'not defined') AS name,
	COALESCE(lastname, 'not defined') AS lastname,
	type,
	SUM(money) AS volume,
	COALESCE(
		clear_currency.name, 'not defined') AS currency_name,
	COALESCE(clear_currency.rate_to_usd, 1) AS last_rate_to_usd,
	SUM(money) * COALESCE(clear_currency.rate_to_usd, 1) AS total_volume_in_usd
FROM "user" AS outer_user
FULL JOIN balance ON balance.user_id = outer_user.id
LEFT JOIN clear_currency ON clear_currency.id = balance.currency_id
GROUP BY outer_user.id, balance.type, clear_currency.name, last_rate_to_usd
ORDER BY COALESCE(outer_user.name, 'not defined') DESC, lastname, type