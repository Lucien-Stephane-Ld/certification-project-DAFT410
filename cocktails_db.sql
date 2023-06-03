CREATE DATABASE cocktails_db;

use cocktails_db;

----------------------------------------------------

/** Setting primary and foreign keys **/

alter table cocktails_id
add primary key (cocktail_id);


alter table ingredients_id
add primary key (ingredient_id);


alter table cocktails_ingredients_ids
add constraint fk_cocktail
foreign key (cocktail_id)
references cocktails_id (cocktail_id),
add constraint fk_ingredient
foreign key (ingredient_id)
references ingredients_id (ingredient_id);


alter table cocktail_nutrient
add constraint fk_cocktail_ingredient
foreign key (cocktail_id)
references cocktails_id (cocktail_id);


---------------------------------------------------

/** Select the top 20 most calorific cocktails **/

SELECT * FROM cocktail_nutrient WHERE amount IS NOT NULL;

SELECT name, nutrient, amount
FROM cocktail_nutrient
WHERE nutrient = 'Calories'
ORDER BY CAST(REPLACE(amount, 'kcal', '') AS DECIMAL) DESC
LIMIT 20;


/** Select the top 20 healthiest cocktails **/

SELECT name, cocktail_id FROM cocktail_nutrient
WHERE name='Bullfrog 2';

DROP TABLE healthiest_cocktail;

CREATE TABLE healthiest_cocktail (
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

select * from healthiest_cocktail
LIMIT 20;

select * from cocktails_id


/** Return which ingredients are the most popular **/

select ingredients from ingredients_id;

SELECT *
FROM (
    SELECT
    COUNT(CASE WHEN ingredients LIKE "%Vodka%" THEN 1 END) AS vodka_count,
    COUNT(CASE WHEN ingredients LIKE "%Ale%" THEN 1 END) AS ale_count,
    COUNT(CASE WHEN ingredients LIKE "%Coffee%" THEN 1 END) AS coffee_count,
    COUNT(CASE WHEN ingredients LIKE "%Brandy%" THEN 1 END) AS brandy_count,
    COUNT(CASE WHEN ingredients LIKE "%Vermouth%" THEN 1 END) AS vermouth_count,
    COUNT(CASE WHEN ingredients LIKE "%Beer%" THEN 1 END) AS beer_count,
    COUNT(CASE WHEN ingredients LIKE "%Lemon%" THEN 1 END) AS lemon_count,
    COUNT(CASE WHEN ingredients LIKE "%Lime%" THEN 1 END) AS lime_count,
    COUNT(CASE WHEN ingredients LIKE "%Syrup%" THEN 1 END) AS syrup_count,
    COUNT(CASE WHEN ingredients LIKE "%Whisky%" OR ingredients LIKE "%Whiskey%" THEN 1 END) AS whisky_count,
    COUNT(CASE WHEN ingredients LIKE "%Schnapps%" THEN 1 END) AS schnapps_count,
    COUNT(CASE WHEN ingredients LIKE "%Orange%" THEN 1 END) AS orange_count,
    COUNT(CASE WHEN ingredients LIKE "%Apple%" THEN 1 END) AS apple_count,
    COUNT(CASE WHEN ingredients LIKE "%Wine%" THEN 1 END) AS wine_count,
    COUNT(CASE WHEN ingredients LIKE "%Juice%" THEN 1 END) AS juice_count,
    COUNT(CASE WHEN ingredients LIKE "%Gin%" OR ingredients LIKE "%gin%" THEN 1 END) AS gin_count,
    COUNT(CASE WHEN ingredients LIKE "%Soda%" THEN 1 END) AS soda_count,
    COUNT(CASE WHEN ingredients LIKE "%Tequila%" OR ingredients LIKE "%tequila%" THEN 1 END) AS tequila_count,
    COUNT(CASE WHEN ingredients LIKE "%Cider%" THEN 1 END) AS cider_count,
    COUNT(CASE WHEN ingredients LIKE "%Port%" THEN 1 END) AS port_count,
    COUNT(CASE WHEN ingredients LIKE "%Liqueur%" THEN 1 END) AS liqueur_count,
    COUNT(CASE WHEN ingredients LIKE "%Rum%" THEN 1 END) AS rum_count
    FROM ingredients_id
) AS ingredient_counts
ORDER BY
    GREATEST(
        vodka_count,
        ale_count,
        coffee_count,
        brandy_count,
        vermouth_count,
        beer_count,
        lemon_count,
        lime_count,
        syrup_count,
        whisky_count,
        schnapps_count,
        orange_count,
        apple_count,
        wine_count,
        juice_count,
        gin_count,
        soda_count,
        tequila_count,
        cider_count,
        port_count,
        liqueur_count,
        rum_count
    ) DESC;


/** then join the result to the cocktail tables to answer how many cocktails have this or that ingredient **/

