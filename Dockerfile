FROM ubuntu:20.04

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y default-jdk maven git

RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /tmp/boxfuse-sample-java-war-hello && \
    mvn -f /tmp/boxfuse-sample-java-war-hello/pom.xml package