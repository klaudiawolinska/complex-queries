--version: Oracle

/*
input data: data/triangles.sql
*/

SELECT
CASE
  WHEN (A + B <= C) or (A + C <= B) or (B + C <= A) THEN 'Not A Triangle'
  WHEN A = B and A = C and B = C THEN 'Equilateral'
  WHEN (A = B and A != C) or (A = C and A != B) or (B = C and B != A) THEN 'Isosceles'
  ELSE 'Scalene'
END
FROM triangles;
