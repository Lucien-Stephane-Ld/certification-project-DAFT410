CREATE DATABASE cocktails_db;

use cocktails_db;

/**---------------------------------------------------------------------------------------------------------------------**/
/** Setting primary and foreign keys **/

ALTER TABLE cocktails_id
add primary key (cocktail_id);


ALTER TABLE ingredients_id
ADD PRIMARY KEY (ingredient_id);


ALTER TABLE cocktails_ingredients_ids
ADD CONSTRAINT fk_cocktail
FOREIGN KEY (cocktail_id)
REFERENCES cocktails_id (cocktail_id),
ADD CONSTRAINT fk_ingredient
FOREIGN KEY (ingredient_id)
REFERENCES ingredients_id (ingredient_id);


ALTER TABLE cocktail_nutrient
ADD CONSTRAINT fk_cocktail_ingredient
FOREIGN KEY (cocktail_id)
REFERENCES cocktails_id (cocktail_id);


/**---------------------------------------------------------------------------------------------------------------------**/
/** Select the top 20 most calorific cocktails **/

SELECT * FROM cocktail_nutrient WHERE amount IS NOT NULL;

SELECT name, nutrient, amount
FROM cocktail_nutrient
WHERE nutrient = 'Calories'
ORDER BY CAST(REPLACE(amount, 'kcal', '') AS DECIMAL) DESC
LIMIT 20;

/**---------------------------------------------------------------------------------------------------------------------**/
/** Select the top 20 healthiest cocktails **/


CREATE TABLE IF NOT EXISTS healthiest_cocktail (
	cocktail_id INT,
    name VARCHAR(50),
    sugar VARCHAR(50),
    calories VARCHAR(50)
);

INSERT INTO healthiest_cocktail (cocktail_id, name, sugar, calories)
SELECT cn1.cocktail_id, cn1.name, cn1.amount, cn2.amount
FROM (
	SELECT name, cocktail_id , amount
	FROM cocktail_nutrient
	WHERE nutrient = 'Sugar'
	ORDER BY CAST(REPLACE(amount, 'g', '') AS DECIMAL) ASC
	LIMIT 100
) cn1
JOIN (
	SELECT cocktail_id, name, amount
	FROM cocktail_nutrient
	WHERE nutrient = 'Calories'
	ORDER BY CAST(REPLACE(amount, 'kcal', '') AS DECIMAL) ASC
	LIMIT 100
) cn2
ON cn1.name = cn2.name;

SELECT * FROM healthiest_cocktail
LIMIT 20;

SELECT * FROM cocktails_id;

/**---------------------------------------------------------------------------------------------------------------------**/
/** Return which ingredients are the most popular **/

SELECT ingredients FROM ingredients_id;

SELECT 'Vodka' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Vodka%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Ale' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Ale%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Coffee' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Coffee%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Brandy' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Brandy%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Vermouth' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Vermouth%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Beer' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Beer%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Lemon' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Lemon%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Lime' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Lime%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Syrup' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Syrup%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Whisky' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Whisky%" OR ingredients LIKE "%Whiskey%" THEN 1 END)AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Schnapps' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Schnapps%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Orange' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Orange%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Apple' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Apple%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Wine' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Wine%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Juice' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Juice%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Gin' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Gin%" OR ingredients LIKE "%gin%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Soda' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Soda%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Tequila' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Tequila%" OR ingredients LIKE "%tequila%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Cider' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Cider%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Port' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Port%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Liqueur' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Liqueur%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Rum' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Rum%" THEN 1 END) AS occurrence
FROM ingredients_id
UNION ALL
SELECT 'Chocolate' AS ingredient, COUNT(CASE WHEN ingredients LIKE "%Chocolate%" or "%chocolat%" THEN 1 END) AS occurrence
FROM ingredients_id
ORDER BY occurrence desc;


/**---------------------------------------------------------------------------------------------------------------------**/
/** Which the most recurring word in the cocktail names ? **/

SELECT cocktail_id, cocktail FROM cocktails_id;

SELECT DISTINCT cocktail FROM cocktails_id;