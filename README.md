啟用系統精靈
=======


> 版本： v1.0.0<br />
> 作者： 張本微 <bwaycer@gmail.com> (https://bwaycer.github.io/about/)<br />
> 授權： [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.zh_TW)



## 簡介


**底層映像：** [centos:latest](https://hub.docker.com/_/centos/)<br />
**描　　述：** 啟用系統精靈 `systemd`。<br />
<br />


解決 `systemctl` 命令遇到 `Failed to get D-Bus connection: Operation not permitted` 的問題，
關於其問題說明可參考 [DockOne.io 文章](http://dockone.io/question/729) 。

參考解決方法：

  * [GitHub: docker-library/docs](https://github.com/docker-library/docs/tree/master/centos/README.md)
  * [GitHub: solita/docker-systemd](https://github.com/solita/docker-systemd/blob/centos-7/README.md)



## 使用說明


除了參考官方提供方法外， 你還會遇到
`[!!!!!!] Failed to mount API filesystems, freezing.` 的問題，
這時你需要在 `docker run` 上增加幾個選項來解決：

```sh
$ docker run --name <your-container-name> -td \
      --security-opt seccomp=unconfined \
      --tmpfs /run \
      -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
      bwaycer/enable-systemd.centos
$ docker exec -it <your-container-name> bash
```


**選項說明：**

禁用 `seccomp`， 因為 `systemd` 使用了未被船塢工人允許的 `seccomp` 配置文件 profile：

```
--security-opt seccomp=unconfined
```


CentOS 的 `systemd` 期望 `/run` 是 `tmpfs` file system, but it can't
mount the file system itself in an unprivileged container:

```
--tmpfs /run
```

相關資訊見：
  [Docker 文件： Use tmpfs mounts](https://docs.docker.com/engine/admin/volumes/tmpfs/)
  。


`systemd` 需要只讀權限去訪問核心 kernel 的 cgroup 層級：

```
-v /sys/fs/cgroup:/sys/fs/cgroup:ro
```

相關資訊見：
  [Docker 文件： Use volumes](https://docs.docker.com/engine/admin/volumes/volumes/)
  。

