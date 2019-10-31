FROM python:3.8-alpine

ENV PUPPETBOARD_PORT 80
EXPOSE 80

ENV PUPPETBOARD_SETTINGS docker_settings.py
RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

COPY requirements*.txt /usr/src/app/
RUN pip install -r requirements-docker.txt

COPY . /usr/src/app

CMD gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --workers="${PUPPETBOARD_WORKERS:-1}" -e SCRIPT_NAME="${PUPPETBOARD_URL_PREFIX:-}" --access-logfile=- puppetboard.app:app
