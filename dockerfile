# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Install Tomcat
RUN apt-get update && apt-get install -y wget \
    && wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz \
    && tar xzf apache-tomcat-9.0.41.tar.gz \
    && mv apache-tomcat-9.0.41 /usr/local/tomcat \
    && rm apache-tomcat-9.0.41.tar.gz

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Copy your WAR file to the Tomcat webapps directory
COPY /var/lib/jenkins/workspace/myjob/target/studentapp-2.2-SNAPSHOT.war $CATALINA_HOME/webapps

# Modify Tomcat's server.xml to listen on port 8081 instead of 8080
RUN sed -i 's/port="8080"/port="8081"/g' $CATALINA_HOME/conf/server.xml

# Expose the port that Tomcat runs on
EXPOSE 8081

# Run Tomcat
CMD ["catalina.sh", "run"]
