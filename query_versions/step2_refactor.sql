ALTER TABLE car_table 
--   ADD INDEX idx_make_year  (Make, Year);
  ADD INDEX idx_year_msrp  (Year, MSRP);

DROP INDEX idx_year_msrp ON car_table;
DROP INDEX idx_make_year ON car_table;

Explain
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
WHERE Year BETWEEN 2010 AND 2015
  AND MSRP IS NOT NULL
ORDER BY Make, Model;
