// client
def test_create_user(first_name, last_name):
    if not first_name or last_name:
        assert(display error)
    
    submit.click()
    assert(user page displays with new user)

def test_search_page(filters):
    if not filters: // user inputs no filters
        assert(display error)

    businesses = select_filters(filters) 
    if not len(businesses):
        assert(display no results found)
    
    assert(business list displays)

def test_business_page():
    business_id = click_on_business() // user clicks and is redirected to the business_id route

    if business_id not in db or error fetching data:
        assert(display error)

    assert(business page displays)

def test_add_review(user_id, text, stars):
    if not user_id or text or stars:
        assert(display error all fields must be filled)

    fill_review_form(user_id, text, stars) // review_id, date and business_id are handled on the backend
    assert(new review displays)

    fill_review_form(user_id, text, stars) // user tries to write another review on the business
    assert(error displays)

def test_add_tip(user_id, text):
    if not user_id or text:
        assert(display error all fields must be filled)

    fill_tip_form(user_id, text) // date and business_id are handled on the backend
    assert(new tip displays)

def test_like_review_tag(tag):
    click(tag) // user clicks a tag on a review
    assert(count on page increases by 1)

def test_user_page():
    user_id = click_on_user() // user clicks and is redirected to the user/user_id route

    if user_id not in db or error fetching data:
        assert(display error)

    assert(user page displays)

def test_add_friend(user_id):
    if wrong user_id entered:
        assert(display error)

    add_friend(user_id) // user inputs their user_id to add a friend
    assert(friend count increases by 1 on page)

    add_friend(user_id) // user tries to add the friend again
    assert(error displays)

