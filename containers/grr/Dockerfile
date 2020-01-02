FROM grrdocker/grr:latest

WORKDIR "/"

USER root

ADD . .

RUN apt-get install sshpass

CMD ["grr"]
