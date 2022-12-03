--version: Oracle
--problem description: https://www.hackerrank.com/challenges/harry-potter-and-wands/problem

WITH cte AS (
    SELECT
        id
      , age
      , coins_needed
      , power
      , row_number() OVER (PARTITION BY age, power ORDER BY coins_needed) AS rn
    FROM wands w
             INNER JOIN wands_property wp
                        ON w.code = wp.code
    WHERE is_evil = 0)
SELECT
    id
  , age
  , coins_needed
  , power
FROM cte
WHERE rn = 1
ORDER BY power DESC, age DESC
;
