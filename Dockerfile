FROM openjdk:17
EXPOSE 8080
ADD target/spring-petclinic-3.3.0-SNAPSHOT.jar spring-petclinic-3.3.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/spring-petclinic-3.3.0-SNAPSHOT.jar"]

#FROM eclipse-temurin:21-jdk-jammy
 
#WORKDIR /app

#COPY .mvn/ .mvn
#COPY mvnw pom.xml ./
#RUN ./mvnw dependency:resolve

#COPY src ./src

#CMD ["./mvnw", "spring-boot:run"]
