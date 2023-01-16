CREATE OR REPLACE PROCEDURE poems_by_author(author_name_in text)
LANGUAGE plpgsql AS
$$
	DECLARE
		poem_rec record;
	BEGIN
		FOR poem_rec IN
			SELECT poems.poem_name
			FROM poems
			INNER JOIN authors ON authors.author_id = poems.author_id
			WHERE authors.author_name=author_name_in
		LOOP
			RAISE INFO 'Name_author: % Name: %', author_name_in, poem_rec.poem_name;
		END LOOP;
	END;
$$;

CALL poems_by_author('WILLIAM SHAKESPEARE');