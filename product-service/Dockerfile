FROM openjdk:8

MAINTAINER Krishna Sharma

EXPOSE 8082

WORKDIR /usr/local/bin

COPY ./target/product-service-0.0.1-SNAPSHOT.jar product-service.jar

CMD ["java", "-jar", "product-service.jar"]