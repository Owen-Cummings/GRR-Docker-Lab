FROM grrdocker/grr:latest

WORKDIR "/"

ADD . .

RUN apt-get update && \
    apt-get install -y sudo && \
    groupadd -g 1000 grr && \
    useradd -m -u 1000 -g grr grr-admin

CMD ["grr"]
