explain
-- ANALYZE
SELECT
    ct.Make,
    ct.Model,
    ct.Year,
    ct.MSRP,
    ct.Popularity,
    (
        SELECT AVG(inner_ct.MSRP)
        FROM car_table AS inner_ct
        WHERE inner_ct.Make = ct.Make
          AND inner_ct.Year = ct.Year
    ) AS AvgMSRPPerMakeYear,
    (
        SELECT COUNT(*)
        FROM car_table AS rank_ct
        WHERE rank_ct.Year = ct.Year
          AND rank_ct.MSRP > ct.MSRP
    ) + 1 AS RankByMSRPWithinYear
FROM car_table AS ct
WHERE ct.Year BETWEEN 2015 AND 2020
  AND ct.MSRP IS NOT NULL
ORDER BY ct.Make, ct.Model;
