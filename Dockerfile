FROM ubuntu:14.04
MAINTAINER Knut Ahlers <knut@ahlers.me>

ENV USER share
ENV PASS changeme

RUN apt-get update && \
    apt-get install -y openssh-server mcrypt

ADD start.sh /usr/local/bin/start.sh
ADD sshd_config /etc/ssh/sshd_config

VOLUME ["/data"]
EXPOSE 22

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start.sh"]
