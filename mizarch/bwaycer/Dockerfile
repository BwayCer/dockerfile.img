FROM bwaycer/mizarch:base

MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


# 在非 PID 1 init 進程中調用 systemctl 命令會以 `exit 1` 退出並顯示以下訊息：
# ```
# System has not been booted with systemd as init system (PID 1). Can't operate.
# Failed to connect to bus: Host is down
# ```
RUN cp "/bin/systemctl" "/bin/systemctl.real" && \
    echo "echo In Docker." > "/bin/systemctl"


## 臺北時間
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

## 中文語系
RUN echo -e "en_US.UTF-8 UTF-8\nzh_TW.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=zh_TW.UTF-8 \
    LC_TIME=en_US.UTF-8
# ENV LC_ALL=zh_TW.UTF-8


RUN pacman -Syu --noconfirm && \
    yes "" | sed "1,3s/^/n/" | pacman -S base base-devel bash-completion vim \
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

# visudo
#   # %wheel ALL=(ALL) NOPASSWD: ALL
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 用戶
RUN useradd -m -u 1000 -G wheel bwaycer

