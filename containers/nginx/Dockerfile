#Custom nginx grr client
FROM nginxinc/nginx-unprivileged:latest

WORKDIR /

ADD . .

USER root

RUN apt-get update && \
    apt-get install -y sudo && \
    groupadd -g 1000 grr && \
    useradd -m -u 1000 -g grr grr-user

RUN echo "grr-user    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER nginx

CMD ["nginx", "-g", "daemon off;"]
