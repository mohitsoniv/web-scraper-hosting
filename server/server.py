from flask import Flask, jsonify
import json
import os

app = Flask(__name__)

@app.route('/')
def get_scraped_data():
    try:
        with open('/output/scraped_data.json', 'r') as f:
            data = json.load(f)
        return jsonify(data)
    except FileNotFoundError:
        return jsonify({"error": "Scraped data not found."}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
