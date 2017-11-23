閩式拱門
=======


> **版　本：** v1.0.0<br />
> **維護者：** 張本微 (https://github.com/BwayCer/image.docker/blob/master/mizarch/)<br />
> **基底映像：** [base/archlinux:latest](https://hub.docker.com/r/base/archlinux/)<br />
> **拉取映像：** [`docker pull bwaycer/mizarch`](https://hub.docker.com/r/bwaycer/mizarch/)



## 簡介


本微與拱門林納斯。



## 使用說明


```sh
# 運行容器
docker run --name mizarch -td \
    -v /home/dockerc/:/dockerc/ \
    -v /home/bwaycer/ys/:/home/ys/ \
    -v /srv/:/srv/ \
    -p 8081:8081 \
    -p 8082:8082 \
    -p 8083:8083 \
    -p 8080:4000 \
    bwaycer/mizarch
# 環境建置
docker exec -it mizarch /dockerc/.run envbase
# 登入容器
docker exec -it mizarch bash
```

