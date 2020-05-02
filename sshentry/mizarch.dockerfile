# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM local/mizarch:latest

ARG sshExposePort=8022
COPY ./repo/ /tmp/buildRepo/

RUN pacman -Sy --noconfirm grep openssh && \
    /tmp/buildRepo/createSshKey.sh && \
    sh /tmp/buildRepo/insertSshdConfig.sh \
        "Port $sshExposePort" "#Port 22" \
        "AuthorizedKeysFile /sshAuthorizedKeys" "AuthorizedKeysFile	.ssh/authorized_keys" \
        "PasswordAuthentication no" "#PasswordAuthentication" && \
    rm -rf /tmp/buildRepo/

EXPOSE $sshExposePort
CMD ["/usr/sbin/sshd", "-D"]

