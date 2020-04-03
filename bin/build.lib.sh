#!/bin/bash
# 建立映像文件的函式庫

# [[USAGE]] [`docker build` 的旗標選項] <建立映像時的範圍目錄路徑>
# [[OPT]]
#   -t, --tag <容器標籤名稱>               同 `docker build --tag` 的旗標選項。
#       --ignore-file <忽略列舉文件路徑>   在範圍目錄下建立忽略列舉文件的鏈結。
#   -h, --help                             幫助。


##shStyle 函式庫


fnBuild() {
    set -e

    # 檢查依賴命令
    local cmd
    for cmd in realpath docker
    do
        type $cmd &> /dev/null || fnBuild_throw "找不到 \`$cmd\` 命令"
    done

    local opt_tag=""
    local opt_ignoreFile=""
    local opt_carryOpt=()

    while [ -n "y" ]
    do
        case "$1" in
            -t | --tag )
                [ -z "$2" ] && fnBuild_throw_optRtn4 "$1"

                opt_tag="$2"
                shift 2
                ;;
            --ignore-file )
                [ -z "$2" ] && fnBuild_throw_optRtn4 "$1"

                opt_ignoreFile="$2"
                shift 2
                ;;
            -h | --help ) sed -n "2,9p" "$fnBuild__filename" && exit
                ;;
            * )
                [ -n "$1" ] || break

                if [ -z "$2" ]; then
                    opt_carryOpt+=("$1")
                    shift
                else
                    opt_carryOpt+=("$1" "$2")
                    shift 2
                fi
                ;;
        esac
    done

    while [ -n "y" ]
    do
        [ -z "`
            docker images --format "{{.ID}}" --filter reference="$opt_tag" \
            2> /dev/null
        `" ] && break || {
            local askTxt defaultName newName
            askTxt="\"$opt_tag\" 映像文件已存在，請選擇 "
            askTxt+="( mv: 更改名稱 ; rm: 刪除 ; next: 跳過本次建立映像 ; *exit: 退出 )"
            fnPrompt_ask "$askTxt" "|mv|m|$_br|rm|r|$_br|next|n|$_br|exit|e|" "exit" 1
            case "$rtnPrompt" in
                m | mv )
                    defaultName="$opt_tag-`date -u +"%Y%m%dT%H%M%S"`"
                    printf "mv %s to ? (default %s) : " "$opt_tag" "$defaultName"
                    read newName
                    [ -n "$newName" ] || newName=$defaultName
                    docker tag "$opt_tag" "$newName"
                    docker rmi "$opt_tag"
                    ;;
                r | rm )
                    docker rmi "$opt_tag"
                    ;;
                n | next )
                    return
                    ;;
                e | exit )
                    exit 1
                    ;;
            esac
        }
    done

    local scopePath
    local lnCmdList=()
    if [ -n "$opt_ignoreFile" ]; then
        [ -f "$opt_ignoreFile" ] || fnBuild_throw "找不到 \"$opt_ignoreFile\" 忽略列舉文件"

        scopePath=${opt_carryOpt[${#opt_carryOpt[@]} - 1]}
        [ -d "$scopePath" ] || fnBuild_throw "找不到 \"$scopePath\" 範圍目錄"

        lnCmdList+=("ln" "-s" "`realpath "$opt_ignoreFile"`")
        lnCmdList+=("`realpath "$scopePath"`/.dockerignore")

        fnBuild_log "create link: ${lnCmdList[3]} -> ${lnCmdList[2]}"
        "${lnCmdList[@]}"
    fi

    local dockCmdExitCode=0
    local dockCmdList=("docker" "build")
    dockCmdList+=("--tag" "$opt_tag" "${opt_carryOpt[@]}")
    fnBuild_log "\$ ${dockCmdList[*]}<ENTER>"
    set +e
    "${dockCmdList[@]}"
    dockCmdExitCode=$?
    set -e

    if [ -n "$lnCmdList" ]; then
        fnBuild_log "clear link: ${lnCmdList[3]}"
        rm "${lnCmdList[3]}"
    fi
    [ $dockCmdExitCode -eq 0 ] || exit $dockCmdExitCode

    set +e
}
fnBuild_log() {
    local msg="$1"
    local formatArgus="[$fnBuild_fileName]: %s$_br"
    printf "$formatArgus" "$msg"
}
fnBuild_throw() {
    local msg="$1"
    fnBuild_log "$msg" >&2
    exit 1
}
fnBuild_throw_optRtn4() {
    local opt="$1"
    fnBuild_throw "不符合 \"$opt\" 選項的預期值。"
}

rtnPrompt=""
fnPrompt_ask() {
    local txtQuestion="$1"
    local txtList="$2"
    local defaultOption="$3"
    local loopTimes=$4

    local tmpCho

    while [ -n "y" ]
    do
        printf "%s : " "$txtQuestion"
        read tmpCho

        if [ -n "$defaultOption" ] && [ -z "$tmpCho" ]; then
            rtnPrompt="$defaultOption"
        elif [ -n "$defaultOption" ] && [ $loopTimes -ge 3 ]; then
            rtnPrompt="$defaultOption"
        elif [[ ! "$tmpCho" =~ "|" ]] && [[ "$txtList" =~ "|$tmpCho|" ]]; then
            rtnPrompt=`grep "|$tmpCho|" <<< "$txtList" | cut -d "|" -f 2`
        else
            loopTimes=$((loopTimes + 1))
            continue
        fi
        break
    done
}


##shStyle ###


_br="
"

if [ -n "$_shBase_loadfile" ]; then
    fnBuild__filename=$_shBase_loadfile
    fnBuild_fileName=`basename "$_shBase_loadfile"`
else
    fnBuild__filename=$0
    fnBuild_fileName=`basename "$0"`

    fnBuild "$@"
fi

