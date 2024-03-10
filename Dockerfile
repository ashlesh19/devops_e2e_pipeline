# Stage 1: Build the application
FROM maven:3.9.0-openjdk-17 as build
WORKDIR /app
COPY . .
RUN mvn clean install


# Stage 2: Create the final image with the built JAR
FROM adoptopenjdk/openjdk17:alpine
WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
COPY --from=build app/target/DemoApplication-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
