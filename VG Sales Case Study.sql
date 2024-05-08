-- Situation: The client looking to make a new best selling video game. We need to know which platform to launch it on, what Genre will sell the best, and which market to focus advertising on.-- 

-- Starting by viewing the data--
SELECT
	*
From
	vgsales
;
-- Lets see how many games are sold on each platform--

SELECT
	Platform,
    COUNT(NAME) AS Number_of_Games
From
	vgsales
Group By
	Platform
ORDER BY
	Number_of_Games DESC
    ;
    
-- DS has the highest number of games made from this data. Followed by PS2 and PS3--
-- Lets see how games made compares to games sold since the newest generation of platforms have come out in 2013--

SELECT
	Platform,
    COUNT(NAME) AS Number_of_Games,
    SUM(global_sales) AS Games_Sold
From
	vgsales
WHERE
	Year >= 2013
Group By
	Platform
ORDER BY
	Games_Sold DESC
    ;
    
-- PS4 has the most sales by nearly double any other new system--
-- Lets make sure that isnt due to 1 or 2 games--

SELECT
	Name,
	Platform,
    Global_sales,
    NA_Sales,
    EU_Sales,
    JP_Sales
From
	vgsales
WHERE
    Platform = "PS4"
ORDER BY
	Global_Sales DESC
	;
-- Confirmed that there was not any games that made up a majority of sales that were not also released on other platforms--
-- Lets look at how the top selling games performed between the systems--

SELECT
	Name,
	Platform,
    Global_sales,
    NA_Sales,
    EU_Sales,
    JP_Sales
From
	vgsales
WHERE
    (Platform = "XOne" OR Platform = "PS4")
    AND (Name LIKE "Grand%" Or Name LIKE "Call%" OR Name LIKE "FIFA%")
Order By
	Name
	;

-- The Data shows that PS4 out preforms the XOne on all of the highest selling games--
-- Q1 Recommendation: The best Platform to launch the game on will be PS4-- 
-- Q2: Which Genre of game sells the best--
SELECT
	Genre,
    COUNT(NAME) AS Number_of_Games,
    SUM(global_sales) AS Games_Sold
From
	vgsales
WHERE
	Year >= 2013
Group By
	Genre
ORDER BY
	Games_Sold DESC
    ;
-- Action and Shooter games have the highest number of games sold since 2013. Sports and Role Playing are the next 2.--
-- Action has nearly 4 times as many games made as the other genres--
SELECT
	Genre,
    COUNT(NAME) AS Number_of_Games,
    SUM(global_sales) AS Games_Sold,
    ((SUM(global_sales)*1000000) / COUNT(NAME)) AS Sales_Per_Game
From
	vgsales
WHERE
	Year >= 2013
Group By
	Genre
ORDER BY
	Sales_Per_Game DESC
    ;
-- When we adjust sales for the amount of games made, we find that the shooter games sell the best.--
-- Q2 Recommendation: Shooter or Action games would be the best genres to make when looking at sales--

-- Q3: What global market should we advertise to according to past sales--
-- We can look at total sales numbers from each market--

SELECT
	Genre,
    Sum(NA_Sales),
    SUM(EU_sales),
    SUM(JP_sales),
    SUM(other_sales),
    SUM(global_sales)
From
	vgsales
WHERE
	Year >= 2013
    AND (Genre = "Shooter" OR Genre = "Action")
Group BY
	Genre
    ;

SELECT
	Genre,
    Sum(NA_Sales),
    SUM(EU_sales),
    SUM(JP_sales),
    SUM(other_sales),
    SUM(global_sales)
From
	vgsales
WHERE
	Year >= 2013
Group BY
	Genre
    ;

--Q3 Recommendation: Advertising and sales should be concentrated in North America and the EU for most of the genres. Japan and other areas of the world make up a small amount of sales by comparision.--