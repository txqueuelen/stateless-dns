FROM debian:11 as builder
ARG PDNS_VERSION=4.7.3

WORKDIR /build
RUN apt update && \
    apt install -y curl bzip2 g++ python3-venv libtool make pkg-config \
    libboost-all-dev libssl-dev libluajit-5.1-dev libcurl4-openssl-dev libsqlite3-dev
RUN curl -sL https://downloads.powerdns.com/releases/pdns-$PDNS_VERSION.tar.bz2 | tar -jx
WORKDIR /build/pdns-$PDNS_VERSION
RUN ./configure --with-modules='bind gsqlite3' && \
    make -j $(nproc) && \
    make install
RUN mkdir -p /usr/local/share/pdns && cp modules/gsqlite3backend/schema.sqlite3.sql /usr/local/share/pdns/schema.sqlite3.sql

FROM debian:11-slim

RUN apt update && apt install -y curl sqlite3 luajit && apt clean

# REMINDER: .dockerignore defaults to exclude everything. Add exceptions to be copied there.
ADD entrypoint.sh /entrypoint/script

COPY --from=builder /usr/local /usr/local

EXPOSE 53 53/udp

ENTRYPOINT [ "/bin/bash", "/entrypoint/script" ]
CMD [ "/usr/local/sbin/pdns_server" ]
