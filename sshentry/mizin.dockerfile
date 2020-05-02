# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM local/mizin:latest

ARG sshExposePort=8022
COPY ./repo/ /tmp/buildRepo/
COPY ./repo/entrypointSshd.sh /dockerEntrypoint.sh

RUN passwd -d root && \
    apk add --no-cache openssh-server && \
    /tmp/buildRepo/createSshKey.sh && \
    sh /tmp/buildRepo/insertSshdConfig.sh \
        "Port $sshExposePort" "#Port 22" \
        "PasswordAuthentication no" "#PasswordAuthentication" && \
    rm -rf /tmp/buildRepo/

EXPOSE $sshExposePort
ENTRYPOINT ["/dockerEntrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

