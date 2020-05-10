FROM postgis/postgis:12-3.0-alpine

ENV PGSQL_HTTP_VERSION v1.3.1
RUN set -ex \
    \
    && apk add --no-cache --virtual .fetch-deps \
        ca-certificates \
        openssl \
        tar \
    \
    && wget -O pgsql-http.tar.gz "https://github.com/pramsey/pgsql-http/archive/$PGSQL_HTTP_VERSION.tar.gz" \
    && mkdir -p /usr/src/pgsql-http \
    && tar \
        --extract \
        --file pgsql-http.tar.gz \
        --directory /usr/src/pgsql-http \
        --strip-components 1 \
    && rm pgsql-http.tar.gz \
    \
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
    && apk del .fetch-deps .build-deps
