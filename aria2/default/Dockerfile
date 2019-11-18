FROM benzbrake/alpine as builder
WORKDIR /
ARG BUILD_VERSION="latest"
RUN set -ex && \
    apk add --update --no-cache wget && \
    CURL_LINK="https://github.com$(curl -sL -O - https://github.com/q3aql/aria2-static-builds/releases/${BUILD_VERSION} | grep "aria2-.*-linux-gnu-64bit-build1.tar.bz2" | grep "<a" | awk -F '"' '{print $2}')" && \
    wget ${CURL_LINK} && \
    bzip2 -d aria2*.bz2 && \
    tar xf aria2*.tar && \
    rm -rf aria2*.tar && \
    mv aria2* aria2

FROM benzbrake/alpine
LABEL maintainer="Ryan Lieu <github-benzBrake@woai.ru>"
ADD ["index.html", "tracker.sh", "aria2.conf", "entrypoint.sh", "/data/"]
COPY --from=builder /aria2/aria2c /bin/aria2c
COPY --from=builder /aria2/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ENV TZ="Asia/Shanghai" PUID="1000" PGID="1000"
RUN set -ex && \
    apk add --update --no-cache su-exec && \
    chmod +x /bin/aria2c /data/entrypoint.sh /data/tracker.sh && \
    crontab -u root -l 2>/dev/null | { cat; echo -e "0\t0\t*\t*\t*\tsh /data/tracker.sh 2>&1"; } | crontab -u root -
VOLUME /data/aria2
EXPOSE 6800 6880
ENTRYPOINT ["/data/entrypoint.sh"]
