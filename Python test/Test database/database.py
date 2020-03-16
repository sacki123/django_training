import sqlite3
with open('oracle.sql', encoding='utf-8_sig') as db:
    reader = db.read()
    for row in reader:
        print(row)
