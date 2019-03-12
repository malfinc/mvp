#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-EOSQL
  CREATE USER "application" LOGIN SUPERUSER PASSWORD 'application';
  CREATE DATABASE "resources";
  GRANT ALL PRIVILEGES ON DATABASE "resources" TO "application";
EOSQL
