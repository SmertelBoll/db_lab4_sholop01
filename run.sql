-- ФУНКЦІЯ (знаходження кількості балів співаків однієї країни)

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
SELECT country_points('Greece')
SELECT artist_country, artist_points FROM artist



-- ПРОЦЕДУРА (додає нового артиста в таблицю)

DROP PROCEDURE add_new_artist

CREATE OR REPLACE PROCEDURE add_new_artist(art_name char(50), art_country char(50), art_points int, euro_id int)
LANGUAGE'plpgsql'
AS $$
   DECLARE 
      art_id artist.artist_id%type;
      art_date artist.artist_date%type := NULL;
   BEGIN
      SELECT (artist_id+1) INTO art_id FROM artist ORDER BY artist_id DESC LIMIT 1;
      INSERT INTO artist(artist_id, artist_name, artist_country, artist_points, eurovision_id)
      VALUES(art_id, art_name, art_country, art_points, euro_id);
   END;
$$

CALL add_new_artist('Sholop Lyubomyr', 'Ukraine', 500, 0)
SELECT * FROM artist


-- ТРІГЕР (додає час додавання артиста)

DROP TRIGGER IF EXISTS added_new_artist ON artist;
DROP FUNCTION IF EXISTS set_data;

CREATE FUNCTION set_data() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS
$$
   BEGIN 
      UPDATE Artist
      SET
		   artist_date = now()
      WHERE 
         artist.artist_id = NEW.artist_id;
      RETURN NULL;
   END;
$$;

CREATE TRIGGER added_new_artist
AFTER INSERT ON Artist
FOR EACH ROW EXECUTE FUNCTION set_data();


CALL add_new_artist('Sholop Nadia', 'Ukraine', 999, 0)
SELECT * FROM artist



