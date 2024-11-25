from db import db
from flask import Flask,request
import json 

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)