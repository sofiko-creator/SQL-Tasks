-- to remove 3 old triggers from the person table;
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;

-- to remove 3 old trigger functions;
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_update_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit;

-- to do a TRUNCATE (or DELETE) of all rows in our person_audit table.
DELETE FROM person_audit;

CREATE OR REPLACE FUNCTION fnc_trg_person_audit() RETURNS trigger AS $$
	BEGIN
		IF (TG_OP = 'DELETE') THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
    		VALUES (default, 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
    		VALUES (default, 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
    		VALUES (default, default, NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
        END IF;
    	RETURN NEW;
	END;
$$ LANGUAGE plpgsql;
								   
CREATE OR REPLACE TRIGGER trg_person_audit
	AFTER INSERT OR UPDATE OR DELETE
	ON person
	FOR EACH ROW
	EXECUTE FUNCTION fnc_trg_person_audit();
	
INSERT INTO person(id, name, age, gender, address)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
--SELECT * FROM person_audit;
--SELECT * FROM person;


