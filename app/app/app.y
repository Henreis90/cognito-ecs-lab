from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/health")
def health():
    return jsonify({"status": "healthy"})

@app.route("/public")
def public():
    return jsonify({"message": "Public endpoint"})

@app.route("/private")
def private():
    return jsonify({"message": "Protected endpoint reached"})
