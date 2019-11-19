#!/bin/sh
# Download Aria2
if [[ ${BUILD_VERSION} = "latest" ]]; then
    _LINK="https://github.com$(curl -sL -o - https://github.com/q3aql/aria2-static-builds/releases/${BUILD_VERSION} | grep "aria2-.*-linux-gnu-64bit-build1.tar.bz2" | grep "<a" | awk -F '"' '{print $2}' | head -n1)"
else
    _SLINK=$(curl -sL -o - https://github.com/q3aql/aria2-static-builds/releases/${BUILD_VERSION} | grep "aria2-.*-linux-gnu-64bit-build1.tar.bz2" | grep "<a" | awk -F '"' '{print $2}' | grep ${BUILD_VERSION})
    if [[ -z ${_SLINK} ]]; then
        exit 1
    fi
    _LINK="https://github.com${_SLINK}"
fi
_FILENAME=$(echo ${_LINK} | sed "s#.*/##" )
curl -sSL ${_LINK} -o ${_FILENAME}
bzip2 -d aria2*.bz2 && \
tar xf aria2*.tar && \
rm -rf aria2*.tar && \
mv aria2* aria2
chmod +x /aria2/aria2c
# Download Aira2ng
curl -sSL https://github.com$(curl -sSL -o - https://github.com/mayswind/AriaNg/releases/latest | grep "AriaNg-[^/]*-AllInOne.zip" | grep "<a" | awk -F'"' '{print $2}') -o Aria2ng.zip
unzip Aria2ng.zip
mv index.html /data/