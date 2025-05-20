#!/bin/bash

# Stop and remove existing container
docker stop flask-cicd-demo || true
docker rm flask-cicd-demo || true

# Re-authenticate and pull the latest image
echo "${GITHUB_TOKEN}" | docker login ghcr.io -u "${GITHUB_USER}" --password-stdin

# Pull the latest image explicitly
docker pull ghcr.io/${GITHUB_USER}/ci-cd-test:latest

# Run updated container
docker run --pull always -d -p 5000:5000 --name flask-cicd-demo ghcr.io/${GITHUB_USER}/ci-cd-test:latest
