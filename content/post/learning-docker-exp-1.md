---
author: "Dake Hong"
title: "Docker自學紀錄 #1：Docker基本操作指令"
date: 2021-09-19T10:49:23+08:00
category: "Docker自學紀錄"
tags: [
    "Docker",
]
---
Docker的基本操作指令包含了列出/提取映像擋、啟動/列出/刪除容器等。
<!--more-->
列出目前機器內Docker的版本資訊(指令：`docker version`)：
```bash
# === [THIS IS OUTPUT] ===
Client: Docker Engine - Community
 Version:           20.10.8
 API version:       1.41
 Go version:        go1.16.6
 Git commit:        xxxxxxx
 Built:             Mon Feb 03 12:34:56 2000
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.8
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.6
  Git commit:       xxxxxxx
  Built:            Mon Feb 03 12:34:56 2000
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.9
  GitCommit:        xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 runc:
  Version:          1.0.1
  GitCommit:        v1.0.1-0-g4144b63
 docker-init:
  Version:          0.19.0
  GitCommit:        xxxxxxx

```

## 與映像檔(Images)相關
**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="搜尋指定映像檔" br_="0">}}**
指令：`docker search [OPTIONS] TERM`
```bash
$ docker search --limit 5 ubuntu
# === [THIS IS OUTPUT] ===
NAME                                                   DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ubuntu                                                 Ubuntu is a Debian-based Linux operating sys…   12805     [OK]
rastasheep/ubuntu-sshd                                 Dockerized SSH service, built on top of offi…   255                  [OK]
ubuntu-upstart                                         DEPRECATED, as is Upstart (find other proces…   113       [OK]
1and1internet/ubuntu-16-nginx-php-phpmyadmin-mysql-5   ubuntu-16-nginx-php-phpmyadmin-mysql-5          50                   [OK]
ubuntu-debootstrap                                     DEPRECATED; use "ubuntu" instead                44        [OK]
```
欄位描述：
* NAME： 映像擋名稱
* DESCRIPTION： 映像檔的描述
* STARS： 映像擋所獲得的星星數(代表多少人喜歡這個映像檔)
* OFFICIAL： 是否為官方映像檔(由可靠來源所建立的映像檔)
* AUTOMATED： 是否為自動建立的資源(是否被推送到Github或Bitbucket時被建立的映像檔)

假設只列出超過40個星星，且是OFFICIAL的官方映像檔就可以鍵入以下指令：
```bash
docker search --filter is-official=true --filter stars=40 ubuntu
```
所得出來就會是以下結果：
```bash
# === [THIS IS OUTPUT] ===
NAME                 DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ubuntu               Ubuntu is a Debian-based Linux operating sys…   12805     [OK]
websphere-liberty    WebSphere Liberty multi-architecture images …   280       [OK]
ubuntu-upstart       DEPRECATED, as is Upstart (find other proces…   113       [OK]
open-liberty         Open Liberty multi-architecture images based…   48        [OK]
ubuntu-debootstrap   DEPRECATED; use "ubuntu" instead                44        [OK]
```
**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="提取映像檔" br_="0">}}**
指令：`docker image pull [OPTIONS] NAME[:TAG|@DIGEST]`

例如我們要提取centos映像檔(`docker image pull centos`)：
```bash
# === [THIS IS OUTPUT] ===
Using default tag: latest
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest
```
而提取的版本，通常是提取最後一個版本(latest)，如果要提取其他版本的話，可以在冒號後面打上版本：(例如要下載centos7版本的映像檔 `docker image pull centos:centos7`)
```bash
# === [THIS IS OUTPUT] ===
centos7: Pulling from library/centos
2d473b07cdd5: Pull complete
Digest: sha256:9d4bcbbb213dfd745b58be38b13b996ebb5ac315fe75711bd618426a630e0987
Status: Downloaded newer image for centos:centos7
docker.io/library/centos:centos7
```

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="列出映像檔" br_="0">}}**
指令：`docker image list`
```bash
# === [THIS IS OUTPUT] ===
REPOSITORY           TAG       IMAGE ID       CREATED        SIZE
centos               centos7   eeb6ee3f44bd   3 days ago     204MB
centos               latest    5d0da3dc9764   3 days ago     231MB
```
可以看到我們剛剛下載的兩個映像檔

## 與容器(Container)相關
**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="啟動容器" br_="0">}}**
指令：`docker container run [OPTION] IMAGE [COMMEND] [ARG...]`

例如我們要運行Centos7的映像檔作為容器：
```bash
$ docker container run -i -t --name centos7-test centos:centos7 /bin/bash
# === [THIS IS OUTPUT] ===
[root@5c0c168ac365 /]# exit
exit
```
其中，我們可以看到命令當中有一些參數：
* -i： 或是-interactice。把容器啟動在交談模式中，並保持STDIN開啟狀態。
* -t： 或是--tty。會配置一個終端機(pseudo-tty)，來執行/bin/bash指令。

如果要在結束程序時，順便把容器給移除，可以在指令加入`--rm`選項：
```bash
docker container run -i -t --rm --name centos7-test centos:centos7 /bin/bash
```

在Docker 1.2版前，不管容器因為甚麼原因而重新啟動，都需要使用restart指令來重啟它。而在Docker 1.2版後，加入一個可以重啟的策略(restart policy)的機制，加上`--restart`就可以自動的重啟容器。例如以下指令：
```bash
docker container run -i -t --restart=always centos /bin/bash
```
以下有三種重啟策略：
* no： 如果容器結束了也不會重新啟動。
* on-failure： 如果容器發生錯誤(出現非零離開碼(nonzero exit code))，就會重啟容器。
* always：不管回傳碼是甚麼，都會重啟容器。

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="列出容器" br_="0">}}**
指令：`docker container list`
```bash
# === [THIS IS OUTPUT] ===
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
可以看到目前有在運行的容器

如果要運行目前所有的容器，在命令裡加上`-l`即可：
```bash
$ docker container list -l
# === [THIS IS OUTPUT] ===
CONTAINER ID   IMAGE            COMMAND       CREATED          STATUS                      PORTS     NAMES
5c0c168ac365   centos:centos7   "/bin/bash"   16 minutes ago   Exited (0) 15 minutes ago             centos7-test
```

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="檢視容器日誌檔" br_="0">}}**
指令：`docker container logs [OPTIONS] CONTAINER`
```bash
$ docker container logs -t 5c0c168
# === [THIS IS OUTPUT] ===
[root@5c0c168ac365 /]# exit
2021-09-19T12:40:10.319219489Z exit
```
它會顯示這個容器的日誌檔，其中會顯示一些參數：
* -t： 可以取得每一行log紀錄的時間戳記。
* -f： 可以壤我們重後面的紀錄開始看。

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="停止容器的運行" br_="0">}}**
指令：`docker container stop [OPTIONS] CONTAINER [CONTAINER...]`

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="移除容器" br_="0">}}**
指令：`docker container rm [OPTIONS] CONTAINER [CONTAINER...]`

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="移除所有停止中的容器" br_="0">}}**
指令：`docker container prune [OPTIONS]`

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="將新處理程序注入到執行中的容器" br_="0">}}**
指令：`docker exec [OPTIONS] CONTAINER COMMEND [ARG...]`

**{{< colorful_text color_="192, 100, 50" font_size="1.2" text_="讀取容器中繼資料" br_="0">}}**
指令：`docker container inspect [OPTIONS] CONTAINER [CONTAINER...]`

---
**{{< colorful_text color_="100, 100, 100" font_size="1.25" text_="參考來源" br_="0">}}**
- [Docker工作現場實戰寶典 - 博客來](https://www.books.com.tw/products/0010817685)