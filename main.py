import psycopg2

username = 'Danylo_Mizin'
password = '1234'
database = 'Second_lab_DB'
host = 'localhost'
port = '5432'


query_1 = '''
SELECT period_name, COUNT(poem_name)
FROM poems
INNER JOIN periods ON poems.genre_id = periods.period_id
GROUP BY period_name
'''
query_2 = '''
SELECT author_name, COUNT(poem_name)
FROM poems
INNER JOIN authors ON poems.author_id = authors.author_id
GROUP BY author_name
'''

query_3 = '''
SELECT genre_name, COUNT(poem_name)
FROM poems
INNER JOIN genres ON poems.genre_id = genres.genre_id
GROUP BY genre_name
'''

conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)
with conn:
    cur = conn.cursor()

    print('Query 1:')
    cur.execute(query_1)
    for row in cur:
        print(row)

    print('\nQuery 2:')
    cur.execute(query_2)
    for row in cur:
        print(row)

    print('\nQuery 3:')
    cur.execute(query_3)
    for row in cur:
        print(row)