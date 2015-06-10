#
# postgresql/appserver/Dockerfile
#
# Adapted from:
# Rafael Benevides - https://github.com/rafabene/devops-demo
#
# Create Docker image for deploying TicketMonster on WildFly application server
# which uses an external PostgreSQL database hosted in a different Docker container.
#
# The database container will need to be started first, then linked to this application server container.
#

# Use latest jboss/wildfly
FROM jboss/wildfly

# Create Wildfly admin user
RUN /opt/jboss/wildfly/bin/add-user.sh -u admin -p docker#admin --silent

# Add Wildfly application server customization folder to Docker container
COPY dockerfiles/postgresql/appserver/customization /opt/jboss/wildfly/customization/

USER root

# Run Wildfly customization scripts as root
RUN chmod +x /opt/jboss/wildfly/customization/execute.sh
RUN /opt/jboss/wildfly/customization/execute.sh standalone standalone.xml

# Copy TicketMonster webapp artifact to appication server inside container
ADD target/ticket-monster.war /opt/jboss/wildfly/standalone/deployments/

# Fix for Error: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history

RUN chown -R jboss:jboss /opt/jboss/wildfly/

USER jboss

# Expose the ports the appserver are using
EXPOSE 8080 9990

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to external interface
CMD /opt/jboss/wildfly/bin/standalone.sh -b `hostname -i` -bmanagement `hostname -i`
