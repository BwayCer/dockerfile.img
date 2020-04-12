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

