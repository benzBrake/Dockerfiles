#!/usr/bin/env bash
if [[ ${TAG_LATEST} = "true" ]]; then
	docker build -l -t ${DOCKER_REPO}:${DOCKER_TAG} ${BUILD_DIRECTORY}
else
	docker build -t ${DOCKER_REPO}:${DOCKER_TAG} ${BUILD_DIRECTORY}
fi
docker images