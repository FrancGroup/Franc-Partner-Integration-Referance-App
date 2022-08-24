#!/bin/sh

# Setup environment
python /app/docker_setup.py

# This is expected to be run in a docker container
/usr/local/bin/uwsgi --ini /app/uwsgi.ini --socket 0.0.0.0:5051 --protocol http --wsgi-file wsgi.py --callable app
