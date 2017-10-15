私有雲
=======


> **版　本：** v1.0.0<br />
> **維護者：** 張本微 (https://github.com/BwayCer/image.docker/blob/master/owncloud.centos/)<br />
> **基底映像：** [bwaycer/enable-systemd.centos:latest](https://hub.docker.com/r/bwaycer/enable-systemd.centos/)<br />
> **拉取映像：** [`docker pull bwaycer/owncloud.centos`](https://hub.docker.com/r/bwaycer/owncloud.centos/)



## 簡介


雲端硬碟 [ownCloud](https://owncloud.org/) 程式應用。



## 使用說明


```sh
# 運行容器
$ docker run --name owncloud.centos -td \
      --security-opt seccomp=unconfined \
      --tmpfs /run \
      -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
      -v /home/ownCloudData/:/var/www/html/data/ \
      -p 38081:80 \
      bwaycer/owncloud.centos /usr/sbin/init
# 登入容器
$ docker exec -it owncloud.centos bash
```



## 參考


* [XYZ的筆記本: CentOS 7 安裝 PHP 7](http://xyz.cinc.biz/2015/12/centos7-install-php7.html)
* [How to Install MySQL on CentOS 7](https://www.linode.com/docs/databases/mysql/how-to-install-mysql-on-centos-7)
* [RHEL / CentOS 7 自建雲端硬碟 — OwnCloud – Linux 技術手札](https://www.phpini.com/linux/rhel-centos-7-create-private-cloud-storage-owncloud)

