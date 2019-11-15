FROM docker.io/benzbrake/alpine:latest
MAINTAINER Ryan Lieu <github-benzBrake@woai.ru>
RUN if [[ -z $CT_VER ]]; then CT_VER=$(curl -s https://api.github.com/repos/jpillora/cloud-torrent/releases/latest | grep "tag_name" | cut -d \" -f 4); fi && \
    curl -L "https://github.com/jpillora/cloud-torrent/releases/download/${CT_VER}/cloud-torrent_linux_386.gz" -o cloud-torrent.gz && \
    gzip -d cloud-torrent.gz && \
    mv cloud-torrent /usr/bin/cloud-torrent && \
    chmod +x /usr/bin/cloud-torrent

ENTRYPOINT /usr/bin/cloud-torrent