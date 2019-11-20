FROM docker.io/library/golang as build
ARG BUILD_VERSION
RUN mkdir -pv /go/src/github.com/fatedier
RUN set -x \
    && go get github.com/tools/godep \
    && mkdir -pv /go/src/github.com/fatedier \
    && cd /go/src/github.com/fatedier \
    && git clone https://github.com/fatedier/frp frp \
    && cd /go/src/github.com/fatedier/frp \
    && git checkout ${BUILD_VERSION-master} \
    && CGO_ENABLED=0 make frps \
    && chmod +x /go/src/github.com/fatedier/frp/bin/frps
ENTRYPOINT ["bash"]

FROM scratch
MAINTAINER Ryan Lieu <github-benzBrake@woai.ru>
ENV FRP_BIND_PORT=7000
COPY --from=build /go/src/github.com/fatedier/frp/bin/frps /usr/bin/frps
ADD ["frps.ini","/etc/frp/"]
CMD ["-c", "/etc/frp/frps.ini"]
ENTRYPOINT ["/usr/bin/frps"]