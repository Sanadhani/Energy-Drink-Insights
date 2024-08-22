SELECT * FROM cities;
SELECT * FROM respondents;
SELECT * FROM survey_response;

-- Who prefers energy drink more (male/female/non-binary)?

SELECT c.gender, SUM(cnt) as Total
FROM(SELECT a.gender, b.consume_frequency, COUNT(Consume_frequency) AS cnt
FROM respondents as a
INNER JOIN survey_response as b
ON a.Respondent_ID=b.Respondent_ID
GROUP BY gender, Consume_frequency) as c
GROUP BY gender
ORDER BY Total DESC
LIMIT 1; 

-- Which age group prefers energy drinks more? 

SELECT c.age, SUM(cnt) as Total 
FROM(SELECT a.age, b.consume_frequency, COUNT(Consume_frequency) AS cnt
FROM respondents as a
INNER JOIN survey_response as b
ON a.Respondent_ID=b.Respondent_ID
GROUP BY age, Consume_frequency) as c
GROUP BY age
ORDER BY Total DESC
LIMIT 1;

-- Which type of marketing reaches the most Youth (15-30)?

SELECT c.marketing_channels, SUM(cnt) as total
FROM(SELECT a.age, b.marketing_channels, COUNT(marketing_channels) as cnt
FROM respondents as a
INNER JOIN survey_response as b
ON a.Respondent_ID=b.Respondent_ID
WHERE age BETWEEN 15 AND 30
GROUP BY age, Marketing_channels) as c
GROUP BY Marketing_channels
ORDER BY total DESC
LIMIT 1;

-- What are the preferred ingredients of energy drinks among respondents? 

SELECT ingredients_expected, COUNT(ingredients_expected) as cnt
FROM survey_response
GROUP BY Ingredients_expected
ORDER BY cnt DESC;

-- What packaging preferences do respondents have for energy drinks?

SELECT Packaging_preference, COUNT(Packaging_preference) as cnt
FROM survey_response
GROUP BY Packaging_preference
ORDER BY cnt DESC;

-- Who are the current market leaders?

SELECT Current_brands, COUNT(Current_brands) as cnt
FROM survey_response
GROUP BY Current_brands
ORDER BY cnt DESC; 

-- What are the primary reasons consumers prefer those brands over ours?

SELECT Current_brands, Reasons_for_choosing_brands, COUNT(Reasons_for_choosing_brands) as cnt
FROM survey_response
WHERE Current_brands NOT IN ("Others","Sky 9")
GROUP BY Current_brands, Reasons_for_choosing_brands
ORDER BY Current_brands, cnt DESC;

-- Which marketing channel can be used to reach more customers? 

SELECT marketing_channels, COUNT(marketing_channels) as cnt
FROM survey_response
GROUP BY marketing_channels
ORDER BY cnt DESC ;

-- How effective are different marketing strategies and channels in reaching our customers? 

SELECT a.age, b.marketing_channels, COUNT(marketing_channels) as cnt
FROM respondents as a
INNER JOIN survey_response as b
ON a.Respondent_ID=b.Respondent_ID
GROUP BY age, Marketing_channels
ORDER BY age, cnt DESC;

-- What do people think about our brand (overall rating)?

SELECT Brand_perception, COUNT(Brand_perception) as cnt
FROM survey_response
GROUP BY Brand_perception
ORDER BY cnt DESC;

SELECT Taste_experience, COUNT(Taste_experience) as cnt
FROM survey_response
GROUP BY Taste_experience
ORDER BY cnt DESC;

-- Which cities do we need to focus more on? 

SELECT a.City, COUNT(City) as cnt 
FROM cities as a
INNER JOIN respondents as b
ON a.City_ID=b.City_ID
GROUP BY City
ORDER BY cnt DESC;

-- Where do respondents prefer to purchase energy drinks? 

SELECT purchase_location, COUNT(Purchase_location) AS cnt
FROM survey_response
GROUP BY purchase_location
ORDER BY cnt DESC;

-- What are the typical consumption situations for energy drinks among respondents? 

SELECT Typical_consumption_situations, COUNT(Typical_consumption_situations) AS cnt
FROM survey_response
GROUP BY Typical_consumption_situations
ORDER BY cnt DESC;

-- What factors influence respondents' purchase decisions, such as price range and limited edition packaging? 

SELECT Price_range, COUNT(Price_range) AS cnt
FROM survey_response
GROUP BY Price_range
ORDER BY cnt DESC;

SELECT Limited_edition_packaging, COUNT(Limited_edition_packaging) AS cnt
FROM survey_response
GROUP BY Limited_edition_packaging
ORDER BY cnt DESC;

-- Which area of business should we focus more on our product development (Branding/taste/availability)? 

SELECT Current_brands, Reasons_for_choosing_brands, COUNT(Reasons_for_choosing_brands) as cnt
FROM survey_response
WHERE Current_brands IN ("Codex")
GROUP BY Current_brands, Reasons_for_choosing_brands
ORDER BY Current_brands, cnt DESC;

SELECT Reasons_preventing_trying, COUNT(Reasons_preventing_trying) as cnt
FROM survey_response 
GROUP BY Reasons_preventing_trying
ORDER BY cnt DESC;

SELECT c.city, d.Purchase_location, COUNT(Purchase_location) as cnt
FROM (SELECT a.City_ID, a.City, b.Respondent_ID
FROM cities as a
INNER JOIN respondents as b
ON a.City_ID=b.City_ID) as c
INNER JOIN survey_response as d
ON c.Respondent_ID=d.Respondent_ID
GROUP BY city, Purchase_location
ORDER BY city, cnt DESC;
