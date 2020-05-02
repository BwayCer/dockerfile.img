#!/bin/bash
# 建立安全殼映像文件的函式庫


##shStyle ###


fnBuild_sshKeyName="$1"


##shStyle 介面函式


fnBuild() {
    local opt_update=0

    while [ -n "y" ]
    do
        case "$1" in
            -name )
                opt_update=1
                shift
                ;;
            -u | --update )
                opt_update=1
                shift
                ;;
            * ) break ;;
        esac
    done

    fnBuild_log "-> cd \"$projectDir\""
    cd "$projectDir"

    local keyVmfile="$vmFileDirName/${fnBuild_sshKeyName}.dockerfile"
    local keyImgName="local/containerssh:${fnBuild_sshKeyName}"

    local imgMethod
    [ $opt_update -eq 0 ] && imgMethod="check:Image" || imgMethod="check:ImageUpdate"
    fnBuild_checkDocker "check:docker" \
        "check:vmfile" "$keyVmfile" \
        "$imgMethod" "$keyImgName"

    fnSshKeyGenerator
    fnBuild_run --network host -t "$keyImgName" -f "$keyVmfile" .
}


##shStyle 函式庫


fnSshKeyGenerator() {
    local typeName cmdList
    local srcDirPath="$vmFileDirName/_src/sshKey"

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

