def test_create_user(first_name, last_name):
    if not first_name or last_name:
        assert(error)

    user = create_user(first_name, last_name) // insert new user into db
    assert(len(user.id) == 22) // makes sure user is created with appropriate user_id length

def test_user_page(user_id):
    if user_id not in db:
        assert(error)

    user = query_user(user_id)
    assert(user == 1) // check number of users returned is exactly 1

def test_business_page(business_id):
    if business_id not in db:
        assert(error)

    user = query_business(business_id)
    assert(business == 1) // check number of businesses return is exactly 1

def test_leave_review(business_id, user_id, text, stars):
    if not business_id or user_id or text or date or stars:
        assert(error)
    
    review1 = leave_review(business_id, user_id, text) // insert new review; review_id and date are handled within the server function
    assert(len(review1.id) == 22) // makes sure unique review is created with appropriate review_id length

    review2 = leave_review(business_id, user_id, text) // attempt to asser the same review
    assert(review2 is null) // creation of the same review fails

def test_leave_tip(business_id, user_id, text):
    if not business_id or user_id or text:
        assert(error)

    tip = leave_tip(business_id, user_id, text) // insert new tip; date is handled in the server function
    assert(business_id, user_id and date are unique) // creation of tip would fail otherwise

def test_react_to_review(review_id):
    if not review_id:
        assert(error)

    new_count = react_to_review(review_id, tag)
    assert(count_previous + 1 == new_count)

def test_add_friend(user_id, friend_id):
    if not friend_id or user_id:
        assert(error)

    res = add_friend(user_id, friend_id) // add each other as a friend
    assert(user_id != friend_id) // makes sure a user cannot add themselves
    assert(res == 1) // entry creation is succesful

    res = add_friend(user_id, friend_id) // attempt to add the friend again
    assert(res == 0)

