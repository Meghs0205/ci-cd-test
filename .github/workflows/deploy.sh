#!/bin/bash
set -e
echo "Logging into GitHub Container Registry..."
echo $GHCR_PAT | docker login ghcr.io -u meghs0205 --password-stdin
echo "Pulling latest image..."
docker pull ghcr.io/meghs0205/ci-cd-test:latest
echo "Image in local cache:"
docker images | grep ci-cd-test
