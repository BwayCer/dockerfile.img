# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM local/mizarch:bwaycer

ARG sshExposePort=8022

RUN pacman -Sy --noconfirm grep openssh

# 修改安全殼設定文件
RUN tmpInsertSshdConfig() { \
        local insertTxt="$1"; \
        local key="$2"; \
        local sshdConfigPath="/etc/ssh/sshd_config"; \
        local lineNum=`grep -nm 1 "^$key" "$sshdConfigPath" | sed "s/^ *\([0-9]\+\):.*$/\1/"`; \
        [ "${key:0:1}" != "#" ] && [ -n "$lineNum" ] \
            && sed -i "${lineNum}c #$key" "$sshdConfigPath" || :; \
        [ -n "$lineNum" ] \
            && sed -i "${lineNum}a $insertTxt" "$sshdConfigPath" \
            || echo "$insertTxt" >> "$sshdConfigPath"; \
    } && \
    tmpInsertSshdConfig "Port $sshExposePort" "#Port 22" && \
    tmpInsertSshdConfig "PasswordAuthentication no" "#PasswordAuthentication"
# 創建安全殼密鑰文件
RUN for typeName in rsa dsa ecdsa ed25519; do \
        ssh-keygen -t "$typeName" -f "/etc/ssh//ssh_host_${typeName}_key" -P ""; \
    done

EXPOSE $sshExposePort

