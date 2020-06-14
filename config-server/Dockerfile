FROM openjdk:8

MAINTAINER Krishna Sharma

EXPOSE 8191

WORKDIR /usr/local/bin

COPY ./target/config-server-0.0.1-SNAPSHOT.jar config-server.jar

CMD ["java", "-jar", "config-server.jar"]
