SELECT author_name, COUNT(poem_name)
FROM poems
INNER JOIN authors ON poems.author_id = authors.author_id
GROUP BY author_name;

SELECT period_name, COUNT(poem_name)
FROM poems
INNER JOIN periods ON poems.genre_id = periods.period_id
GROUP BY period_name;

SELECT genre_name, COUNT(poem_name)
FROM poems
INNER JOIN genres ON poems.genre_id = genres.genre_id
GROUP BY genre_name;