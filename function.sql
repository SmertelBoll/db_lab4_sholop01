-- Знаходження кількості балів співаків однієї країни
DROP FUNCTION IF EXISTS country_points;

CREATE OR REPLACE FUNCTION country_points(name_country character(50))
RETURNS INTEGER
LANGUAGE 'plpgsql'

AS $$
   BEGIN
      RETURN (SELECT SUM(artist_points) 
              FROM Artist 
              WHERE artist_country = name_country );
   END;
$$

SELECT country_points('Ukraine')
SELECT * FROM artist
SELECT country_points('Greece')
