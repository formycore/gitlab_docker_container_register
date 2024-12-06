FROM amazoncorretto:17-alpine3.18-jdk
WORKDIR /
EXPOSE 8080
ADD target/spring-petclinic-3.4.0-SNAPSHOT.jar /spring-petclinic-3.4.0-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/spring-petclinic-3.4.0-SNAPSHOT.jar"]
