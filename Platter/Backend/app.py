from db import db
from flask import Flask, request
from db import User, Recipe, SavedRecipe, Group, GroupMembership, Post
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
    body = json.load(request.data)
    first_name = body.get("first_name")
    last_name = body.get("last_name")
    username = body.get("username")
    password = body.get("password")

    if first_name is None or last_name is None or username is None or password is None:
        return failure_response("Invalid body, please fill in all fields")
    
    user = users_dao.create_user(first_name, last_name, username, password)
    if user is None:
        return failure_response("User already exists")
    
    return json.dumps({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "refresh_token": user.refresh_token
    })
    


@app.route('/login', methods=['POST'])
def login():
    """Logs in a user and issues a token."""
    body = json.load(request.data)
    username = body.get("username")
    password = body.get("password")

    if username is None or password is None:
        return failure_response("Invalid body, fill in all required fields")

    user = users_dao.verify_credentials(username, password)
    if user is None:
        return failure_response("Password or Username is wrong")
    
    user.renew_session() 
    return json.dumps({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "refresh_token": user.refresh_token
    })



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

@app.route('/recipes/', methods=['GET'])
def get_recipes():
    """Gets all recipes."""
    recipes = Recipe.query.all()
    return json.dumps([recipe.serialize() for recipe in recipes]), 200

@app.route('/recipes/<int:recipe_id>/', methods=['GET'])
def get_recipe(recipe_id):
    """Gets a specific recipe by ID."""
    recipe = Recipe.query.get(recipe_id)
    if not recipe:
        return "Recipe not found", 404
    return json.dumps(recipe.serialize()), 200

@app.route('/recipes/', methods=['POST'])
def post_recipe():
    """Creates a new recipe."""
    data = request.json
    try:
        recipe = Recipe(
            title=data['title'],
            summary=data['summary'],
            ingredients=data['ingredients'],
            instructions=data['instructions'],
            imageUrl=data.get('imageUrl'),
            type=data["type"],
            saved=data["saved"]
        )
        db.session.add(recipe)
        db.session.commit()
        return json.dumps(recipe.serialize()), 201
    except KeyError as e:
        return f"Missing field: {e}", 400

@app.route('/recipes/save/', methods=['POST'])
def save_recipe():
    """Saves a recipe to the user profile."""
    data = request.json
    user = User.query.get(data['user_id'])
    recipe = Recipe.query.get(data['recipe_id'])
    if not user or not recipe:
        return "User or recipe not found", 404
    saved_recipe = SavedRecipe(user_id=user.id, recipe_id=recipe.id)
    db.session.add(saved_recipe)
    db.session.commit()
    return json.dumps(saved_recipe.serialize()), 201

@app.route('/recipes/<int:recipe_id>/', methods=['DELETE'])
def delete_recipe(recipe_id):
    """
    Deletes a specific recipe by ID.
    """
    recipe = Recipe.query.get(recipe_id)
    if not recipe:
        return failure_response("Recipe not found", 404)

    db.session.delete(recipe)
    db.session.commit()
    return success_response({"message": f"Recipe with ID {recipe_id} has been deleted."}, 200)


# ===================================
# Community Routes
# ===================================

@app.route('/communities/', methods=['GET'])
def get_communities():
    """Gets all communities."""
    communities = Group.query.all()
    return json.dumps([community.serialize() for community in communities]), 200

@app.route('/communities/<int:community_id>/join/', methods=['POST'])
def join_community(community_id):
    """Joins a specific community."""
    data = request.json
    user = User.query.get(data['user_id'])
    group = Group.query.get(community_id)
    if not user or not group:
        return "User or community not found", 404
    membership = GroupMembership(user_id=user.id, group_id=group.id)
    db.session.add(membership)
    db.session.commit()
    return "Joined community successfully", 200

# ===================================
# Post Routes
# ===================================

@app.route('/communities/<int:community_id>/posts/', methods=['GET'])
def get_community_posts(community_id):
    """Gets all posts from a specific community."""
    group = Group.query.get(community_id)
    if not group:
        return "Community not found", 404
    return json.dumps([post.serialize() for post in group.posts]), 200

@app.route('/communities/<int:community_id>/posts/', methods=['POST'])
def add_community_post(community_id):
    """Adds a post to a specific community."""
    data = request.json
    group = Group.query.get(community_id)
    user = User.query.get(data['user_id'])
    if not group or not user:
        return "User or community not found", 404
    post = Post(
        title=data['title'],
        description=data['description'],
        user_id=user.id,
        group_id=group.id
    )
    db.session.add(post)
    db.session.commit()
    return json.dumps(post.serialize()), 201

@app.route('/posts/<int:post_id>/', methods=['GET'])
def get_post(post_id):
    """Gets a specific post by ID."""
    post = Post.query.get(post_id)
    if not post:
        return "Post not found", 404
    return json.dumps(post.serialize()), 200

# ===================================
# Profile Routes
# ===================================

@app.route('/profile/', methods=['GET'])
def get_profile():
    """Gets user details."""
    user_id = request.args.get('user_id')
    user = User.query.get(user_id)
    if not user:
        return "User not found", 404
    return json.dumps(user.serialize()), 200

@app.route('/profile/', methods=['POST'])
def update_profile():
    """Updates user details."""
    data = request.json
    user = User.query.get(data['user_id'])
    if not user:
        return "User not found", 404
    user.first_name = data.get('first_name', user.first_name)
    user.last_name = data.get('last_name', user.last_name)
    user.username = data.get('username', user.username)
    user.imageUrl = data.get('imageUrl', user.imageUrl)
    db.session.commit()
    return json.dumps(user.serialize()), 200

@app.route('/profile/saved_recipes/', methods=['GET'])
def get_saved_recipes():
    """Gets the user's saved recipes."""
    user_id = request.args.get('user_id')
    user = User.query.get(user_id)
    if not user:
        return "User not found", 404
    return json.dumps([saved.recipe.serialize() for saved in user.saved_recipes]), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)