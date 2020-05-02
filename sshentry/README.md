安全殼入口
=======


> **版　本：** v1.0.0



## 標籤資訊


* [`mizarch`](./mizarch.dockerfile)
* [`mizin`](./mizin.dockerfile)



## 簡介


建立可使用安全殼連線容器。



## 使用說明


```
docker run -td \
    -v ~/.ssh/authorized_keys:/sshAuthorizedKeys \
    --network host \
    local/sshEntry:<tag>

# or

docker run -td \
    -v ~/.ssh/authorized_keys:/sshAuthorizedKeys \
    -p 8022:8022 \
    --network container:<name> \
    local/sshEntry:<tag>
```

