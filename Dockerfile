FROM eclipse-temurin:21.0.2_13-jdk-jammy

ENV SPRING_PROFILES_ACTIVE=prod

RUN apt-get update && \
    apt-get install -y openssh-server sudo curl net-tools && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY target/novabank-transfer.jar app.jar

RUN chmod -R 755 /app

EXPOSE 8082 22

CMD ["java", "-jar", "app.jar"]
