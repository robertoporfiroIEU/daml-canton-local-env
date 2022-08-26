FROM adoptopenjdk/openjdk14:jre-14.0.2_12-ubi-minimal

ARG PROJECT_NAME
ARG PROJECT_VERSION

ENV PROJECT_NAME ${PROJECT_NAME}
ENV PROJECT_VERSION ${PROJECT_VERSION}

ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8

RUN mkdir /json-api

COPY http-json-2.3.2.jar /json-api

WORKDIR /json-api


ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","http-json-2.3.2.jar"]
