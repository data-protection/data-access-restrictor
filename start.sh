#!/bin/bash

set -e

mkdir -p build/config
echo '{}' > build/config/rate_limited_uris.json
mkdir -p build/state
echo '{}' > build/state/last_access.json

docker-compose up --build