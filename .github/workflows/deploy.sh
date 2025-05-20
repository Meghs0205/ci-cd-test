#!/bin/bash

docker stop flask-cicd-demo || true
docker rm flask-cicd-demo || true

echo "${GITHUB_TOKEN}" | docker login ghcr.io -u "${GITHUB_USER}" --password-stdin

# 🔥 Pull latest image explicitly
docker pull ghcr.io/${GITHUB_USER}/ci-cd-test:latest

# Run latest image
docker run -d -p 5000:5000 --name flask-cicd-demo ghcr.io/${GITHUB_USER}/ci-cd-test:latest

