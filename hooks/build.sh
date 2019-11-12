#!/usr/bin/env bash
if [[ $LATEST = "true" ]]; then
	docker build -l -t ${DOCKER_BUILD} ${BUILD_DIRECTORY}
else
	docker build -t ${DOCKER_BUILD} ${BUILD_DIRECTORY}
fi