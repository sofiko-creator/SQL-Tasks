UPDATE menu
SET price = (price - 0.1 * price)::int
WHERE menu.pizza_name = 'greek pizza'