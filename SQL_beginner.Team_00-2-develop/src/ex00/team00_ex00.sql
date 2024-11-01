CREATE TABLE Paths (
  id SERIAL PRIMARY KEY,
  point1 VARCHAR, 
  point2 VARCHAR, 
  cost INTEGER
);

INSERT INTO Paths VALUES
(1, 'a','b', 10),
(2, 'b', 'a', 10),
(3, 'a', 'd', 20),
(4, 'd', 'a', 20),
(5, 'c', 'a', 15),
(6, 'a', 'c', 15),
(7, 'b', 'c', 35),
(8, 'c', 'b', 35),
(9, 'b', 'd', 25),
(10, 'd', 'b', 25),
(11, 'd', 'c', 30),
(12, 'c', 'd', 30);

CREATE TABLE Vers (
  id SERIAL PRIMARY KEY,
	v VARCHAR
);

INSERT INTO Vers(v) VALUES
('a'),
('b'),
('c'),
('d');

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

SELECT * FROM TSP_A
WHERE 
	total_cost = (SELECT MIN(total_cost) FROM TSP_A)

-- DROP TABLE Paths, Vers

-- WITH all_cost AS (
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
-- FROM all_cost 
-- WHERE total_cost = (SELECT MIN(total_cost) FROM all_cost);