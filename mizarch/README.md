閩式拱門
=======


> **版　本：** v2.0.0

> **基底映像：** [archlinux/base:latest](https://hub.docker.com/r/archlinux/base/)

> **拉取映像：** [`docker pull bwaycer/mizarch`](https://hub.docker.com/r/bwaycer/mizarch/)



## 簡介


本微與拱門林納斯。



## 問題


### 增加鏡像站點問題

由於在本地 `pacman -Syu` 會有以下訊息：

```
error: failed to update extra (no servers configured for repository)
```

解決方法是更改鏡像站，但船塢工人中心缺少 `rankmirrors` 命令，所以以下命令請自行設定：

```
echo '
Server = http://ftp.tku.edu.tw/Linux/ArchLinux/$repo/os/$arch
Server = https://shadow.ind.ntou.edu.tw/archlinux/$repo/os/$arch
Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch
Server = https://ftp.yzu.edu.tw/Linux/archlinux/$repo/os/$arch
' | rankmirrors -n 3 - >> /etc/pacman.d/mirrorlist
```



### base 安裝包安裝失敗

需先執行 `RUN pacman -Syu pacman` 命令安裝 `pacman` 工具。

然後避開特定安裝包，目前已知如下：

  * `filesystem`
