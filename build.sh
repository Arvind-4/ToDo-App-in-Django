#!/bin/bash

echo "Installing dependencies..."

python3.9 -m pip install -r requirements.txt

echo "Migrating database..."

python3.9 web/manage.py makemigrations --noinput
python3.9 web/manage.py migrate --noinput

echo "Creating superuser..."

DJANGO_SUPERUSER_EMAIL=${DJANGO_SUPERUSER_EMAIL}
DJANGO_SUPERUSER_USERNAME=${DJANGO_SUPERUSER_USERNAME}
DJANGO_SUPERUSER_PASSWORD=${DJANGO_SUPERUSER_PASSWORD}

python3.9 web/manage.py createsuperuser \
    --email $DJANGO_SUPERUSER_EMAIL \
    --username $DJANGO_SUPERUSER_USERNAME \
    --noinput || true

echo "Collecting static files..."

python3.9 web/manage.py collectstatic --noinput