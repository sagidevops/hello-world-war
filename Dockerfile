#
# Build stage
FROM maven:latest
FROM openjdk:11.0.15-jre
COPY . /home/app
RUN mvn compile
# Test stage
RUN mvn test
# Package stage
RUN mvn package
EXPOSE 8080
