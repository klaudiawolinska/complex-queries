--version: Oracle

/*
input data: data/occupations.sql
helpful tutorial: http://www.sqlsnippets.com/en/topic-12190.html
*/

SELECT   doctor, 
         professor, 
         singer, 
         actor
FROM     ( 
                  SELECT   occupation, 
                           ROW_NUMBER() OVER(partition BY occupation ORDER BY name) AS row_num, 
                           name 
                  FROM     occupations) PIVOT (min(name) FOR occupation IN ('Doctor'   AS doctor,
                                                                            'Professor' AS professor,
                                                                            'Singer'    AS singer,
                                                                            'Actor'     AS actor ) )
ORDER BY row_num;
