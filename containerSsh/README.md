安全殼容器
=======


> **版　本：** v1.0.0



## 標籤資訊


* [`alpine`](./alpine.dockerfile)
* [`archlinux`](./archlinux.dockerfile)
* [`mizarch`](./mizarch.dockerfile)



## 使用說明


```
docker run -td \
    -v ~/.ssh/authorized_keys:/sshAuthorizedKeys \
    --network host \
    local/containerssh:<tag>

# or

docker run -td \
    -v ~/.ssh/authorized_keys:/sshAuthorizedKeys \
    -p 8022:8022 \
    --network container:<name> \
    local/containerssh:<tag>
```

