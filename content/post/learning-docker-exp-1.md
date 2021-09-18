---
author: "Dake Hong"
title: "Docker自學紀錄 #0：Docker介紹與安裝"
date: 2021-09-18T21:33:17+08:00
category: "Docker自學紀錄"
tags: [
    "Docker",
    "AWS EC2"
]
---
Docker算是目前許多企業都有在使用的容器化系統。它支援了相當多的Linux平台(Ubuntu、CentOS、Fedora等)，也支援了許多雲端平台，例如AWS、GCP、Azure等。另外也釋出Windows和Mac OS X的桌面版本。
<!--more-->
## 主機規格資訊
我是使用[AWS EC2](https://aws.amazon.com/tw/ec2)的主機(當然也可以用實體主機來操作)，以下是執行個體的規格：
- Instance Type: **t2.micro**
  - CPU: 1 (Intel(R) Xeon(R) CPU)
  - RAM: 1GiB
- Storage Volume Type: **GP2 (EBS)**
  - Size: 20GiB
  - IOPS: 100
- Operaing System: **Ubuntu 18.04**
  - AMI: [Ubuntu 18.04 LTS - Bionic](https://aws.amazon.com/marketplace/pp/prodview-pkjqrkcfgcaog?sr=0-1&ref_=beagle&applicationId=AWSMPContessa)
    - Version: Ubuntu 18.04 20210907
  - _Price of software is FREE!!_

我的EC2執行個體是採用 **隨遠隨用(On-demand)** 方案的，且機器並不是開24hr/7d的，一周平均大約10~40小時左右，所以價格上也是相當便宜(US$0.5~US$2.0 per month)，再加上EBS的價格，頂多US$4.0/month。

## 安裝Docker (On Ubuntu)
(option) 如果先前機台有安裝docker的話，先卸載它，以免出問題：
```bash
sudo apt-get remove docker docker-engine docker.io
```
更新apt套件索引：
```bash
sudo apt-get update
```
安裝以下套件允許apt可以透過HTTPS來使用repository(倉庫)：
```bash
sudo apt-get install \
apt-transport-https \
ca-certigicates \
curl \
software-properties-common
```
加上Docker的官方GPG key：
```bash
curl -fsSl https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
這時候輸入 `sudo apt-key list` 可以看到有一組屬於docker的fingerprint：
```bash
# === [THIS IS OUTPUT] ===
/etc/apt/trusted.gpg
--------------------
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```
之後使用stable通道新增Docker的apt倉庫：
```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable "
```
再次更新apt套件索引，讓它可以將剛加進去的倉庫包含進去：
```bash
sudo apt-get update
```
安裝最新版本的Docker CE：
```bash
sudo apt-get install docker-ce
```
安裝完成後，可以輸入 `docker --version` ：
```bash
# === [THIS IS OUTPUT] ===
Docker version 20.10.8, build 3967b7d
```

## Docker常用關鍵字
**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Image (映像檔)" br_="0">}}**
* 唯讀樣板，執行後會變成容器(container)
* 這個概念是以一個作為基礎映像檔，在層層往上疊加
  * 而 **層(layers)** 是被逐次疊加在基礎映像檔上方建立一個單一聚合檔案系統

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Registry (註冊伺服器)" br_="0">}}**
* 保存Docker映像檔的地方
* 有公開也有私人的 (視上傳/下載映像檔的地方而定)
  * 公開的Registry叫做 **[Docker Hub](https://hub.docker.com/)**

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Index" br_="0">}}**
* 用來管理使用者管理使用者的帳戶、權限、搜尋、標記等

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Containers (容器)" br_="0">}}**
* 執行了由基礎映像檔和把各層映像檔疊加在一起的映像檔所建立的
  * 包含執行應用程式所需的所有東西
* 啟動容器後，會加上一個暫時層，如果在停止容器前沒做commit的動作，此層就會被刪除
  * 如果有做commit，就會被再建立另外一層上去

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Repository (倉庫)" br_="0">}}**
* 為映像檔的集合，可以被GUID追蹤
* 不同版本的映像檔可以使用多個標籤來管理
  * 都會被儲存不同的GUID