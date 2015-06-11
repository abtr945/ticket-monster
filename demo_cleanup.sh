#!/bin/bash

#
# Stop and remove all running Docker container(s) in the OS.
#
# Optionally, remove all local Docker Images (to save disk space).
#

echo 'Stop and remove all running local Docker containers...'
sudo docker stop `sudo docker ps -q`
sudo docker rm `sudo docker ps -a -q`

if [ "$1" = "--clean-images" ]; then
  echo 'Remove all local Docker images...'
  sudo docker rmi `sudo docker images -q`
fi
