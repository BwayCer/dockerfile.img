#!/bin/sh
# 以插入方式修改安全殼設定文件


##shStyle 介面函式


fnInsertSshdConfig() {
    local args

    if [ $# -eq 2 ]; then
        fnInsertSshdConfig_insert "$@"
    elif [ $(($# % 2)) -eq 0 ]; then
        args=("$@")

        for ((idx=0, len=$((${#args[@]} / 2)); idx < len ; idx++))
        do
            fnInsertSshdConfig_insert "${args[idx * 2]}" "${args[idx * 2 + 1]}"
        done
    fi
}
fnInsertSshdConfig_insert() {
    local insertTxt="$1"
    local key="$2"

    local sshdConfigPath="/etc/ssh/sshd_config"

    tmpLineNum=`grep -nm 1 "^$key" "$sshdConfigPath" | sed "s/^ *\([0-9]\+\):.*$/\1/"`
    [ -n "$tmpLineNum" ] \
        && sed -i "${tmpLineNum}a $insertTxt" "$sshdConfigPath" \
        || echo "$insertTxt" >> "$sshdConfigPath"
}


##shStyle ###


fnInsertSshdConfig "$@"


