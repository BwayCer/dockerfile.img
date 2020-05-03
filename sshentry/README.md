安全殼入口
=======


> **版　本：** v1.6.0



## 標籤資訊


* [`archlinux`](./archlinux.dockerfile)
* [`alpine`](./alpine.dockerfile)



## 簡介


建立可使用安全殼連線容器。



## 使用說明


```
# 建立安全殼入口容器
docker run -td \
    -v ~/.ssh/authorized_keys:/sshAuthorizedKeys \
    -p 8022:8022 \
    local/sshEntry:<tag>

# 安全殼連線
ssh -p 8022 -i <安全殼金鑰文件路徑> [user@]<ip/hostname>
```

