#!/bin/bash
# 建立映像文件


##shStyle ###


__filename=`realpath "$0"`
_dirsh=`dirname "$__filename"`

source "$_dirsh/build.lib.sh"


##shStyle 介面函式


fnBuild() {
    local opt_update=0

    while [ -n "y" ]
    do
        case "$1" in
            -u | --update )
                opt_update=1
                shift
                ;;
            * ) break ;;
        esac
    done

    fnBuild_log "-> cd \"$projectDir\""
    cd "$projectDir"

    local archlinuxVmfile="$vmFileDirName/archlinux.dockerfile"
    local archlinuxImgName="local/containerssh:archlinux"

    local imgMethod
    [ $opt_update -eq 0 ] && imgMethod="check:Image" || imgMethod="check:ImageUpdate"
    fnBuild_checkDocker "check:docker" \
        "check:vmfile" "$archlinuxVmfile" \
        "$imgMethod" "$archlinuxImgName"

    fnSshKeyGenerator
    fnBuild_run --network host -t "$archlinuxImgName" -f "$archlinuxVmfile" .
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


##shStyle ###


fnBuild "$@"

