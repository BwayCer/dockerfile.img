#!/bin/sh
# 創建安全殼密鑰文件


# typeName
srcDirPath="/etc/ssh/"

set -e
for typeName in rsa dsa ecdsa ed25519
do
    ssh-keygen -t "$typeName" -f "$srcDirPath/ssh_host_${typeName}_key" -P ""
done

