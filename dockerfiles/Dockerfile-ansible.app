FROM ubuntu:20.04

RUN apt update
RUN apt install ansible

CMD ["/sbin/init"]
