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