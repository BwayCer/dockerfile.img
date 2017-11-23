FROM base/archlinux

MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


# RUN pacman -Rs arch-install-scripts
RUN pacman -Syu --noconfirm

## 時間跟隨主機
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

RUN sed -i "s/^#\(\(en_US\|zh_TW\).UTF-8 UTF-8\)/\1/" /etc/locale.gen; \
    locale-gen
ENV LANG    zh_TW.UTF-8
ENV LC_TIME en_US.UTF-8
# ENV LC_ALL  zh_TW.UTF-8


RUN pacman -S --noconfirm \
        systemd \
        iproute2 \
        cifs-utils ntfs-3g exfat-utils \
        bash-completion vim \
        sudo \
        git tmux tree wget \
        unzip

RUN ln -s /usr/bin/vim /usr/bin/vi

