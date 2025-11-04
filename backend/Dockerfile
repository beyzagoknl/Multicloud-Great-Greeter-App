FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080 \
    GREETINGS_FILE=/app/greetings.txt

WORKDIR /app

# System deps (optional but recommended for security + faster builds)
RUN pip install --no-cache-dir --upgrade pip

COPY app/ /app/


RUN pip install --no-cache-dir -r /app/requirements.txt

EXPOSE 8080

# Use gunicorn in containers
CMD ["gunicorn", "-b", "0.0.0.0:8080", "--workers=1", "--threads=4", "app:app"]