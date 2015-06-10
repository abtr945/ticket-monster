#!/bin/bash

#
# - Build the ticket-monster maven project, and set it to use PostgreSQL database backend.
#
# - Build a PostgreSQL database Docker Image, with sample TicketMonster database pre-loaded.
#
# - Build a Docker Image for deploying TicketMonster on Wildfly application server,
# which should use a PostgreSQL database backend hosted in a separate Docker container.
#
# - Run a local Docker container from the PostgreSQL database image.
#
# - Run a local Docker container for hosting the TicketMonster app locally, linked to the DB container.
#

echo 'Build ticket-monster maven project with PostgreSQL database settings...'
mvn clean package -Ppostgresql

echo 'Build Docker image for PostgreSQL database server, with sample TicketMonster database pre-loaded...'
sudo docker build -f dockerfiles/postgresql/db/Dockerfile -t ticket-monster-postgresql-db .

echo 'Build Docker image for deploying ticket-monster on Wildfly application server...'
sudo docker build -f dockerfiles/postgresql/appserver/Dockerfile -t ticket-monster-postgresql-appserver .

echo 'Run a local PostgreSQL Docker container, if it has not started yet...'
if [ "$(sudo docker ps -a | grep db)" = "" ]; then
  sudo docker run --name db -d -p 5432:5432 -e POSTGRES_USER=ticketmonster -e POSTGRES_PASSWORD=ticketmonster-docker ticket-monster-postgresql-db
  echo 'Wait a bit for database container to fully initialize...'
  sleep 10
elif [ "$(sudo docker ps | grep db)" = "" ]; then
  sudo docker start db
else
  echo 'DB container already running!'
fi

echo 'Run a local Docker container from built Image, linked to the PostgreSQL database container...'
echo 'Press Ctrl-C to terminate the container. The app will be available at http://localhost:8080/ticket-monster'
sudo docker run -it --link db:db -p 8080:8080 ticket-monster-postgresql-appserver

echo ''
echo 'Application server terminated. If you no longer want the database container, please terminate it using the following Docker commands:'
echo ''
echo 'sudo docker stop db'
echo 'sudo docker rm db'
echo ''
#sudo docker stop db && sudo docker rm db
