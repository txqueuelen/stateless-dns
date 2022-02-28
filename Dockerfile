FROM alpine

ARG BOOTSTRAP_SQL=schema.sqlite3-4.5.x.sql

ADD entrypoint.sh /entrypoint/script
ADD $BOOTSTRAP_SQL /entrypoint/bootstrap.sql

RUN apk add --no-cache \
    pdns \
    pdns-backend-sqlite3 \
    sqlite \
    pdns-tools

ENV VERSION=4.5

EXPOSE 53 53/udp

ENTRYPOINT [ "/bin/sh", "/entrypoint/script" ]
CMD [ "/usr/sbin/pdns_server" ]
