FROM python:3.14-alpine

ENV PIP_DEFAULT_TIMEOUT=100 \
    # Allow statements and log messages to immediately appear
    PYTHONUNBUFFERED=1 \
    # disable a pip version check to reduce run-time & log-spam
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    # cache is useless in docker image, so disable to reduce image size
    PIP_NO_CACHE_DIR=1

WORKDIR /app

COPY app.py  requirements.txt ./
COPY static  ./static/
COPY templates ./templates/

RUN set -ex \
    # Create a non-root user
    && addgroup -S -g 1001 appgroup \
    && adduser -S --u 1001 -G appgroup -H appuser \
    #Upgrade PIP
    && pip3 install --upgrade pip \
    # Install dependencies
    && pip3 install -r requirements.txt 

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers=2", "app:app"]

# Set the user to run the application
USER appuser