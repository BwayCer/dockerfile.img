# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)

FROM local/mizarch:latest

ARG vmfileDir=containerSsh

COPY "$vmfileDir/_src/entrypointSshd.sh" "/dockerEntrypoint.sh"
COPY "$vmfileDir/_src/insertSshdConfig.sh" "/dockersh/insertSshdConfig.sh"
COPY "$vmfileDir/_src/sshKey/" "/etc/ssh/"

RUN sh /dockersh/insertSshdConfig.sh \
        "Port 8022" "#Port 22" \
        "PasswordAuthentication no" "#PasswordAuthentication" && \
    rm /dockersh/insertSshdConfig.sh

EXPOSE 8022
ENTRYPOINT ["/dockerEntrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

