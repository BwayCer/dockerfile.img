# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM local/mizarch:latest

COPY ./repo/ /tmp/buildRepo/
COPY ./repo/entrypointSshd.sh /dockerEntrypoint.sh
COPY ./repo/sshKey/ /etc/ssh/

RUN sh /tmp/buildRepo/insertSshdConfig.sh \
        "Port 8022" "#Port 22" \
        "PasswordAuthentication no" "#PasswordAuthentication" && \
    rm -rf /tmp/buildRepo/

EXPOSE 8022
ENTRYPOINT ["/dockerEntrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

