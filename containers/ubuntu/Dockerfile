#Custom ubuntu grr client
FROM ubuntu:latest

WORKDIR /

ADD . .

RUN apt-get update && \
    apt-get install -y sudo && \
    groupadd -g 1000 grr && \
    useradd -m -u 1000 -g grr grr-user

RUN echo "grr-user    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER grr-user

CMD ["tail", "-f", "/dev/null"]
