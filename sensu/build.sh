#!/bin/bash

VERSION=6.2.5

docker buildx build -t ghcr.io/arvatoaws-labs/sensu-go:$VERSION --platform linux/amd64,linux/arm64 --build-arg SENSU_VERSION=$VERSION --push .