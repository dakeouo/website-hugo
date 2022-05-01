---
author: "Dake Hong"
title: "專題紀錄-數字華容道 #2：使用Docker容器執行程式"
date: 2021-11-05T15:10:23+08:00
category: "專題紀錄-數字華容道"
tags: [
	"Klotski",
    "Docker",
]
---
Python程式撰寫好後，接下來就是要使用到Docker，建立Dockerfile讓我們的程式成為一個映像(image)，使容器可以運行我們的程式。
<!--more-->
Docker如何下載及安裝這邊就不再多做說明了，所以就開始我們的Docker之旅吧!
## [Part 2-1] 建立Dockerfile
由於Dockerfile裡面，"一行指令"就等同於"一層容器"的概念，所以我們要盡可能的將指令縮減。不過我們目前如果要建立前篇Python檔案的話，只需要4個指令就可以了：

**{{< colorful_text color_="120, 60, 0" font_size="1" text_="1. FROM:">}}**
**匯入基底的映像檔(image)**。匯入一個python的映像檔。映像檔盡量選擇較小的來匯入(如alpine)，且版本號不要使用latest。
```bash
FROM python:3.7.12-alpine
```

**{{< colorful_text color_="120, 60, 0" font_size="1" text_="2. RUN:">}}**
**要執行的指令**。我們要建立一個名為"src"的資料夾。
```bash
RUN mkdir /src
```

**{{< colorful_text color_="120, 60, 0" font_size="1" text_="3. COPY:">}}**
**複製本地端檔案**。我們將本地端的Python檔複製到映像檔裡面。
```bash
COPY app.py /src/app.py
```

**{{< colorful_text color_="120, 60, 0" font_size="1" text_="4. CMD:">}}**
**啟動命令**。運行我們python的程式碼。
```bash
CMD ["python", "./src/app.py"]
```

最後完整的**Dockerfile**程式碼如下：
```docker
FROM python:3.7.12-alpine

RUN mkdir /src

COPY app.py /src/app.py

CMD ["python", "./src/app.py"]
```

## [Part 2-2] 建立image
我們透過"docker image build"可以來建立自己的image：
* -t, --tag: 映像檔名稱。如果要上傳到自己docker空間的話，必須要前綴自己的帳號。
* -f, --file: 要執行的"Dockerfile"。如果是其他檔名的話就會需要加上。
* 最後面的那個"."代表現在這個目錄
```bash
sudo docker image build --tag xxx/klotski-app:1.0 .
```
按下Enter後，就會開始執行
```bash
Sending build context to Docker daemon  117.8kB
Step 1/4 : FROM python:3.7.12-alpine
3.7.12-alpine: Pulling from library/python
a0d0a0d46f8b: Pull complete
c11246b421be: Pull complete
c5f7759615a9: Pull complete
6dc4dde3f226: Pull complete
9928d5d652ca: Pull complete
Digest: sha256:68dc2f52411f1071069a75c00029a0620d98139d638153cd33d029cf9810c8d6
Status: Downloaded newer image for python:3.7.12-alpine
 ---> 4d1c95b3db1c
Step 2/4 : RUN mkdir /src
 ---> Running in 1c8f56eceafe
Removing intermediate container 1c8f56eceafe
 ---> 5aaf20ec457e
Step 3/4 : COPY app.py /src/app.py
 ---> 44e08fdd44b8
Step 4/4 : CMD ["python", "./src/app.py"]
 ---> Running in 7aacbc395bd5
Removing intermediate container 7aacbc395bd5
 ---> f5a356f0478a
Successfully built f5a356f0478a
Successfully tagged xxx/klotski-app:1.0
```
建立完成後，你輸入"docker image ls"，就會看到目前你本機端映像檔的情形：
* 可以發現到，基底映像檔多大，你的映像檔的大小就是 >= 基底映像檔
```bash
REPOSITORY           TAG             IMAGE ID       CREATED         SIZE
xxx/klotski-app      1.0             f5a356f0478a   8 minutes ago   41.9MB
python               3.7.12-alpine   4d1c95b3db1c   9 days ago      41.9MB
```

## [Part 2-3] 上傳image至Docker Hub
首先，註冊/登入[Docker Hub](https://hub.docker.com/)帳號，並建立一個 Docker Repository。
{{< img_imgur a8DVKWE 100 "#aaa">}}

在終端機使用"docker login"登入自己的帳號
```bash
$ sudo docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: xxx
Password:
WARNING! Your password will be stored unencrypted in /home/ubuntu/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

使用"docker push"將image上傳至Docker Hub
```bash
$ sudo docker push xxx/klotski-app:1.0
The push refers to repository [docker.io/xxx/klotski-app]
b4bf2a73d92d: Pushed
f45cb925e72e: Pushed
4dee49c1c4f4: Mounted from library/python
45d4d0cf56eb: Mounted from library/python
619b8ea44798: Mounted from library/python
a2f23be74558: Mounted from library/python
e2eb06d8af82: Mounted from library/python
1.0: digest: sha256:35e92127f0d6fd7c3f7ae08a0c8f8ebb80f2907b1a68f3b5da53b1c00c11ee43 size: 1783
```

這時，回到Docker Hub頁面，就可以看到目前image已經上傳上來了
{{< img_imgur WLLfJJ4 100 "#aaa">}}

## [Part 2-4] image多架構支援
讓自己的image能夠支援多架構。我們在push至Docker Hub時，預設是只上傳當前本機的架構，而我們可以透過"buildx"來實現多架構。
{{< img_imgur ZeelfBM 100 "#aaa">}}

先來查看目前buildx有哪些架構：(不同的作業系統可能會有所不同)
```bash
$ sudo docker buildx ls
NAME/NODE DRIVER/ENDPOINT STATUS  PLATFORMS
default * docker
  default default         running linux/amd64, linux/386
```
新增一個buildx，並且跟docker說要直接使用它(--use)：
```bash
$ sudo docker buildx create --name mybuilder --use
mybuilder
```
這時，我們再使用"docker buildx ls"查看：(星星跑過去了!)
```bash
$ sudo docker buildx ls
NAME/NODE    DRIVER/ENDPOINT             STATUS   PLATFORMS
mybuilder *  docker-container
  mybuilder0 unix:///var/run/docker.sock inactive
default      docker
  default    default                     running  linux/amd64, linux/386
```
**{{< colorful_text color_="255, 0, 0" font_size="1" text_="(請先確認自己是否已經登入Docker帳號)">}}**執行以下命令即可產生多架構image:
```bash
$ sudo docker buildx build --push --platform linux/386,linux/amd64,linux/arm/v7,linux/arm64/v8 -t xxx/klotski-app:1.0 .
```
完成後，回到Docker Hub頁面，可以看到目前image共有4個架構：
{{< img_imgur jNJGf4Z 100 "#aaa">}}