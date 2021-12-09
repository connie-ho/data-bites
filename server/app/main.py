from flask import Flask
from flask_mysqldb import MySQL
 
app = Flask(__name__)

app.config['MYSQL_HOST'] = 'root'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'data-bites'

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
 
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')