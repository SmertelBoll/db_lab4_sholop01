-- Додає нового артиста в таблицю
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