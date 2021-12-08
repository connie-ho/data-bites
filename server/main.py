from flask import Flask
from flask_mysqldb import MySQL
 
app = Flask(__name__)

mysql = MySQL(app)
 
@app.route('/')
def index():
    return 'Hello'
 
# example database call
# @app.route('/login', methods = ['POST', 'GET'])
# def login():
#     if request.method == 'GET':
#         return "Login via the login Form"
     
#     if request.method == 'POST':
#         name = request.form['name']
#         age = request.form['age']
#         cursor = mysql.connection.cursor()
#         cursor.execute(''' INSERT INTO info_table VALUES(%s,%s)''',(name,age))
#         mysql.connection.commit()
#         cursor.close()
#         return f"Done!!"
 
app.run(host='localhost', port=5000)