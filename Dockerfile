FROM python:3.9-slim

RUN pip install flask requests

WORKDIR /app

RUN echo 'from flask import Flask\n\
import requests\n\
app = Flask(__name__)\n\
@app.route("/")\n\
def index():\n\
    return "Service is running!"\n\
if __name__ == "__main__":\n\
    app.run(host="0.0.0.0", port=8080)' > app.py

CMD ["python", "app.py"]
