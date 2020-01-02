#Custom nginx grr client
FROM nginx:latest

USER root

WORKDIR /

ADD . .

RUN apt-get update && \
    apt-get install -y openssh-server nano && \
    mkdir /var/run/sshd

EXPOSE 22

CMD ["nginx", "-g", "daemon off;"]
