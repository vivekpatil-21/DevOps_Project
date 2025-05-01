# Use a multi-stage build
FROM maven:3.8.5-jdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/demo-*.jar crud-app.jar
EXPOSE 8080
CMD ["java", "-jar", "crud-app.jar"]
