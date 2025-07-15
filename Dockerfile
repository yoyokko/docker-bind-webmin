FROM debian:bookworm AS add-apt-repositories

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y systemctl curl gnupg ntp apt-utils \
 && apt-get update \
 && curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh \
 && sh setup-repos.sh --force \
 && apt-get update

LABEL maintainer="sameer@damagehead.com"

ENV BIND_USER=bind \
    DATA_DIR=/data

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      bind9=9.18.18 bind9-host dnsutils webmin \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 853/udp 53/tcp 10000/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/named"]
