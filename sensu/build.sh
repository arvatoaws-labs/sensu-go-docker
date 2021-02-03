#!/bin/bash

VERSION=6.2.5
SNS_VERSION=0.3.0

docker buildx build -t ghcr.io/arvatoaws-labs/sensu-go:$VERSION --platform linux/amd64,linux/arm64 --build-arg SENSU_VERSION=$VERSION --build-arg SENSU_SNS_VERSION=$SNS_VERSION --push .