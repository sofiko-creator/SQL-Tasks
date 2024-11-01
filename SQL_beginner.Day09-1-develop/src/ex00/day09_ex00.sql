CREATE TABLE person_audit
(
  created timestamp with time zone default CURRENT_TIMESTAMP not null,
  type_event char(1) default 'I' not null,
  row_id bigint not null,
  name varchar,
  age integer,
  gender varchar,
  address varchar
);

ALTER TABLE person_audit 
ADD CONSTRAINT ch_type_event CHECK(type_event in ('I','U','D'));

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit() RETURNS trigger AS $$
	BEGIN
		-- Вставка строки в person_audit, копируя значения из вставляемой строки
		INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
    	VALUES (default, default, NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
    	-- Возвращаем новую строку для завершения операции вставки
    	RETURN NEW;
	END;
$$ LANGUAGE plpgsql;
								   
CREATE OR REPLACE TRIGGER trg_person_insert_audit 
	AFTER INSERT 
	ON person
	FOR EACH ROW
	EXECUTE FUNCTION  fnc_trg_person_insert_audit();
	
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');
--SELECT * FROM person_audit;
--SELECT * FROM person;
--DELETE FROM person WHERE id = 10;
