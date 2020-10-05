#!/bin/bash

set -e

mkdir -p build/config
echo '{}' > build/config/rate_limited_uris.json
mkdir -p build/state
echo '{}' > build/state/last_access.json

COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up --build "$@"