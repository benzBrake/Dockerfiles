#!/usr/bin/env bash
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    set -exo pipefail
fi
# 加载 build-args
if [[ ! -z ${BUILD_ARGS_FILE} ]] && [[ -f ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} ]]; then
    BUILD_ARGS=$(cat ${BUILD_DIRECTORY}/${BUILD_ARGS_FILE} | sed "s#^#--build-arg #")
    export BUILD_ARGS="${BUILD_ARGS}"
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
    # 从 REPO 读取 TAG
    if [[ ! -z ${TAG_FROM_TAGS} ]]; then
        rm -rf /tmp/git &> /dev/null
        git clone ${1} /tmp/git &> /dev/null
        cd /tmp/git &> /dev/null
        EXT_TAGS="$(echo -e $(git tag 2>/dev/null) | sed 's#\n# #g')"
        cd - &> /dev/null
        rm -rf /tmp/git &> /dev/null
    fi
    TAGS="${TAGS} ${EXT_TAGS}"
    # 遍历标签，分别构建
    for tag in "${TAGS}" ; do
        # 构建映像
        docker build -t ${DOCKER_REPO}:${tag} ${BUILD_ARGS} --build-arg BUILD_VERSION=${tag} ${BUILD_DIRECTORY}
        # 打 latest 标签
        if [[ ${tag} != "latest" ]]; then
            if [[ ${TAG_LATEST} = "true" ]] || [[ ${TAG_LATEST} = ${tag} ]]; then
                docker tag ${DOCKER_REPO}:${DOCKER_TAG} ${DOCKER_REPO}:latest
            fi
        fi
    done
fi
set +x