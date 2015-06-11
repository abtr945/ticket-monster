#!/bin/bash

#
# Supported demo environment OS: Ubuntu
#
# Bootstrap the OS, install required packages for running the TicketMonster demo.
# Need sudo permission.
#

echo 'Install curl, wget, Java JDK 7 and Maven...'
sudo apt-get update && sudo apt-get install curl wget openjdk-7-jdk maven

echo 'Install Docker...'
wget -qO- https://get.docker.com/ | sh

echo 'Install Google Cloud SDK (for deploying the app to Google Container Engine cluster)...'
export CLOUDSDK_CORE_DISABLE_PROMPTS=1
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

echo
echo 'Demo environment bootstrapping completed!'
