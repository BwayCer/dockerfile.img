船塢工人文件
=======


> 養護工： 張本微 <bwaycer@gmail.com> (https://bwaycer.github.io)

那**建築**的**相片**， 我**跑**在裡面。



**頁籤**<br>
　- [容器文件](#容器文件) -<br />
　- [專案目錄結構](#專案目錄結構) - [推薦相關文章](#推薦相關文章) -



## 容器文件


* [mizarch](./mizarch) : 以 Archlinux 打造可攜帶並隔離主環境的開發測試環境。
* [mizin](./mizin)     : 以 Alpine 打造可攜帶並隔離主環境的開發測試環境。
* [sshentry](./sshentry) : 建立可使用安全殼連線容器。



## 專案目錄結構


```
─┬ 專案目錄/
 └─┬ vmfile/ ------------------------------ (相當於本專案中個別的主題目錄)
   └─┬ <itemName ...>/ -------------------- -- 容器項目名稱
     ├─┬ bin/ ----------------------------- -- -- 可執行文件目錄。
     │ └── build.sh ----------------------- -- -- -- 主要的建立虛擬環境腳本。
     ├── repo/ ---------------------------- -- -- 資源目錄。
     ├── [otherName.dockerfile ...] ------- -- -- 其他的船塢工人文件。
     ├── Dockerfile ----------------------- -- -- 主要的船塢工人文件。
     ├── build.sh ------------------------- -- -- link -> ./bin/build.sh
     └── [.dockerignore] ------------------ -- -- 船塢工人忽略文件。
```



## 推薦相關文章


* [如何写Dockerfile，Dockerfile 参考文档 | Deepzz's Blog](https://deepzz.com/post/dockerfile-reference.html)
* [dockerignore file | Docker Documentation](https://docs.docker.com/engine/reference/builder/#dockerignore-file)

