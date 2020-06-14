FROM openjdk:8

MAINTAINER Krishna Sharma

EXPOSE 8080

WORKDIR /usr/local/bin

COPY ./target/checkout-service-0.0.1-SNAPSHOT.jar checkout-service.jar

CMD ["java", "-jar", "checkout-service.jar"]