import os
from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL
from dotenv import load_dotenv

from werkzeug.exceptions import default_exceptions, HTTPException, InternalServerError
from werkzeug.security import check_password_hash, generate_password_hash

load_dotenv()

app = Flask(__name__)
# Configure db
app.config['MYSQL_HOST'] = os.getenv('MYSQL_HOST')
app.config['MYSQL_USER'] = os.getenv('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = os.getenv('MYSQL_DB')

mysql = MySQL(app)

@app.route('/', methods=['GET', 'POST'])
def index():
    return render_template('index.html')

@app.route('/create-account', methods=['GET', 'POST'])
def create_account():
    if request.method == 'POST':
        # Fetch form data
        userDetails = request.form
        name = userDetails['name']
        email = userDetails['email']
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO users(name, email) VALUES(%s, %s)",(name, email))
        mysql.connection.commit()
        cursor.close()
        return redirect('/users')
    return render_template('index.html')

@app.route('/search', methods=["GET", "POST"])
def search():
    if request.method == "POST":
        name = request.form.get("name")
        categories = request.form.get("categories")
        location = request.form.get("location")
        city = ""
        state = "" 
        print(location)
        if location:
            location_arr = location.split(", ")
            city = location_arr[0]
            if len(location_arr) > 1:
                state = location_arr[1]

        # TODO: CLEANUP CATEGORIES
        if not (name or categories or city or state):
            return 'Error'

        # execute query
        cursor = mysql.connection.cursor()
        # create a view for stars and review count
        query = """
        SELECT business_id, name, AVG(reviews.stars), count(review_id) FROM Business
            LEFT JOIN Reviews USING(business_id) """

        if categories and len(categories):
            query += "LEFT JOIN Categories USING(business_id) "

        query += "WHERE "
        values = []

        where_count = 0

        if name:
            query += "name=%s "
            values.append(name)
            where_count += 1

        if city:
            query += "AND city=%s " if where_count else "city=%s "
            values.append(city)
            where_count += 1

        if state:
            query += "AND state=%s " if where_count else "state=%s "
            values.append(state)
            where_count += 1

        # TODO: categories

        query += "GROUP BY business_id"

        res = cursor.execute(query, values)
        if res > 0:
            businesses = cursor.fetchall()
            print(businesses)
            return render_template('businesses.html', businesses=businesses)
        else: 
            return 'No Results'

    return render_template('search.html')


@app.route('/{business_id}')
def business_id():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT * FROM users")
    if resultValue > 0:
        userDetails = cur.fetchall()
        return render_template('users.html',userDetails=userDetails)

def errorhandler(e):
    """Handle error"""
    if not isinstance(e, HTTPException):
        e = InternalServerError()
    return 'Error'

# Listen for errors
for code in default_exceptions:
    app.errorhandler(code)(errorhandler)

if __name__ == '__main__':
    app.run(debug=True)