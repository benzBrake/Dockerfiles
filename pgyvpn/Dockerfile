FROM benzbrake/alpine
MAINTAINER Ryan Lieu <github-benzBrake@woai.ru>

ENV PGY_USERNAME PGY_PASSOWRD
ADD entrypoint.sh /data/
RUN \
	set -ex && \
	apk --update --no-cache add rpm bash expect libc6-compat libgcc libstdc++ && \
	curl -SL "https://pgy.oray.com/package/dl?id=42&os=Ubuntu%20Linux(X86_64)" -o /tmp/pygvpn.rpm && \
	rpm --nodeps -i /tmp/pygvpn.rpm && \
	rm -f /tmp/pygvpn.rpm && \
	apk del rpm bash && \
	chmod +x /data/entrypoint.sh
ENTRYPOINT ["/data/entrypoint.sh"]