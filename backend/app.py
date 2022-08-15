import os

from flask import Flask, request, jsonify
from jose import jwt
from werkzeug.security import check_password_hash, generate_password_hash

from model import db, User

app = Flask(__name__)

db_user = os.getenv("db_user", "admin")
db_password = os.getenv("db_password", "password_goes_here")
db_host = os.getenv(
    "db_host", "hermes-test.cwdnxypztejb.eu-west-1.rds.amazonaws.com"
)
db_name = os.getenv("db_name", "franc-referance-test")

# This assumes you are using a mariadb see: https://flask-sqlalchemy.palletsprojects.com/en/2.x/config/
app.config[
    "SQLALCHEMY_DATABASE_URI"
] = f"mariadb+mariadbconnector://{db_user}:{db_password}@{db_host}/{db_name}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True
app.config["SQLALCHEMY_POOL_SIZE"] = 20
app.config[
    "SQLALCHEMY_POOL_RECYCLE"
] = 3600  # Number of seconds before retiring a db connection

app.config.from_mapping(
    SECRET_KEY=os.getenv("SECRET_KEY", "replace-secret-key"),
)

JWT_SCT = os.getenv("JWT_SCT", "secret")
JWT_ALG = os.getenv("JWT_ALG", "HS256")


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


@app.route("/login")
def login():
    data = request.json
    username = data["username"]
    password = data["password"]
    user = db.session.query(User).filter_by(username=username).one()
    if user is not None:
        if check_password_hash(user.password, password):
            payload = {
                "id": user.id
            }
            token = jwt.encode(payload, JWT_SCT, JWT_ALG)
            return jsonify({
                token: token
            })
    else:
        return jsonify({
            "message": "failed to login"
        }, 401)


@app.route("/register")
def register():
    data = request.json
    username = data["username"]
    user = db.session.query(User).filter_by(username=username).one()
    if user is not None:
        return jsonify({
            "message": "user already exists"
        }, 409)
    password = data["password"]
    password_hash = generate_password_hash(password)
    new_user = User()
    new_user.username = username
    new_user.password = password_hash
    db.session.add(new_user)
    db.session.commit()
    return jsonify({
        "message": "success"
    }, 200)


@app.route("/getBreakoutURL")
def get_breakout_url():
    data = request.json
    payload = jwt.decode(data["token"], JWT_SCT, JWT_ALG)
    return jsonify({"url": "https://"})


@app.route("/register_callback")
def register_callback():
    data = request.json
    print(data)
    return jsonify({}, 200)


@app.route("/register_deposit")
def register_deposit():
    data = request.json
    print(data)
    return jsonify({}, 200)


@app.route("/register_withdrawal")
def register_withdrawal():
    data = request.json
    print(data)
    return jsonify({}, 200)


if __name__ == "__main__":
    app.run(debug=True)
