import os
from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL
from dotenv import load_dotenv
from datetime import datetime
from random import randint, choice
import string

from werkzeug.exceptions import default_exceptions, HTTPException, InternalServerError
from werkzeug.security import check_password_hash, generate_password_hash

load_dotenv()

app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Ensure responses aren't cached
@app.after_request
def after_request(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response

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
        first_name = userDetails['first_name'].lower()
        last_name = userDetails['last_name'].lower()

        if not (first_name and last_name):
            return 'Error, must fill out all fields'
        user_id = first_name[0] + last_name[:10] + str(datetime.today().year)
        
        remaining_length = 22 - len(user_id)
        for _ in range(remaining_length):
            user_id += str(randint(0,9))


        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO Users(user_id, name, yelping_since) VALUES(%s,%s,%s)",(user_id, first_name, str(datetime.today())))
        mysql.connection.commit()
        cursor.close() 
        return f"Account created userid: {user_id}"
    return render_template('create-account.html')

@app.route('/search', methods=["GET", "POST"])
def search():
    if request.method == "POST":
        name = request.form.get("name")
        categories = request.form.get("categories")
        location = request.form.get("location")
        city = ""
        state = ""

        if not (name or categories or location):
            return 'Error: at least one field must be filled'

        if location:
            location = location.split(",")
            city = location[0]
            if len(location) > 1:
                state = location[1]

        # execute query
        cursor = mysql.connection.cursor()
        query = """
            SELECT business_id, name, stars, review_count, categories FROM Businesses 
            LEFT JOIN Categories USING(business_id)
            WHERE """

        values = []
        where_count = 0

        if name:
            query += "name=%s "
            values.append(name)
            where_count += 1

        if city:
            if where_count:
                query += "AND "
            query += "city=%s " if where_count else "city=%s "
            values.append(city)
            where_count += 1

        if state:
            if where_count:
                query += "AND "
            query += "state=%s " if where_count else "state=%s "
            values.append(state)
            where_count += 1

        if categories:
            if where_count:
                query += "AND "
            query += "categories IN (%s) "
            values.append(categories)
            where_count += 1

        res = cursor.execute(query, values)
        if res > 0:
            data = cursor.fetchall()
            businesses = {}
            for row in data:
                businesses[row[0]] = {
                    'name': row[1],
                    'avg_stars': row[2],
                    'review_count': row[3]
                }

                if 'categories' in businesses[row[0]]:
                    businesses[row[0]]['categories'].append(row[4])
                else: 
                    businesses[row[0]]['categories'] = [row[4]]

            cursor.close()
            return render_template('search-results.html', businesses=businesses)
        else: 
            cursor.close()
            return 'No Results'

    return render_template('search.html')


@app.route('/<business_id>')
def business(business_id):
    cursor = mysql.connection.cursor()
    data = {}
    
    query = "SELECT name, stars, review_count, address, city, state, postal_code FROM Businesses WHERE business_id=%s"
    res = cursor.execute(query,[business_id])

    data["business_id"] = business_id

    if res > 0:
        columns = cursor.description
        details = [{columns[index][0]:column for index, column in enumerate(value)} for value in cursor.fetchall()][0]
        details['address'] = f"{details['address']}, {details['city']} {details['state']}, {details['postal_code']}"
        del details['city']
        del details['state']
        del details['postal_code']
        data['details'] = details

    query = "SELECT user_id, stars, text, date, useful, funny, cool FROM Reviews WHERE business_id=%s"
    res = cursor.execute(query,[business_id])
    if res > 0:
        columns = cursor.description
        reviews = [{columns[index][0]:column for index, column in enumerate(value)} for value in cursor.fetchall()]
        data['reviews'] = reviews

    # add on other attributes e.g. ambience once ready
    query = "SELECT attribute as attributes FROM Attributes WHERE business_id=%s"
    res = cursor.execute(query,[business_id])
    if res > 0:
        attributes = cursor.fetchall()
        data['attributes'] = attributes

    query = "SELECT categories FROM Categories WHERE business_id=%s"
    res = cursor.execute(query,[business_id])
    if res > 0:
        categories = cursor.fetchall()
        data['categories'] = categories

    cursor.close()
    return render_template('business.html', data=data)


@app.route('/<business_id>/review', methods=["GET", "POST"])
def review(business_id):
    if request.method == "POST":
        review = request.form
        user_id = review['user_id']
        stars = int(review['stars'])
        text = review['text']

        if not(user_id and stars and text):
            return "Error: all fields must be filled"

        review_id = ''.join(choice(string.ascii_uppercase + string.digits) for _ in range(22))

        # add the review
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO Reviews(business_id, user_id, review_id, stars, text, date) VALUES(%s,%s,%s,%s,%s, %s)",(business_id, user_id, review_id, stars, text, str(datetime.today())))
        mysql.connection.commit()
        # update the review and star count
        query = "SELECT review_count, stars FROM Businesses WHERE business_id=%s"
        cursor.execute(query, [business_id])

        business = cursor.fetchone()
        review_count = int(business[0])
        avg_stars = int(business[1])

        review_count += 1
        new_stars = round(((review_count - 1) * avg_stars + stars) / review_count)
        query = "UPDATE Businesses SET review_count=%s, stars=%s WHERE business_id=%s"
        cursor.execute(query,[review_count, new_stars, business_id])
        mysql.connection.commit()

        cursor.close() 
        return redirect(f'/{business_id}')

    return render_template('review.html', business_id=business_id)

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