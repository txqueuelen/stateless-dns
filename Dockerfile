ARG TAG=
FROM temporary-pdns:${TAG}

RUN cp /usr/local/share/doc/pdns/schema.sqlite3.sql /entrypoint/bootstrap.sql
ADD entrypoint.sh /entrypoint/script

ENTRYPOINT [ "/bin/sh", "/entrypoint/script" ]
CMD [ "/usr/local/bin/pdns_server" ]
