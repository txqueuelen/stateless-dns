FROM alpine:3.12

ADD entrypoint.sh /entrypoint/script
ADD bootstrap.sql /entrypoint/bootstrap.sql

RUN apk add --no-cache \
    pdns \
    pdns-backend-sqlite3 \
    sqlite \
    pdns-tools

ENV VERSION=4.2 

EXPOSE 53 53/udp

ENTRYPOINT [ "/bin/sh", "/entrypoint/script" ]
CMD [ "/usr/sbin/pdns_server" ]