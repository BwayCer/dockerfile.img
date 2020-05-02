# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM local/mizarch:latest

ARG sshExposePort=8022
COPY ./repo/ /tmp/buildRepo/
COPY ./repo/entrypointSshd.sh /dockerEntrypoint.sh
COPY ./repo/sshKey/ /etc/ssh/

RUN pacman -Sy --noconfirm grep openssh && \
    sh /tmp/buildRepo/insertSshdConfig.sh \
        "Port $sshExposePort" "#Port 22" \
        "PasswordAuthentication no" "#PasswordAuthentication" && \
    rm -rf /tmp/buildRepo/

EXPOSE $sshExposePort
ENTRYPOINT ["/dockerEntrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

