FROM archlinux/base

MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


# 執行 `pacman -Syu` 出現以下錯誤訊息：
#     error: failed to update extra (no servers configured for repository)
# 請檢查：
#   1. `docker build` 是否有設置 `--network=host` 選項開啟網路權限。
#   2. /etc/pacman.d/mirrorlist 文件下是否存在鏡像站點。

# 鏡像站點： 臺灣
RUN sed -i '1i \
Server = http://ftp.tku.edu.tw/Linux/ArchLinux/$repo/os/$arch\n\
Server = https://shadow.ind.ntou.edu.tw/archlinux/$repo/os/$arch\n\
Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch\n\
Server = https://ftp.yzu.edu.tw/Linux/archlinux/$repo/os/$arch\
' /etc/pacman.d/mirrorlist
RUN cat /etc/pacman.d/mirrorlist


## 時間跟隨主機
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

RUN sed -i "s/^#\(\(en_US\|zh_TW\).UTF-8 UTF-8\)/\1/" /etc/locale.gen; \
    locale-gen
ENV LANG    zh_TW.UTF-8
ENV LC_TIME en_US.UTF-8
# ENV LC_ALL  zh_TW.UTF-8


# RUN pacman -Rs arch-install-scripts
RUN pacman -Syu --noconfirm pacman
RUN pacman -Syu --noconfirm
RUN yes "" | sed '1,3s/^/n/' | pacman -S base base-devel bash-completion vim \
    --ignore filesystem \
    --ignore vi \
    --ignore nano


RUN pacman -S --noconfirm openssh
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN systemctl enable sshd.service

# 常用程式包
RUN pacman -S --noconfirm \
        sudo git tmux wget tree \
        python p7zip cifs-utils
        # openssh 為 git 與遠程端通訊的工具
        # python 為 vim 程式包的依賴
        # cifs-utils 為 mount.cifs 共享遠程文件掛載工具

