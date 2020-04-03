閩式拱門
=======


> **版　本：** v2.1.0

> **基底映像：** [archlinux/base:latest](https://hub.docker.com/r/archlinux/base/)

> **拉取映像：** [`docker pull bwaycer/mizarch`](https://hub.docker.com/r/bwaycer/mizarch/)



## 簡介


本微與拱門林納斯。



## 問題


### 官方映像問題


官方映像 [archlinux:latest](https://hub.docker.com/_/archlinux/)
比目前使用的 [archlinux/base:latest](https://hub.docker.com/r/archlinux/base/)
的容器大小少了約 90 MB，
在輕量化上更具優勢，
但卻把語系文件刪除了，
由於目前不知道如何安裝語系文件及不清楚具體的使用差異，
故目前暫不使用。

```
# 2020.01.17 資料
REPOSITORY          SIZE
archlinux           409MB
archlinux/base      498MB
```



### 在容器內無法執行 systemctl 命令


在非 PID 1 init 進程中調用 systemctl 命令會顯示以下錯誤訊息：

```
System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to connect to bus: Host is down
```

___不推薦！___
若真有執行其必要，可參考
[GitHub gdraheim/docker-systemctl-replacement](https://github.com/gdraheim/docker-systemctl-replacement)
說明。



### 程式包無法更新


當執行 `pacman -Syu` 出現以下錯誤訊息：

```
error: failed to update extra (no servers configured for repository)
```

請先檢查：

  1. `docker build` 是否有設置 `--network host` 選項開啟網路權限。
  2. /etc/pacman.d/mirrorlist 文件下是否存在鏡像站點。


若是需要更改鏡像站文件可參考以下命令：

```
echo '
Server = http://ftp.tku.edu.tw/Linux/ArchLinux/$repo/os/$arch
Server = https://shadow.ind.ntou.edu.tw/archlinux/$repo/os/$arch
Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch
Server = https://ftp.yzu.edu.tw/Linux/archlinux/$repo/os/$arch
' | rankmirrors -n 3 - >> /etc/pacman.d/mirrorlist
```



### base 安裝包安裝失敗


**似乎已不存在此問題，但仍就再觀察一陣子**

需先執行 `RUN pacman -Syu pacman` 命令安裝 `pacman` 工具。

然後避開特定安裝包，目前已知如下：

  * `filesystem` (目前預設沒有此安裝包 (2020.01.07 更新))

