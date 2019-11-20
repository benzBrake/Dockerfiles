FROM benzbrake/alpine
MAINTAINER Ryan Lieu <github-benzBrake@woai.ru>

ARG BUILD_VERSION
ENV FRP_BIND_PORT=7000

ADD ["download_frp.sh","frps.ini","/etc/frp/"]
RUN set -ex && \
	chmod +x /etc/frp/download_frp.sh && \
	/etc/frp/download_frp.sh

CMD ["-c", "/etc/frp/frps.ini"]
ENTRYPOINT ["/usr/bin/frps"]