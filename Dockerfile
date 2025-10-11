# Use official Tomcat base image with JDK 17
FROM tomcat:9.0-jdk17-temurin

# Maintainer info (optional)
LABEL maintainer="aneesh.ravikumar@example.com"
LABEL app="box-app"

# Remove default ROOT webapp to clean up
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file to Tomcat webapps
# If you're building with Maven, the WAR will be in target/*.war
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose your app port (Tomcat default 8080)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
