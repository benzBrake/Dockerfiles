#!/usr/bin/env bash
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    set -x
fi
if [[ "${TRAVIS_BRANCH}" == "master" ]] && [[ ! -z ${DOCKER_USERNAME} ]] && [[ ! -z ${DOCKER_PASSWORD} ]]; then
    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
    docker push ${DOCKER_REPO}:${DOCKER_TAG-latest}
    if [[ ${TAG_LATEST} = "true" ]]; then
        docker push ${DOCKER_REPO}:latest
    fi
fi
set -x