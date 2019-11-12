#!/usr/bin/env bash
# Load build args
if [[ ! -z ${BUILD_ARGS_FILE} ]] && [[ -f ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} ]]; then
    BUILD_ARGS=$(cat ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} | sed "s#^#--build-arg #")
fi
# Build image
docker build -t ${DOCKER_REPO}:${DOCKER_TAG} ${BUILD_ARGS} ${BUILD_DIRECTORY}
# Tag image
if [[ ${TAG_LATEST} = "true" ]]; then
    docker tag ${DOCKER_REPO}:${DOCKER_TAG} ${DOCKER_REPO}:latest
fi
# List image
docker images