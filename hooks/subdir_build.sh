#!/usr/bin/env bash
# 去末尾 /
BUILD_DIRECTORY=$(echo ${BUILD_DIRECTORY} | sed "s#/*\$##")
# 列表目录
SUB_FILES=$(\ls -d ${BUILD_DIRECTORY}/*/)
for file in ${SUB_FILES//\/\//\/}; do
    # 获取标签
    tag="$(echo ${file} | sed "s#/*\$##" | sed "s#.*\/##")"
    echo "Building image: ${DOCKER_REPO}:${tag}"
    docker build -t ${DOCKER_REPO}:${tag} ${file}
    if [[ ${tag} = ${TAG_LATEST} ]]; then
        # 打 latest 标签
        docker tag ${DOCKER_REPO}:${tag} ${DOCKER_REPO}:latest
    fi
done