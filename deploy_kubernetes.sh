#!/bin/bash

#
# Deploy a TIcketMonster Kubernetes cluster using the Google Cloud SDK.
#
# Requires the Google Cloud Command-line tool to be properly configured
# (i.e. login credentials, set project, availability zone, and created a Container engine cluster)
#

echo 'Creating Database Docker container...'
kubectl create -f kubernetes/db-controller.json

sleep 5

echo 'Creating Service for accessing the Database container...'
kubectl create -f kubernetes/db-service.json

sleep 5

echo 'Creating Appserver Docker containers...'
kubectl create -f kubernetes/appserver-controller.json

sleep 5

echo 'Creating Service for load-balancing access to Appserver containers...'
kubectl create -f kubernetes/appserver-service.json

echo 'TicketMonster Kubernetes cluster deployment completed!'
