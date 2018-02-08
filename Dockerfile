FROM alpine

LABEL maintainer Knut Ahlers <knut@ahlers.me>

ENV USER share
ENV PASS changeme
ENV USER_UID 1000

ENV DI_VERSION 1.2.1


RUN apk --no-cache add bash curl openssh-server openssl shadow \
 && mkdir /var/run/sshd && chmod 0755 /var/run/sshd \
 && curl -sSfLo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DI_VERSION}/dumb-init_${DI_VERSION}_amd64 \
 && chmod +x /usr/local/bin/dumb-init \
 && apk --no-cache del curl

ADD start.sh /usr/local/bin/start.sh
ADD sshd_config /etc/ssh/sshd_config

VOLUME ["/data", "/ssh"]
EXPOSE 22

ENTRYPOINT ["/usr/local/bin/dumb-init"]
CMD ["/usr/local/bin/start.sh"]
