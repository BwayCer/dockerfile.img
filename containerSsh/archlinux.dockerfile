# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)

FROM archlinux/base

ARG vmfileDir=containerSsh

COPY "$vmfileDir/_src/entrypointSshd.sh" "/dockerEntrypoint.sh"
COPY "$vmfileDir/_src/sshKey/" "/etc/ssh/"

RUN pacman -Sy --noconfirm grep openssh

EXPOSE 8022
ENTRYPOINT ["/dockerEntrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

