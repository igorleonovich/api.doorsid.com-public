#!/bin/sh

# doorsservermonolith_db_1
DBID="6ff573bf07ddcc66d62d450df889447d4ca9058a0ded2fe01b8295f796c85173"
docker exec -it $DBID psql -U vapor_username -d postgres -c "drop database doors_database" && docker exec -it $DBID psql -U vapor_username -d postgres -c "create database doors_database"
