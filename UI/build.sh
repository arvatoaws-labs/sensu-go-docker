#!/bin/bash

VERSION=1.0.5

docker buildx build -t ghcr.io/arvatoaws-labs/sensu-go-ui:$VERSION --platform linux/amd64,linux/arm64 --build-arg UI_VERSION=$VERSION --push .