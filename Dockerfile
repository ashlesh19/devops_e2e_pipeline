# Stage 1: Build the application
FROM maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY . .
RUN mvn clean install


# Stage 2: Create the final image with the built JAR
FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
COPY --from=build app/target/DemoApplication-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
