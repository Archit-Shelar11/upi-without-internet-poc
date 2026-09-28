# Build stage
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app
COPY . .
# Make the wrapper executable
RUN chmod +x ./mvnw
# Build the application
RUN ./mvnw clean package -DskipTests

# Run stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copy the built jar from the build stage
COPY --from=build /app/target/upi-offline-mesh-0.0.1-SNAPSHOT.jar app.jar

# Expose port (Spring Boot default is 8080)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
