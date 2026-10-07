FROM eclipse-temurin:21.0.2_13-jre-jammy

ENV SPRING_PROFILES_ACTIVE=prod

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --system --uid 1001 --create-home appuser

WORKDIR /app

COPY target/novabank-transfer.jar app.jar

RUN chown appuser:appuser /app/app.jar && \
    chmod 644 /app/app.jar

USER appuser

EXPOSE 8082

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -s --max-time 5 http://127.0.0.1:8082/ > /dev/null || exit 1

CMD ["java", "-jar", "app.jar"]
