FROM alpine:latest

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p $CATALINA_HOME

RUN apk add openjdk8 && \
    rm -rf /var/cache/apk/*

RUN wget https://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-9/v9.0.44/bin/apache-tomcat-9.0.44.tar.gz && \
    tar xvzf apache-tomcat-9.0.44.tar.gz && \
    rm apache-tomcat-9.0.44.tar.gz && \
    mv apache-tomcat-9.0.44/* $CATALINA_HOME

EXPOSE 8080
WORKDIR $CATALINA_HOME
CMD ["catalina.sh", "run"]