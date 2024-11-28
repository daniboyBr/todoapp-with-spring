FROM openjdk:23-jdk-slim-bullseye as builder
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
RUN ./mvnw clean package -Dmaven.test.skip

FROM openjdk:23-jdk-slim-bullseye
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/app/app.jar" ]