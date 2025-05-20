#!/bin/bash

docker stop flask-cicd-demo || true
docker rm flask-cicd-demo || true

echo "${GITHUB_TOKEN}" | docker login ghcr.io -u "meghs0205" --password-stdin

docker pull ghcr.io/meghs0205/ci-cd-test:latest
docker run -d -p 5000:5000 --name flask-cicd-demo ghcr.io/meghs0205/ci-cd-test:latest
