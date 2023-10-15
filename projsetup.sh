#!/bin/bash

# Install PostgreSQL and PostgreSQL contrib packages
sudo apt install postgresql postgresql-contrib -y
psql --version

# Install Node.js and npm
sudo apt install nodejs npm -y
node -v

# Get into postgres
POSTGRES_PASSWORD="mydata"
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$POSTGRES_PASSWORD';"

# Unzip application
unzip webapp.zip