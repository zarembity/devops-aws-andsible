FROM ubuntu:20.04

RUN apt update -y
RUN apt install ansible -y

CMD ["/sbin/init"]
