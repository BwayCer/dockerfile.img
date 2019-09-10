#!/bin/sh
# sshd 船塢工人入口


##shStyle 介面函式


fnEntrypoint() {
    whoami 1> /dev/null || exit 1

    fnInsertSshdConfig "Port 8022" "#Port 22"
    fnInsertSshdConfig "PasswordAuthentication no" "#PasswordAuthentication"

    mkdir "$HOME/.ssh" &&
        chmod 700 /root/.ssh &&
        cp /sshAuthorizedKeys "$HOME/.ssh/authorized_keys" &&
        chmod 600 "$HOME/.ssh/authorized_keys"

    exec "$@"
}


##shStyle 函式庫


fnInsertSshdConfig() {
    local insertTxt="$1"
    local key="$2"

    local sshdConfigPath="/etc/ssh/sshd_config"

    tmpLineNum=`grep -nm 1 "^$key" "$sshdConfigPath" | sed "s/^ *\([0-9]\+\):.*$/\1/"`
    [ -n "$tmpLineNum" ] \
        && sed -i "${tmpLineNum}a $insertTxt" "$sshdConfigPath" \
        || echo "$insertTxt" >> "$sshdConfigPath"
}


##shStyle ###


fnEntrypoint "$@"

