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


# 安裝基礎程式包
# RUN pacman -Rs arch-install-scripts
RUN pacman -Sy --noconfirm pacman
RUN pacman -S --noconfirm vim

