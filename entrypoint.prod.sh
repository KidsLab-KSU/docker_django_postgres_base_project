#!/bin/sh

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --no-input
gunicorn config.wsgi:application --bind 0.0.0.0:80
exec "$@"