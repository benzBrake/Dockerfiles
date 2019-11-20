#!/bin/sh
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    set -exo pipefail
fi
# Download Frp
if [[ ${BUILD_VERSION-latest} = "latest" ]]; then
    _LINK="https://github.com$(curl -sL -o - https://github.com/fatedier/frp/releases/latest | grep "frp_.*_linux_amd64.tar.gz" | grep "<a" | awk -F '"' '{print $2}' | head -n1)"
else
    _SLINK=$(curl -sL -o - https://github.com/fatedier/frp/releases/${BUILD_VERSION} | grep "frp_.*_linux_amd64.tar.gz" | grep "<a" | awk -F '"' '{print $2}' | grep ${BUILD_VERSION})
    if [[ -z ${_SLINK} ]]; then
        exit 1
    fi
    _LINK="https://github.com${_SLINK}"
fi
_FILENAME=$(echo ${_LINK} | sed "s#.*/##")
curl -sSL ${_LINK} -o ${_FILENAME}
tar zxvf ${_FILENAME}
_DIR=$(echo ${_FILENAME} | sed "s#.tar.gz##")
cp _DIR/frps /usr/bin/frps
chmod +x /usr/bin/frps
rm -rf ${_DIR} ${_FILENAME}