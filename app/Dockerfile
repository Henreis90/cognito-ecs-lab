FROM python:3.12-slim

WORKDIR /app

RUN pip install flask

COPY app.py .

CMD ["python", "app.py", "--host=0.0.0.0", "--port=5000"]
