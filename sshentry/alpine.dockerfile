# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM alpine:latest

COPY ./repo/ /tmp/buildRepo/
COPY ./repo/entrypointSshd.sh /dockerEntrypoint.sh
COPY ./repo/sshKey/ /etc/ssh/

# RUN apk add --no-cache tzdata && \
    # cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUN passwd -d root && \
    apk add --no-cache openssh-server && \
    sh /tmp/buildRepo/insertSshdConfig.sh \
        "Port 8022" "#Port 22" \
        "PasswordAuthentication no" "#PasswordAuthentication" && \
    rm -rf /tmp/buildRepo/

EXPOSE 8022
ENTRYPOINT ["/dockerEntrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

