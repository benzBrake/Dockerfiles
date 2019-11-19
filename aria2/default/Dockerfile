FROM benzbrake/alpine as builder
WORKDIR /
ARG BUILD_VERSION="latest"
ADD ["tracker.sh", "aria2.conf", "entrypoint.sh", "/data/"]
ADD download_aria2.sh /
RUN chmod +x /download_aria2.sh && /download_aria2.sh

FROM benzbrake/alpine
LABEL maintainer="Ryan Lieu <github-benzBrake@woai.ru>"

COPY --from=builder /aria2/aria2c /bin/aria2c
COPY --from=builder /aria2/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /data /data
ENV TZ="Asia/Shanghai" PUID="1000" PGID="1000"
RUN set -ex && \
    apk add --update --no-cache su-exec && \
    chmod +x /bin/aria2c /data/entrypoint.sh /data/tracker.sh && \
    crontab -u root -l 2>/dev/null | { cat; echo -e "0\t0\t*\t*\t*\tsh /data/tracker.sh 2>&1"; } | crontab -u root -
VOLUME /data/aria2
EXPOSE 6800 6880
ENTRYPOINT ["/data/entrypoint.sh"]