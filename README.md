船塢工人文件
=======


> 養護工： 張本微 <bwaycer@gmail.com> (https://bwaycer.github.io)

那**建築**的**相片**， 我**跑**在裡面。


**建議專案目錄結構：**

```
─┬ 專案目錄/
 ├─┬ vmfile/ ---------------------------- (相當於本專案中個別的主題目錄)
 │ ├─┬ _bin/ ---------------------------- 可執行文件目錄。
 │ │ └── build.sh ----------------------- 主要的建立虛擬環境腳本。
 │ ├── _src/ ---------------------------- 船塢工人文件資源目錄。
 │ ├── [otherName.dockerfile ...] ------- 其他的船塢工人文件。
 │ ├── Dockerfile ----------------------- 主要的船塢工人文件。
 │ └── build.sh ------------------------- `vmfile/_bin/build.sh` 路徑的鏈結文件。
 └── .dockerignore
```

**見更多相關文章：**
  * [如何写Dockerfile，Dockerfile 参考文档 | Deepzz's Blog](https://deepzz.com/post/dockerfile-reference.html)
  * [.dockerignore](https://docs.docker.com/engine/reference/builder/#dockerignore-file)

