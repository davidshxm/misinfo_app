from flask import Flask, jsonify
from flask_cors import CORS
from observer import run_observer_in_thread, result_data

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Start the observer in a separate thread when the application starts
run_observer_in_thread(result_data)

@app.route('/')
def run_scripts():
    return jsonify({"result": result_data["result"]})

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
