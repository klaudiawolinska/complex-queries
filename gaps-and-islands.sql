--version: Redshift 1.0.21556

/*
input data: data/users.sql
use case: https://etlgirl.github.io/gaps-and-islands/ 
*/

CREATE TABLE users_report AS (
    WITH users_no_gaps AS (
        SELECT
            log_date
          , user_account_id
          , action_type
          , last_value(account_type IGNORE NULLS)
            OVER (PARTITION BY user_account_id ORDER BY log_date ROWS UNBOUNDED PRECEDING) AS account_type
          , last_value(user_level IGNORE NULLS)
            OVER (PARTITION BY user_account_id ORDER BY log_date ROWS UNBOUNDED PRECEDING) AS user_level
        FROM users)
    SELECT
        log_date                AS valid_from
      , CASE
            WHEN action_type != 'user account deleted' THEN
                nvl(lead(log_date, 1) OVER (PARTITION BY user_account_id ORDER BY log_date) - 1, '9999-12-31')
            -- surrogate date indicates no further changes in user attributes
            ELSE valid_from END AS valid_to
        -- if user is deleted the date of their deletion becomes their 'valid_to' date
      , user_account_id
      , action_type
      , account_type
      , user_level
    FROM users_no_gaps
    ORDER BY user_account_id, valid_from)
;
