CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop integer default 10)
RETURNS TABLE (value_fibonacci integer) AS $$
DECLARE 
	temp_a integer := 0;
	temp_b integer := 1;
	temp_sum integer := 1;
BEGIN
     IF (pstop IS NULL) THEN
	 	RETURN;
	 END IF;
	 
	 IF (pstop < 1) THEN
	 	RETURN;
	 END IF;
	 
	 IF (pstop >= 1) THEN
	 	value_fibonacci = 0;
	 	RETURN NEXT;
	 END IF;
	 
	 IF (pstop > 1) THEN
	 	value_fibonacci = temp_sum;
	 	RETURN NEXT;
	 	value_fibonacci = temp_sum;
	 	RETURN NEXT;
	 END IF;
	 
	 WHILE temp_sum < pstop LOOP
	 	temp_a := temp_b;
		temp_b := temp_sum;
	    temp_sum := temp_a + temp_b;
		value_fibonacci = temp_sum;
		IF value_fibonacci < pstop THEN
			RETURN NEXT;
		END IF;
	 END LOOP;
END;
$$ LANGUAGE plpgsql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();
select * from fnc_fibonacci(1);
select * from fnc_fibonacci(-100);
select * from fnc_fibonacci(NULL);
select * from fnc_fibonacci(0);
select * from fnc_fibonacci(20);