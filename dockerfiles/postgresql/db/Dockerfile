#
# postgresql/db/Dockerfile
#
# Build a PostgreSQL database server Docker Image,
# and load an initial TicketMonster sample database from a database dump file.
#
# The sample TicketMonster database dump file is in: init/initial_db_dump.sql
# The Shell script to restore the database dump is in: init/dump_restore.sh
#

# From PostgreSQL base Image
FROM postgres:latest

# Copy database dump restore script to container.
#
# The script will be executed automatically,
# once a Docker container is spawned from this image.
#
# See 'How to extend this image' section: https://registry.hub.docker.com/_/postgres/
ADD dockerfiles/postgresql/db/init/* /docker-entrypoint-initdb.d/
