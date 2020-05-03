#!/bin/bash
# 建立映像文件

set -e

projectDir=$(realpath "$(dirname "$(realpath "$0")")/..")

_shBase_loadfile="$projectDir/bin/build.lib.sh"
[ -x "$projectDir/bin/build.lib.sh" ] &&
    source "$projectDir/bin/build.lib.sh" ||
    source <(curl "https://raw.githubusercontent.com/BwayCer/image.docker/tree/master/bin/build.lib.sh")

fnBuild "$@" -t "local/mizin:bwaycer"  -f "$projectDir/bwaycer.dockerfile"  "$projectDir"
fnBuild "$@" -t "local/mizin:sshentry" -f "$projectDir/sshentry.dockerfile" "$projectDir"
fnBuild "$@" -t "local/mizin:latest"   -f "$projectDir/Dockerfile"          "$projectDir"

