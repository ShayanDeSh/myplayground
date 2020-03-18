FROM openjdk:11-jdk-slim as app-image

ARG BUILD_ID=unknown
ARG BUILD_DATE=unknown
ARG VCS_REF=unknown

LABEL org.label-schema.version="${BUILD_ID}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.name="ch10" \
      org.label-schema.schema-version="1.0rc1"

COPY Dockerfile /Dockerfile

COPY target/ch10-0.1.0.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]

FROM app-image as app-image-debug
ENTRYPOINT ["sh"]

FROM app-image as default


# docker image build -t app-debug -f Dockerfile --target app-image-debug
