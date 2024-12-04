from db import db
from flask import Flask,request
import json 
import users_dao
import datetime 


app = Flask(__name__)
db_filename = "spotlight.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all() 

# generalized response formats
def success_response(data, code=200):
    """
    Generalized success response function
    """
    return json.dumps(data), code

def failure_response(message, code=404):
    """
    Generalized failure response function
    """
    return json.dumps({"error": message}), code



def extract_token(request):
    """
    Helper function that extracts the token from the header of a request
    """
    auth_header = request.headers.get("Authorization")
    if auth_header is None:
        return False, failure_response("Missing Auth header")
    
    bearer_token = auth_header.replace("Bearer", "").strip() 
    if not bearer_token:
        return False, failure_response("Invalid Auth header")
    
    return True, bearer_token 


@app.route('/signup', methods=['POST'])
def signup():
    """Creates a new user."""
    pass

@app.route('/login', methods=['POST'])
def login():
    """Logs in a user and issues a token."""
    pass

@app.route("/session/", methods=["POST"])
def update_session():
    """
    Endpoint for updating a user's session
    """
    success, response = extract_token(request)
    if not success:
        return response 
    refresh_token = response 

    try:
        user = users_dao.renew_session(refresh_token)
    except Exception as e:
        return failure_response("Invalid update token")

    return json.dumps({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "refresh_token": user.refresh_token
    })

# ===================================
# Recipe Routes
# ===================================

@app.route('/recipes', methods=['GET'])
def get_recipes():
    """Gets all recipes."""
    pass

@app.route('/recipes/<int:recipe_id>', methods=['GET'])
def get_recipe(recipe_id):
    """Gets a specific recipe by ID."""
    pass

@app.route('/recipes', methods=['POST'])
def post_recipe():
    """Creates a new recipe."""
    pass

@app.route('/recipes/save', methods=['POST'])
def save_recipe():
    """Saves a recipe to the user profile."""
    pass

# ===================================
# Community Routes
# ===================================

@app.route('/communities', methods=['GET'])
def get_communities():
    """Gets all communities."""
    pass

@app.route('/communities', methods=['POST'])
def create_community():
    """Creates a new community."""
    pass

@app.route('/communities/<int:community_id>/join', methods=['POST'])
def join_community(community_id):
    """Joins a specific community."""
    pass

# ===================================
# Post Routes
# ===================================

@app.route('/communities/<int:community_id>/posts', methods=['GET'])
def get_community_posts(community_id):
    """Gets all posts from a specific community."""
    pass

@app.route('/communities/<int:community_id>/posts', methods=['POST'])
def add_community_post(community_id):
    """Adds a post to a specific community."""
    pass

@app.route('/posts/<int:post_id>', methods=['GET'])
def get_post(post_id):
    """Gets a specific post by ID."""
    pass

# ===================================
# Profile Routes
# ===================================

@app.route('/profile', methods=['GET'])
def get_profile():
    """Gets user details."""
    pass

@app.route('/profile', methods=['POST'])
def update_profile():
    """Updates user details."""
    pass

@app.route('/profile/saved_recipes', methods=['GET'])
def get_saved_recipes():
    """Gets the user's saved recipes."""
    pass



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)