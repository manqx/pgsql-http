FROM postgis/postgis:12-3.0-alpine

ENV PGSQL_HTTP_VERSION v1.3.1

RUN mkdir -p /usr/src/pgsql-http
ADD . /usr/src/pgsql-http

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        file \
        json-c-dev \
        libtool \
        libxml2-dev \
        make \
        perl \
        clang-dev \
        g++ \
        gcc \
        curl-dev \
        llvm9-dev \
    && cd /usr/src/pgsql-http \
    && make \
    && make install \
    && cd / \
    && rm -rf /usr/src/pgsql-http \
    && apk del .build-deps
