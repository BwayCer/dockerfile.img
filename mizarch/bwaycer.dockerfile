# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM archlinux/base

ARG una=bwaycer
ARG uid=1000

# 鏡像站點： 臺灣
RUN sed -i '1i \
Server = http://ftp.tku.edu.tw/Linux/ArchLinux/$repo/os/$arch\n\
Server = https://shadow.ind.ntou.edu.tw/archlinux/$repo/os/$arch\n\
Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch\n\
Server = https://ftp.yzu.edu.tw/Linux/archlinux/$repo/os/$arch\
' /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist

# 程式包更新
RUN pacman -Sy --noconfirm pacman && \
    pacman -Su --noconfirm
# 安裝常用程式包
RUN pacman -S --noconfirm \
        base base-devel bash-completion vim \
        docker sudo openssh git tmux wget tree \
        rsync p7zip cifs-utils && \
    ln -s /usr/bin/vim /usr/bin/vi
    # openssh 為 git 與遠程端通訊的工具
    # cifs-utils 為 mount.cifs 共享遠程文件掛載工具

# visudo
#   # %wheel ALL=(ALL) NOPASSWD: ALL
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

## 臺北時間
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

## 中文語系
RUN echo -e "en_US.UTF-8 UTF-8\nzh_TW.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=zh_TW.UTF-8 \
    LC_TIME=en_US.UTF-8
# ENV LC_ALL=zh_TW.UTF-8

# 用戶
RUN useradd -m -u "$uid" -G wheel,docker "$una"

