#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "template1" <<-EOSQL
  CREATE EXTENSION "citext"
  CREATE EXTENSION "pgcrypto"
  CREATE EXTENSION "cube"
  CREATE EXTENSION "btree_gin"
  CREATE EXTENSION "btree_gist"
  CREATE EXTENSION "hstore"
  CREATE EXTENSION "isn"
  CREATE EXTENSION "ltree"
  CREATE EXTENSION "lo"
  CREATE EXTENSION "fuzzystrmatch"
  CREATE EXTENSION "pg_buffercache"
  CREATE EXTENSION "pgrowlocks"
  CREATE EXTENSION "pg_prewarm"
  CREATE EXTENSION "pg_stat_statements"
  CREATE EXTENSION "pg_trgm"
  CREATE EXTENSION "tablefunc"
  CREATE USER "application" LOGIN SUPERUSER PASSWORD 'application';
  CREATE DATABASE "resources";
  GRANT ALL PRIVILEGES ON DATABASE "resources" TO "application";
EOSQL
