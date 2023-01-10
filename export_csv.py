import csv
import psycopg2

username = 'Danylo_Mizin'
password = '1234'
database = 'Second_lab_DB'
host = 'localhost'
port = '5432'

OUTPUT_FILE_T = 'Mizin_{}.csv'

TABLES = [
    'authors',
    'genres',
    'periods',
    'poems'
]

conn = psycopg2.connect(user=username, password=password, dbname=database)

with conn:
    cur = conn.cursor()

    for tablename in TABLES:
        cur.execute('SELECT * FROM ' + tablename)
        fields = [x[0] for x in cur.description]
        with open(OUTPUT_FILE_T.format(tablename), 'w') as outfile:
            writer = csv.writer(outfile)
            writer.writerow(fields)
            for row in cur:
                writer.writerow([str(x) for x in row])