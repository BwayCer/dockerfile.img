#!/bin/sh
# 以插入方式修改安全殼設定文件

# /bin/sh 無法使用 Array (ex: `args=("$@")`)


# val prevVal insertTxt key lineNum
sshdConfigPath="/etc/ssh/sshd_config"

for val in "$@"
do
    [ -n "$prevVal" ] || {
        prevVal="$val"
        continue
    }

    insertTxt="$prevVal"
    key="$val"
    prevVal=""

    lineNum=`grep -nm 1 "^$key" "$sshdConfigPath" | sed "s/^ *\([0-9]\+\):.*$/\1/"`
    [ -n "$lineNum" ] \
        && sed -i "${lineNum}a $insertTxt" "$sshdConfigPath" \
        || echo "$insertTxt" >> "$sshdConfigPath"
done

