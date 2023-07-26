FROM maven:3-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY /etc/letsencrypt/archive/cvizard.com /app/src/main/resources
RUN mvn clean package -DskipTests

FROM amazoncorretto:17
WORKDIR /app
COPY --from=build /app/target/apigateway.jar .
EXPOSE 8443
CMD ["java", "-jar", "apigateway.jar"]
