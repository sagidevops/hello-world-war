# Build stage
FROM openjdk:11.0.15-jre
RUN curl -fsSL -o apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz \
&& tar -xzf apache-maven.tar.gz \
&& rm -rf apache-maven.tar.gz \
&& ln -s /apache-maven-3.8.6/bin/mvn /usr/bin/mvn
RUN mkdir -p /home/compile
COPY . /home/compile
WORKDIR /home/compile
RUN mvn compile
# Test stage
RUN mvn test
# Package stage
RUN mvn package
RUN cp /home/compile/target/hello-world-war-1.0.0.war /root