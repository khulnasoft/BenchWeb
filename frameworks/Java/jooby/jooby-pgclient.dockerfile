FROM maven:3.9.9-eclipse-temurin-22-alpine
WORKDIR /jooby
COPY pom.xml pom.xml
COPY src src
COPY public public
COPY conf conf
RUN mvn package -q -P netty

EXPOSE 8080

CMD ["java", "-server", "-Xms2g", "-Xmx2g", "-XX:+UseNUMA", "-XX:+UseParallelGC", "-Dio.netty.disableHttpHeadersValidation=true", "-Dio.netty.buffer.checkBounds=false", "-Dio.netty.buffer.checkAccessible=false", "-cp", "target/jooby.jar", "com.khulnasoft.ReactivePg"]
