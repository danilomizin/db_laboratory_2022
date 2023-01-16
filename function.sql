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