CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr numeric[])
RETURNS numeric AS $$
DECLARE 
	min_value numeric;
	i numeric;
BEGIN
     IF (arr IS NULL) THEN
	 	RETURN NULL;
	 END IF;
	 min_value := arr[1];
	 FOREACH i IN ARRAY arr LOOP
	 	IF (i < min_value) THEN
			min_value := i;
		END IF;
	 END LOOP;
	 RETURN min_value; 
END;
$$ LANGUAGE plpgsql;
 
SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
SELECT func_minimum(VARIADIC arr => ARRAY[10.0, 1.0, 5.0, 4.4]);
SELECT func_minimum(VARIADIC arr => ARRAY[-10.0, -1.0, -5.0, -4.4]);
SELECT func_minimum(-15.0, -100.0, -5.0, -4.4);
SELECT func_minimum(NULL);
SELECT func_minimum(VARIADIC arr => NULL);
SELECT func_minimum(VARIADIC arr => ARRAY[]::numeric[]);