FROM maven:3.9.0-eclipse-temurin-17 as maven
WORKDIR /vertx
COPY src src
COPY pom.xml pom.xml
RUN mvn package -q

EXPOSE 8080

CMD ["java", "-Xms2G", "-Xmx2G", "-server", "-XX:+UseNUMA", "-XX:+UseParallelGC", "-Djava.lang.Integer.IntegerCache.high=10000", "-Dvertx.disableMetrics=true", "-Dvertx.disableH2c=true", "-Dvertx.disableWebsockets=true", "-Dvertx.flashPolicyHandler=false", "-Dvertx.threadChecks=false", "-Dvertx.disableContextTimings=true", "-Dvertx.disableTCCL=true", "-Dvertx.disableHttpHeadersValidation=true", "-Dio.netty.buffer.checkBounds=false", "-Dio.netty.buffer.checkAccessible=false", "-jar", "target/vertx.benchmark-0.0.1-SNAPSHOT-fat.jar", "src/main/conf/config.json"]