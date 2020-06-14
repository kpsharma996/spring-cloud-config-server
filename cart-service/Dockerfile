FROM openjdk:8

MAINTAINER Krishna Sharma

EXPOSE 8081

WORKDIR /usr/local/bin

COPY ./target/cart-service-0.0.1-SNAPSHOT.jar cart-service.jar

CMD ["java", "-jar", "cart-service.jar"]