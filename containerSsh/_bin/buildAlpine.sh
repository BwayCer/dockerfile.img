#!/bin/bash
# 建立映像文件


##shStyle ###


__filename=`realpath "$0"`
_dirsh=`dirname "$__filename"`

source "$_dirsh/build.lib.sh"
source "$_dirsh/buildSsh.lib.sh" "alpine"


fnBuild "$@"

