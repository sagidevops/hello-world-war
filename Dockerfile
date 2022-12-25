# Build stage
FROM tomcat:latest
RUN curl -fsSL -o apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz \
&& tar -xzf apache-maven.tar.gz \
&& rm -rf apache-maven.tar.gz \
&& ln -s /apache-maven-3.8.6/bin/mvn /usr/bin/mvn
RUN mkdir -p /home/compile
COPY . /home/compile
WORKDIR /home/compile
# Compile Stage
RUN mvn compile
# Test Stage
RUN mvn test
# Package Stage
RUN mvn package
# Copy WAR file to /root
RUN cp /home/compile/target/hello-world-war-1.0.0.war /usr/local/tomcat/webapps/
WORKDIR /root
