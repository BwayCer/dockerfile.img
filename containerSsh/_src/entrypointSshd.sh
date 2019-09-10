#!/bin/sh
# sshd 船塢工人入口


##shStyle 介面函式


fnEntrypoint() {
    whoami 1> /dev/null || exit 1

    mkdir "$HOME/.ssh" &&
        chmod 700 /root/.ssh &&
        cp /sshAuthorizedKeys "$HOME/.ssh/authorized_keys" &&
        chmod 600 "$HOME/.ssh/authorized_keys"

    exec "$@"
}


##shStyle ###


fnEntrypoint "$@"

