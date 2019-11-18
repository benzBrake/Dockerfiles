#!/usr/bin/env bash
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    set -x
fi
# 加载 build-args
if [[ ! -z ${BUILD_ARGS_FILE} ]] && [[ -f ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} ]]; then
    export BUILD_ARGS=$(cat ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} | sed "s#^#--build-arg #")
fi
if [[ ${TAG_SUBDIR} = "true"  ]]; then
    # 去末尾 /
    BUILD_DIRECTORY=$(echo ${BUILD_DIRECTORY} | sed "s#/*\$##")
    SUB_DIRS=$(\ls -d ${BUILD_DIRECTORY}/*/)
    for SUB_DIR in ${SUB_DIRS//\/\//\/}; do
        # 获取标签
        tag="$(echo ${SUB_DIR} | sed "s#/*\$##" | sed "s#.*\/##")"
        echo "Building image: ${DOCKER_REPO}:${tag}"
        # 构建映像
        docker build -t ${DOCKER_REPO}:${tag} ${BUILD_ARGS} ${SUB_DIR}
        if [[ ${tag} = ${TAG_LATEST} ]]; then
            # 打 latest 标签
            docker tag ${DOCKER_REPO}:${tag} ${DOCKER_REPO}:latest
        fi
    done
else
    TAGS=${DOCKER_TAG-latest}
    for tag in ${TAGS} ; do
        # 构建映像
        docker build -t ${DOCKER_REPO}:${tag} ${BUILD_ARGS} ${BUILD_DIRECTORY}
        # 打 latest 标签
        if [[ ${tag} != "latest" ]]; then
            if [[ ${TAG_LATEST} = "true" ]] || [[ ${TAG_LATEST} = ${tag} ]]; then
                docker tag ${DOCKER_REPO}:${DOCKER_TAG} ${DOCKER_REPO}:latest
            fi
        fi
    done
fi
set +x