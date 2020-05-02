#!/bin/bash
# 建立安全殼映像文件的函式庫


fnSshKeyGenerator() {
    local typeName cmdList
    local srcDirPath="$projectDir/repo/sshKey"

    [ -d "$srcDirPath" ] && return

    cmdList=("mkdir" "-p" "$srcDirPath")
    fnBuild_log "-> ${cmdList[*]}"
    "${cmdList[@]}"

    for typeName in rsa dsa ecdsa ed25519
    do
        cmdList=("ssh-keygen" "-t" "$typeName" "-f" "$srcDirPath/ssh_host_${typeName}_key" "-P" "")
        fnBuild_log "-> ${cmdList[*]}"
        "${cmdList[@]}"
    done
}
fnSshKeyGenerator

