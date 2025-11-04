import os
import random
import threading
from flask import Flask, Response

app = Flask(__name__)

# Thread-safe counter for the current container instance
_counter = 0
_lock = threading.Lock()

# Read greetings from file
GREETINGS_FILE = os.getenv("GREETINGS_FILE", os.path.join(os.path.dirname(__file__), "greetings.txt"))
with open(GREETINGS_FILE, "r", encoding="utf-8") as f:
    GREETINGS = [line.strip() for line in f if line.strip()]

@app.route("/")
def index():
    global _counter
    with _lock:
        _counter += 1
        n = _counter
    greeting = random.choice(GREETINGS)
    text = f"{greeting} visitor number {n}!\n"
    return Response(text, mimetype="text/plain; charset=utf-8")

@app.route("/api")
@app.route("/api/")
def api_index():
    return index()

@app.route("/healthz")
def healthz():
    return {"status": "ok"}

@app.route("/api/healthz")
def api_healthz():
    return healthz()

if __name__ == "__main__":
    port = int(os.getenv("PORT", "8080"))
    app.run(host="0.0.0.0", port=port)