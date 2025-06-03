explain
-- ANALYZE
WITH CTE AS (
    select *,
        AVG(MSRP) OVER (PARTITION BY Make, year) AS AvgMSRPPerMakeYear,
        RANK() OVER (PARTITION BY Year ORDER BY MSRP DESC) AS RankByMSRPWithinYear
    FROM car_table
)
SELECT
    Make,
    Model,
    Year,
    MSRP,
    Popularity,
    AvgMSRPPerMakeYear,
    RankByMSRPWithinYear
FROM CTE
WHERE Year BETWEEN 2015 AND 2020
  AND MSRP IS NOT NULL
ORDER BY Make, Model;
