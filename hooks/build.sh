#!/usr/bin/env bash
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    set -x
fi
# 加载 build-args
if [[ ! -z ${BUILD_ARGS_FILE} ]] && [[ -f ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} ]]; then
    export BUILD_ARGS=$(cat ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} | sed "s#^#--build-arg #")
fi
if [[ ${TAG_SUBDIR} = "true"  ]]; then
    ./hooks/subdir_build.sh
else
    # 构建映像
    docker build -t ${DOCKER_REPO}:${DOCKER_TAG-latest} ${BUILD_ARGS} ${BUILD_DIRECTORY}
    # 打 latest 标签
    if [[ ${DOCKER_TAG-latest} != "latest" ]]; then
        if [[ ${TAG_LATEST} = "true" ]] || [[ ${TAG_LATEST} = ${DOCKER_TAG} ]]; then
            docker tag ${DOCKER_REPO}:${DOCKER_TAG} ${DOCKER_REPO}:latest
        fi
    fi
fi
set +x