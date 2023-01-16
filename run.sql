-- FUNCTION

CREATE OR REPLACE FUNCTION count_words_in_body(poem_name_in text) RETURNS int AS
$$
	DECLARE
		res integer;
	BEGIN
		SELECT ARRAY_LENGTH(string_to_array(body, ' '), 1) INTO res
		FROM poems
		WHERE poems.poem_name=poem_name_in;
		RETURN res;
	END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM count_words_in_body('The Phoenix and the Turtle')


-- PROCEDURE

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


-- TRIGGER

CREATE TABLE logs
(
  "name_action" text,
  "time_action" timestamp without time zone,
  "user_name" text
);


CREATE OR REPLACE FUNCTION logging_action() RETURNS trigger AS
$$
DECLARE
    ms varchar(256);
	BEGIN
	     INSERT INTO logs(name_action, time_action, user_name) VALUES (TG_OP, CURRENT_DATE, CURRENT_USER);
		 RETURN NULL;
	END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER logging
AFTER INSERT OR UPDATE OR DELETE ON authors
FOR EACH ROW
EXECUTE PROCEDURE logging_action();

INSERT INTO authors (author_name) VALUES ('LINA KOSTENKO');
SELECT * FROM logs;