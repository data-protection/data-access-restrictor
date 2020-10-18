#!/bin/bash

set -e

mkdir -p build/config
echo '{}' > build/config/rate_limited_uris.json
chmod -R a+w build/config
mkdir -p build/state
echo '{}' > build/state/last_access.json
chmod -R a+w build/state

mkdir -p build/faketime
cat <<EOF >> build/faketime/Dockerfile
FROM alpine:3.12
RUN apk add git build-base
RUN git clone https://github.com/wolfcw/libfaketime.git /faketime
WORKDIR /faketime
RUN make && make install
EOF
docker build --tag faketime --quiet build/faketime &> /dev/null
docker run -v $(pwd)/build/faketime:/copy faketime cp /usr/local/lib/faketime/libfaketimeMT.so.1 /copy
touch build/faketime/timestamp

COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up --build "$@"