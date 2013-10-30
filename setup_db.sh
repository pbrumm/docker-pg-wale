#!/bin/bash
if [[ -z "$1" ]]; then 
  echo "Must specify password"
  exit 1
fi

sysctl -w kernel.shmmax=4418740224
service postgresql-9.2 start
sudo -u postgres psql <<< "CREATE USER root WITH SUPERUSER PASSWORD '$1';"
sudo -u postgres createdb -O db db
