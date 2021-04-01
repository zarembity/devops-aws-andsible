FROM alpine:latest

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p $CATALINA_HOME

RUN apk add openjdk8 git maven && \
    rm -rf /var/cache/apk/* && \
    wget https://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-9/v9.0.44/bin/apache-tomcat-9.0.44.tar.gz && \
    tar xvzf apache-tomcat-9.0.44.tar.gz && \
    rm apache-tomcat-9.0.44.tar.gz && \
    mv apache-tomcat-9.0.44/* $CATALINA_HOME

RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /tmp/boxfuse-sample-java-war-hello

RUN mvn -f /tmp/boxfuse-sample-java-war-hello/pom.xml package && \
    cp /tmp/boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/hello.war

EXPOSE 8080
WORKDIR $CATALINA_HOME
CMD ["catalina.sh", "run"]