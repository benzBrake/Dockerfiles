#!/usr/bin/env bash
docker build -t ${DOCKER_REPO}:${DOCKER_TAG} ${BUILD_DIRECTORY}
if [[ ${TAG_LATEST} = "true" ]]; then
	docker tag ${DOCKER_REPO}:${DOCKER_TAG} ${DOCKER_REPO}:latest
fi
docker images