import csv
import MySQLdb
from dotenv import load_dotenv
import os

load_dotenv()

mydb = MySQLdb.connect(
    host=os.getenv('MYSQL_HOST'),
    user=os.getenv('MYSQL_USER'),
    passwd=os.getenv('MYSQL_PASSWORD'),
    db=os.getenv('MYSQL_DB'),
    autocommit=True
    )

cursor = mydb.cursor()

print("Dropping Users Table...")
cursor.execute('DROP TABLE IF EXISTS Users')
print("Creating Users Table...")
cursor.execute('CREATE TABLE Users(name varchar(20), email varchar(20))')
cursor.close()
print("Done")

# csv example
# csv_data = csv.reader(file('students.csv'))
# for row in csv_data:

#     cursor.execute('INSERT INTO testcsv(names, \
#           classes, mark )' \
#           'VALUES("%s", "%s", "%s")', 
#           row)
#close the connection to the database.