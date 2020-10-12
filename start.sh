#!/bin/bash

set -e

mkdir -p build/config
echo '{}' > build/config/rate_limited_uris.json
chmod -R a+w build/config
mkdir -p build/state
echo '{}' > build/state/last_access.json
chmod -R a+w build/state
touch build/faketime

COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up --build "$@"