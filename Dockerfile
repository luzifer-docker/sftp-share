FROM ubuntu:14.04
MAINTAINER Knut Ahlers <knut@ahlers.me>

ENV USER share
ENV PASS changeme
ENV USER_UID 1000

ENV DI_VERSION 1.0.1
ENV DI_HASH 91b9970e6a0d23d7aedf3321fb1d161937e7f5e6ff38c51a8a997278cc00fb0a

ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_${DI_VERSION}_amd64 /usr/local/bin/dumb-init

RUN apt-get update \
 && apt-get install -y openssh-server mcrypt \
 && mkdir /var/run/sshd && chmod 0755 /var/run/sshd \
 && echo "${DI_HASH}  /usr/local/bin/dumb-init" | sha256sum -c \
 && chmod +x /usr/local/bin/dumb-init

ADD start.sh /usr/local/bin/start.sh
ADD sshd_config /etc/ssh/sshd_config

VOLUME ["/data", "/ssh"]
EXPOSE 22

ENTRYPOINT ["/usr/local/bin/dumb-init"]
CMD ["/usr/local/bin/start.sh"]
