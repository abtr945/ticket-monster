#
# inmemory/Dockerfile
#
# Deploy TicketMonster on JBoss WildFly application server.
# The webapp is configured to use H2 in-memory database inside the application server container.
#

# Use base Wildfly Docker image
FROM jboss/wildfly:latest

# Copy ticket-monster .WAR artifact to application server deployment directory
ADD ./target/ticket-monster.war /opt/jboss/wildfly/standalone/deployments/
