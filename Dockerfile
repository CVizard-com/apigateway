FROM maven:3-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY /home/runner/work/apigateway/apigateway/certificate.pem /app/src/main/resources/certificate.pem
RUN mvn clean package -DskipTests

FROM amazoncorretto:17
WORKDIR /app
COPY --from=build /app/target/apigateway.jar .
EXPOSE 8443
CMD ["java", "-jar", "apigateway.jar"]
