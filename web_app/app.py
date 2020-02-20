"""
Create a Flask app
Define a route and run the application in debug mode on localhost
"""
from flask import Flask

# Create Flask app
app = Flask(__name__)

# Define route
@app.route("/")

def hello():
    return "Hello World!"

# Run application on localhost
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")

