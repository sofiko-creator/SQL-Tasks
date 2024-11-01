WITH RECURSIVE tours AS(
	SELECT 
		'a'::text AS curr,
		'a' AS path,
		0 AS cost
		
	UNION
	
	SELECT
		v::text AS curr,
		CONCAT(path, ',', v)::text AS path,
	    cost + (
			SELECT cost FROM Paths WHERE point1 = curr AND point2 = v
		)
	FROM tours CROSS JOIN Vers
	WHERE POSITION(v IN path) = 0
), TSP_A AS(
	SELECT
		 cost + (
			 SELECT cost FROM Paths WHERE point1 = RIGHT(path, 1) AND point2 = 'a'
		 ) AS total_cost,
		CONCAT('{', path, ',', 'a', '}') AS tour
	FROM tours
	WHERE 
		LENGTH(path) = (SELECT MAX(LENGTH(path)) FROM tours)
	ORDER BY total_cost, tour
)

-- SELECT * FROM tours

SELECT * FROM TSP_A
WHERE 
	total_cost = (SELECT MIN(total_cost) FROM TSP_A)
	OR
	total_cost = (SELECT MAX(total_cost) FROM TSP_A);

-- DROP TABLE Paths, Vers

-- WITH min_max_cost AS (
-- 	select t1.cost + t2.cost + t3.cost + t4.cost AS total_cost, 
-- 				CONCAT('{', t1.point1, ',', t2.point1, ',', t3.point1, ',', t4.point1, '}') as tour
-- 	from ABCD as t1
-- 	join ABCD as t2 on  t1.point2 = t2.point1
-- 	join ABCD as t3 on  t2.point2 = t3.point1
-- 	join ABCD as t4 on  t3.point2 = t4.point1
-- 	WHERE t1.point1 = 'a' and t4.point2 = 'a'
-- 	and (t1.point1 != t2.point1 and t1.point1 != t3.point1 and t1.point1 != t4.point1)
-- 	and (t2.point1 != t1.point1 and t2.point1 != t3.point1 and t2.point1 != t4.point1)
-- 	and (t3.point1 != t1.point1 and t3.point1 != t2.point1 and t3.point1 != t4.point1)
-- 	order by total_cost
-- )
-- SELECT total_cost, tour 
-- FROM min_max_cost 
-- WHERE total_cost = (SELECT MIN(total_cost) FROM min_max_cost)
-- OR
-- total_cost = (SELECT MAX(total_cost) FROM min_max_cost);