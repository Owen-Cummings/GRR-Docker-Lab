#Custom ubuntu grr client
FROM ubuntu:latest

USER root

WORKDIR /

ADD . .

RUN apt-get update && \
    apt-get install -y openssh-server nano && \
    mkdir /var/run/sshd

EXPOSE 22

CMD ["tail", "-f", "/dev/null"]
