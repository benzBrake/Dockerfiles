#!/usr/bin/env bash
if [[ "${TRAVIS_BRANCH}" == "master" ]] && [[ ! -z ${DOCKER_USERNAME} ]] && [[ ! -z ${DOCKER_PASSWORD} ]]; then
    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
    docker push ${DOCKER_REPO}:${DOCKER_TAG}
    if [[ ${TAG_LATEST} = "true" ]]; then
        docker push ${DOCKER_REPO}:latest
    fi
fi