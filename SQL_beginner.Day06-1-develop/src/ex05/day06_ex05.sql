COMMENT ON TABLE person_discounts IS 'Данная таблица содержит информацию о заказах людей в соответствующих пиццериях';
COMMENT ON COLUMN person_discounts.id IS 'Данный атрибут содержит уникальный идентификатор для каждой записи таблицы';
COMMENT ON COLUMN person_discounts.person_id IS 'Данный атрибут содержит информацию о людях, которые имеют скидку';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Данный атрибут содержит информацию о пиццериях, у которых действуют скидки';
COMMENT ON COLUMN person_discounts.discount IS 'Данный атрибут содержит информацию о скидках(значения которых от 0% до 100%)';