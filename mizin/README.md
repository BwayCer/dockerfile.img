閩式山小
=======


> **版　本：** v1.0.0

> **基底映像：** [alpine:latest](https://hub.docker.com/_/alpine)

> **建立映像：** local/mizin:latest



## 簡介


本微與高山，
打造可攜帶並隔離主環境的開發測試環境。



## 問題


### `--no-cache` 的使用時機


參考
[此篇 Stack Overflow 文章](https://stackoverflow.com/questions/49118579)
所述，
程式包的安裝優先使用本地緩存索引來查找，
而 `--no-cache` 則不受此限制，
故 `apk add --no-cache` 相當於 `apk update && apk add`，
在維持較小的容器相當有用。



### 最小化的安裝準則


Alpine 是一個 Linux 的毛胚，
很多命令都和習慣中的想像有點出入，
但這就是 Alpine，
很多時候只要更新程式包就完事了，
不過秉持最小化的原則，
只在遇到需求時才來安裝或更新。

  * `less`: 部分中文缺字及沒有顏色問題。
  * `git-perl`: 無法使用 `git add -p` 問題。
      (見 [issues/2877 文章](https://gitlab.alpinelinux.org/alpine/aports/issues/2877)。)

_只要記錄一些較看不出來安裝或更新能解決的事件_

