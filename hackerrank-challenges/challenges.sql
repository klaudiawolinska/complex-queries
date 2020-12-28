--version: Oracle

/*
problem description: https://www.hackerrank.com/challenges/challenges/problem
*/

WITH cte AS (
    SELECT
        h.hacker_id
      , h.name
      , count(c.challenge_id)                              AS challenges_created
      , count(*) OVER (PARTITION BY count(c.challenge_id)) AS window_count
    FROM hackers h
             INNER JOIN challenges c
                        ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, name
)
SELECT
    hacker_id
  , name
  , challenges_created
FROM cte
WHERE (challenges_created = (SELECT
                                 max(challenges_created)
                             FROM cte) OR window_count = 1)
ORDER BY challenges_created DESC, hacker_id
;