基礎環境
=======


> **版　本：** v1.1.0<br />
> **維護者：** 張本微 (https://github.com/BwayCer/image.docker/blob/master/envbase.centos/)<br />
> **基底映像：** [bwaycer/enable-systemd.centos:latest](https://hub.docker.com/r/bwaycer/enable-systemd.centos/)<br />
> **拉取映像：** [`docker pull bwaycer/envbase.centos`](https://hub.docker.com/r/bwaycer/envbase.centos/)



## 簡介


關於我的 CentOS 基礎環境。



## 使用說明


```sh
# 運行容器
$ docker run --name envbase.centos -td \
      --security-opt seccomp=unconfined \
      --tmpfs /run \
      -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
      -v /home/vhost/:/home/bwaycer/ \
      -p 8080:4000 \
      bwaycer/envbase.centos /usr/sbin/init
# 環境建置
$ docker exec -d envbase.centos /home/bwaycer/dockerEnvtree.sh
# 登入容器
$ docker exec -it envbase.centos /home/bwaycer/dockerEnvtree.sh login
```

