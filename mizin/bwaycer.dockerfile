# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM alpine

ARG una=bwaycer
ARG uid=1000

# 安裝常用程式包
RUN apk upgrade --no-cache && \
    apk add --no-cache \
        iproute2 tzdata ncurses grep less curl tar bash \
        bash-completion vim \
        docker sudo openssh git git-perl tmux wget tree \
        rsync p7zip cifs-utils && \
    ln -sf /usr/bin/vim /usr/bin/vi
    # iproute2 為網路工具箱。 (包含 `ss` 命令)
    # tzdata 為設置時區的程式包。
    # ncurses 為擬終端的類圖形介面工具箱，其中包含 `tput` 命令。

# visudo
#   # %wheel ALL=(ALL) NOPASSWD: ALL
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Set disable_coredump false" >> /etc/sudo.conf
    # NOTE
    # - `echo -e "Set disable_coredump false" >> /etc/sudo.conf`
    #   是為處理 `sudo: setrlimit(RLIMIT_CORE): Operation not permitted` 問題

# 臺北時間
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# ## 中文語系
# RUN echo -e "en_US.UTF-8 UTF-8\nzh_TW.UTF-8 UTF-8" > /etc/locale.gen && \
    # locale-gen
# ENV LANG=zh_TW.UTF-8 \
    # LC_TIME=en_US.UTF-8
# # ENV LC_ALL=zh_TW.UTF-8

# 用戶
RUN adduser --uid "$uid" -h "/home/$una" --disabled-password "$una" && \
    for groupName in wheel docker; do addgroup "$una" "$groupName"; done

