# Stage 1: Build the application
FROM maven:3.9-eclipse-temurin-11 AS builder

# Install Node.js and npm (required by wflow-consoleweb maven build)
RUN apt-get update && apt-get install -y nodejs npm

WORKDIR /app
COPY . /app
RUN --mount=type=cache,target=/root/.m2 \
    if [ ! -f /app/wflow-consoleweb/target/jw.war ]; then \
        cd wflow-app && mvn clean install -Dmaven.test.skip=true; \
    else \
        echo "Found pre-built jw.war, skipping maven build!"; \
    fi

# Stage 2: Create runtime
FROM tomcat:9.0.93-jdk11

# install cron and Git LFS

RUN rm -rf /usr/local/tomcat/webapps/*

# transfer built .war file into webapps
COPY --from=builder /app/wflow-consoleweb/target/jw.war /usr/local/tomcat/webapps/ROOT.war

RUN mkdir -p /usr/local/tomcat/wflow && chmod -R 755 /usr/local/tomcat/wflow/

# Download wait-for-it since the original lib/ doesn't exist in this repo
RUN apt-get update && apt-get install -y wget && \
    wget -O /usr/bin/wait-for-it https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /usr/bin/wait-for-it

# We rely on standard Tomcat scripts instead of catalina.properties and tomcat.sh from lib/

EXPOSE 8080
EXPOSE 8000

ENV JAVA_OPTS=${JAVA_OPTS}
#ENV TOMCAT_DEBUG=${TOMCAT_DEBUG}

# We use standard catalina.sh run since tomcat.sh is missing
CMD ["catalina.sh", "run"]
