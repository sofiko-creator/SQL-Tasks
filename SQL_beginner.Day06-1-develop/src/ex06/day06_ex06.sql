CREATE SEQUENCE seq_person_discounts START WITH 1;
SELECT setval(
        'seq_person_discounts',
        (
            SELECT COALESCE(MAX(id), 0)
            FROM person_discounts
        ) + 1,
        true
    );
ALTER TABLE person_discounts
ALTER COLUMN id
SET DEFAULT nextval('seq_person_discounts');