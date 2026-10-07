# Maven으로 WAR 만들기
FROM maven:3.9-eclipse-temurin-11 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn -B clean package -DskipTests

# Tomcat에 WAR 넣기
FROM tomcat:9.0-jdk11-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/hello-1.0.0.war \
    /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]