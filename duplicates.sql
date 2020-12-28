--version: Redshift 1.0.21556
--input data: data/duplicates.csv

CREATE TABLE duplicates
(
    event_timestamp timestamp,
    event_date      date,
    order_id        int,
    client_id       int
)
;

-- fill in S3 filepath and credentials
COPY duplicates
    FROM 's3://.../duplicates.csv'
    CREDENTIALS 'aws_access_key_id=...;aws_secret_access_key=...'
    DELIMITER ','
    IGNOREHEADER 1
;

-- mark records with the same order_id as duplicate
-- non-duplicate record is the one with the earliest event_timestamp
SELECT *
     , RANK()
       OVER (PARTITION BY order_id ORDER BY event_timestamp) rank
FROM duplicates
ORDER BY order_id, event_timestamp
;

-- mark records with the same order_id and client_id as duplicate
-- non-duplicate record is the one with the earliest event_timestamp
SELECT *
     , RANK()
       OVER (PARTITION BY order_id, client_id ORDER BY event_timestamp) rank
FROM duplicates
ORDER BY order_id, event_timestamp
;

-- mark records with the same order_id as duplicate
-- non-duplicate record is the one with the latest event_timestamp
SELECT *
     , RANK()
       OVER (PARTITION BY order_id ORDER BY event_timestamp DESC) rank
FROM duplicates
ORDER BY order_id, event_timestamp
;

-- mark records with the same order_id and client_id as duplicate
-- non-duplicate record is the one with the latest event_timestamp
SELECT *
     , RANK()
       OVER (PARTITION BY order_id, client_id ORDER BY event_timestamp DESC) rank
FROM duplicates
ORDER BY order_id, event_timestamp
;

-- mark records with the same order_id and client_id as duplicate
-- non-duplicate record is a random one from records marked as duplicate
SELECT *
     , RANK()
       OVER (PARTITION BY order_id, client_id ORDER BY random()) rank
FROM duplicates
ORDER BY order_id, event_timestamp
;
