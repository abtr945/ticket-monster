#!/bin/bash

#
# - Build the ticket-monster maven project, and set it to use in-memory database backend (H2).
#
# - Build a Docker Image for deploying ticket-monster on a single Wildfly application server container.
#
# - Run a local Docker container for hosting the app locally.
#

echo 'Build ticket-monster maven project with in-memory database settings...'
sudo mvn clean package

echo 'Build Docker image for deploying ticket-monster on Wildfly application server...'
sudo docker build -f dockerfiles/inmemory/Dockerfile -t ticket-monster-inmemory .

echo 'Run a local Docker container from built Image...'
echo 'Press Ctrl-C to terminate the container. The app will be available at http://localhost:8080/ticket-monster'
sudo docker run -it -p 8080:8080 ticket-monster-inmemory
