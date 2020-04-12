# /bin/bash

set -ex

for argu in "$@"
do
    case "$argu" in
        rclone )
            # https://wiki.alpinelinux.org/wiki/Rclone
            pkgName="rclone-current-linux-amd64"
            pkgVName="rclone-*-linux-amd64"
            cd /tmp
            curl -O "https://downloads.rclone.org/$pkgName.zip"
            7z x "$pkgName.zip"
            ls -al $pkgVName
            chown root:root $pkgVName/rclone
            chmod 755 $pkgVName/rclone
            mv $pkgVName/rclone /usr/bin/
            mkdir -p /usr/share/man/man1
            mv $pkgVName/rclone.1 /usr/share/man/man1/
            # makewhatis /usr/share/man
            rm -rf "$pkgName.zip" $pkgVName
            ;;
    esac
done

