#!/usr/bin/env bash
# 去末尾 /
BUILD_DIRECTORY=$(echo ${BUILD_DIRECTORY} | sed "s#/*\$##")
# 列表目录
SUB_DIRS=$(\ls -d ${BUILD_DIRECTORY}/*/)
for SUB_DIR in ${SUB_DIRS//\/\//\/}; do
    # 获取标签
    tag="$(echo ${SUB_DIR} | sed "s#/*\$##" | sed "s#.*\/##")"
    echo "Building image: ${DOCKER_REPO}:${tag}"
    if [[ ! -z ${BUILD_ARGS_FILE} ]] && [[ -f ${SUB_DIR}/${BUILD_ARGS_FILE} ]]; then
        BUILD_ARGS=$(cat ${SUB_DIR}/${BUILD_ARGS_FILE} | sed "s#^#--build-arg #")
    fi
    docker build -t ${DOCKER_REPO}:${tag} ${BUILD_ARGS} ${SUB_DIR}
    if [[ ${tag} = ${TAG_LATEST} ]]; then
        # 打 latest 标签
        docker tag ${DOCKER_REPO}:${tag} ${DOCKER_REPO}:latest
    fi
done