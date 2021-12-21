import os
from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL
from dotenv import load_dotenv

from datetime import datetime
from random import randint, choice
import string

from werkzeug.exceptions import default_exceptions, HTTPException, InternalServerError

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

@app.route('/user/<user_id>', methods=['GET', 'POST'])
def user(user_id):
    if request.method == "POST":
        friend_id = user_id
        user_id = request.form['user_id']
        
        try:
            cursor = mysql.connection.cursor()
            cursor.execute("INSERT INTO User_Friends(user_id, friend_id) VALUES(%s,%s)",(user_id, friend_id))
            mysql.connection.commit()
            cursor.close()
            return redirect(f"/user/{friend_id}")
        except:
            return 'Error adding friend'
    query = """
    SELECT Users.*, COUNT(distinct friend_id) as friends, COUNT(distinct useful) as useful, COUNT(distinct funny) as funny, COUNT(distinct cool) as cool
    FROM Users LEFT JOIN Reviews USING(user_id) LEFT JOIN User_Friends USING(user_id)
    WHERE user_id=%s
    """
    cursor = mysql.connection.cursor()
    cursor.execute(query,[user_id])
    columns = cursor.description
    user = [{columns[index][0]:column for index, column in enumerate(value)} for value in cursor.fetchall()][0]
    del user['user_id']
    if user: 
        return render_template('user.html', user=user)
    else: 
        return 'Error retrieving user details'

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

        try:
            cursor = mysql.connection.cursor()
            cursor.execute("INSERT INTO Users(user_id, name, yelping_since) VALUES(%s,%s,%s)",(user_id, first_name, str(datetime.today())))
            mysql.connection.commit()
            cursor.close() 
            return redirect(f"/user/{user_id}")
        except:
            return "Error creating account"
    return render_template('create-account.html')

@app.route('/search', methods=["GET", "POST"])
def search():
    cursor = mysql.connection.cursor()
    if request.method == "POST":
        name = request.form.get("name")
        categories = request.form.get("categories")
        location = request.form.get("location")
        stars = request.form.get("stars")
        city = ""
        state = ""

        if not (name or categories or location or stars):
            return 'Error: at least one field must be filled'

        if location:
            location = location.split(",")
            city = location[0]
            if len(location) > 1:
                state = location[1]

        # execute query
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
            query += "city=%s "
            values.append(city)
            where_count += 1

        if state:
            if where_count:
                query += "AND "
            query += "state=%s "
            values.append(state)
            where_count += 1

        if categories:
            if where_count:
                query += "AND "
            query += "categories IN (%s) "
            values.append(categories)
            where_count += 1

        if stars:
            if where_count:
                query += "AND "
            query += "stars >=%s "
            values.append(int(stars))
            where_count += 1

        try:
            cursor = mysql.connection.cursor()
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
                        if row[4] is None:
                            businesses[row[0]]['categories'] = []
                        else: 
                            businesses[row[0]]['categories'] = [row[4]]

                cursor.close()
                return render_template('search-results.html', businesses=businesses)
            else: 
                cursor.close()
                return 'No Results'
        except:
            return "Error during search"

    query = "SELECT distinct categories FROM Categories;"
    cursor.execute(query)
    categories = cursor.fetchall()

    return render_template('search.html', categories=categories)


@app.route('/<business_id>')
def business(business_id):
    try: 
        cursor = mysql.connection.cursor()
        data = {}
        
        query = """
        SELECT name, stars, review_count as 'review count', address, city, state, postal_code, COUNT(date) as checkins, Business_Hours.*
        FROM Businesses LEFT JOIN Checkins USING (business_id) LEFT JOIN Business_Hours USING(business_id)
        WHERE business_id=%s GROUP BY business_id"""
        res = cursor.execute(query,[business_id])

        data["business_id"] = business_id

        if res > 0:
            columns = cursor.description
            details = [{columns[index][0]:column for index, column in enumerate(value)} for value in cursor.fetchall()][0]
            details['address'] = f"{details['address']}, {details['city']} {details['state']}, {details['postal_code']}"
            details['hours'] = {}
            details['hours']['Monday'] = f"{details['Monday_Open']} - {details['Monday_Close']}" if details ['Monday_Open'] else 'Closed'
            details['hours']['Tuesday'] = f"{details['Tuesday_Open']} - {details['Tuesday_Close']}" if details ['Tuesday_Open'] else 'Closed'
            details['hours']['Wednesday'] = f"{details['Wednesday_Open']} - {details['Wednesday_Close']}" if details ['Wednesday_Open'] else 'Closed'
            details['hours']['Thursday'] = f"{details['Thursday_Open']} - {details['Thursday_Close']}" if details ['Thursday_Open'] else 'Closed'
            details['hours']['Friday'] = f"{details['Friday_Open']} - {details['Friday_Close']}" if details ['Friday_Open'] else 'Closed'
            details['hours']['Saturday'] = f"{details['Saturday_Open']} - {details['Saturday_Close']}" if details ['Saturday_Open'] else 'Closed'
            details['hours']['Sunday'] = f"{details['Sunday_Open']} - {details['Saturday_Close']}" if details ['Saturday_Open'] else 'Closed'
            del details['city']
            del details['state']
            del details['postal_code']
            del details['Monday_Open']
            del details['Tuesday_Open']
            del details['Wednesday_Open']
            del details['Thursday_Open']
            del details['Friday_Open']
            del details['Saturday_Open']
            del details['Sunday_Open']
            del details['Monday_Close']
            del details['Tuesday_Close']
            del details['Wednesday_Close']
            del details['Thursday_Close']
            del details['Friday_Close']
            del details['Saturday_Close']
            del details['Sunday_Close']
            data['details'] = details
        else:
            data['details'] = []

        query = """
        SELECT review_id, user_id, name, stars, text, date, Reviews.useful, Reviews.funny, Reviews.cool FROM Reviews
        INNER JOIN Users USING(user_id)
        WHERE business_id=%s"""
        res = cursor.execute(query,[business_id])
        if res > 0:
            columns = cursor.description
            reviews = [{columns[index][0]:column for index, column in enumerate(value)} for value in cursor.fetchall()]
            data['reviews'] = reviews
        else: 
            data['reviews'] = []

        query = """
            SELECT Users.name as name, user_id, text, date, compliment_count FROM Tips 
            INNER JOIN Users USING (user_id)
            WHERE business_id=%s 
        """
        res = cursor.execute(query,[business_id])
        if res > 0:
            columns = cursor.description
            tips = [{columns[index][0]:column for index, column in enumerate(value)} for value in cursor.fetchall()]
            data['tips'] = tips
        else: 
            data['tips'] = []

        query = """
        SELECT Attributes.attribute, Ambience.attribute, Best_Nights.attribute, Business_Parking.attribute, 
        Dietary_Restrictions.attribute, Good_For_Meals.attribute, Hair_Specializes_In.attribute, Music.attribute FROM Attributes
        LEFT JOIN Ambience USING(business_id)
        LEFT JOIN Best_Nights USING(business_id)
        LEFT JOIN Business_Parking USING(business_id)
        LEFT JOIN Dietary_Restrictions USING(business_id)
        LEFT JOIN Good_For_Meals USING(business_id)
        LEFT JOIN Hair_Specializes_In USING(business_id)
        LEFT JOIN Music USING(business_id)
        WHERE business_id=%s"""
        res = cursor.execute(query,[business_id])
        if res > 0:
            all_attributes = cursor.fetchall()
            attributes = set()
            for col in all_attributes:
                for row in col:
                    if row:
                        attributes.add(row)
            data['attributes'] = attributes
        else: 
            data['attributes'] = []


        query = "SELECT categories FROM Categories WHERE business_id=%s"
        res = cursor.execute(query,[business_id])
        if res > 0:
            categories = cursor.fetchall()
            data['categories'] = categories
        else: 
            data['categories'] = []

        cursor.close()
        return render_template('business.html', data=data)
    except:
        return 'Error fetching business data'


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
        try: 
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
        except:
            return 'Error adding review'
    return render_template('review.html', business_id=business_id)

@app.route('/<business_id>/tip', methods=["GET", "POST"])
def tip(business_id):
    if request.method == "POST":
        tip = request.form
        user_id = tip['user_id']
        text = tip['text']

        if not(user_id and text):
            return "Error: all fields must be filled"

        try:
            cursor = mysql.connection.cursor()
            cursor.execute("INSERT INTO Tips(business_id, user_id, text, date) VALUES(%s,%s,%s, %s)",(business_id, user_id, text, str(datetime.today())))
            mysql.connection.commit()
            cursor.close() 
        except:
            return 'Error adding tip'
        return redirect(f'/{business_id}')

    return render_template('tip.html', business_id=business_id)

@app.route('/<business_id>/checkin', methods=["POST"])
def checkin(business_id):
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO Checkins(business_id, date) VALUES(%s,%s)",(business_id, str(datetime.today())))
        mysql.connection.commit()
        cursor.close() 
        return redirect(f'/{business_id}')
    except:
        return 'Error checking in'

@app.route('/review_tag/<review_id>', methods=['POST'])
def review_tag(review_id):
    try:
        cursor = mysql.connection.cursor()
        tag = request.form['tag']
        count = int(request.form['count'])
        business_id = request.form['business_id']
        query = f"UPDATE Reviews SET {tag}=%s WHERE review_id=%s"
        cursor.execute(query, [count,review_id])
        mysql.connection.commit()
        cursor.close()
        return redirect(f'/{business_id}')
    except:
        return 'Error liking review tag'

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