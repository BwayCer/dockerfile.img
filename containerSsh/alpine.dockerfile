# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)

FROM alpine:latest

ARG vmfileDir=containerSsh

COPY "$vmfileDir/_src/entrypointSshd.sh" "/dockerEntrypoint.sh"
COPY "$vmfileDir/_src/sshKey/" "/etc/ssh/"

RUN passwd -d root && \
    apk add --no-cache openssh-server

EXPOSE 8022
ENTRYPOINT ["/dockerEntrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

