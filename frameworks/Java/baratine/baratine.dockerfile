FROM maven:3.6.1-jdk-11-slim as maven
WORKDIR /baratine
COPY pom.xml pom.xml
COPY src src
RUN mvn package -q

FROM openjdk:11.0.3-jdk-slim
WORKDIR /baratine
COPY --from=maven /baratine/target/testKhulnasoftBaratine-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar", "bw-database"]
