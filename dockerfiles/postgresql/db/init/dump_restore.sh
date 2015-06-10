#!/bin/bash

echo "Load initial TicketMonster database dump."
echo "The ticketmonster database must have already been created."

echo "Starting postgres..."
gosu postgres pg_ctl -w start

echo "Restoring ticketmonster database from dump file..."
gosu postgres psql -h localhost -p 5432 -d ticketmonster < /docker-entrypoint-initdb.d/initial_db_dump.sql

echo "Stopping postgres..."
gosu postgres pg_ctl stop

echo "TicketMonster database dump restore completed."
