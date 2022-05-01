---
author: "Dake Hong"
title: "Docker自學紀錄 #2：Docker基礎線上課程介紹"
date: 2021-11-03T17:09:19+08:00
category: "Docker自學紀錄"
tags: [
    "Docker",
    "Github",
]
---
事隔將近兩個月，終於要來更新這個系列了!! 但這篇目前也是這個系列的最後一篇，未來暫時不會再做更新，因為這篇主要是來介紹一個在 Udemy 上的中文教學課程。
<!--more-->
而這個課程大約花費我3至4天的時間，將Docker的基礎以及其應用給學習完，包含了 __Dockerfile內容的撰寫與部屬__ 、 __Docker compose的自動化容器部屬程序__ 、 __Github Action的簡單CI實作範例__ 等。而且對於我來說，看影片學習好像比較快的關係，而且教程又是中文解說的，所以我認為這個課程物超所值。

## Udemy課程 - Docker容器技术从入门到精通
這個課程時長約16個小時，由Peng Xiao老師教授，也有這個課程的[部落格](https://www.docker.tips)。而這個授課老師除了有個人的[Github](https://github.com/xiaopeng163)，也有Youtube頻道 - [麦兜搞IT](https://www.youtube.com/channel/UCmjdhwMGSut8mZ1CqnRjjUw)，頻道裡面也放了一些其他的Web Development相關的實作教學影片。
{{< img_imgur 9p3sxNw 90 "#aaa">}}

以下介紹這個課程的各個章節
## {{< colorful_text color_="172, 90, 0" text_="1. Docker介紹和安裝">}}
介紹**Docker是甚麼?**、**跟虛擬機有甚麼差別?**，還有如何分別在Windows、Linux與MacOS系統上安裝Docker (圖片引用於[部落格](https://dockertips.readthedocs.io/en/latest/docker-install/docker-intro.html)內)
{{< img_imgur FBYQyvX 100>}}

## {{< colorful_text color_="172, 90, 0" text_="2. 容器快速上手">}}
**鏡像(image)與容器(container)**於Docker CLI的操作與比較，也比較了容器與虛擬機的差別 (圖片引用於[部落格](https://dockertips.readthedocs.io/en/latest/container-quickstart/container-vs-vm.html)內)
{{< img_imgur fLMPFSk 70>}}

## {{< colorful_text color_="172, 90, 0" text_="3. 鏡像的創建管理與發佈">}}
包含了鏡像(image)的**獲取、基本操作、不同的創建方式**等

## {{< colorful_text color_="172, 90, 0" text_="4. Dockerfile完全指南">}}
這章節是我認為**最核心的部分**，教你如何寫Dockerfile，其檔案架構有哪些指令，還有一些小技巧

## {{< colorful_text color_="172, 90, 0" text_="5. Docker的儲存">}}
教授了兩種主要如果你需要**將容器產生的資料永久保存**的方式 - **Data Volume**與**Bind Mount**。其中： (圖片引用於[部落格](https://dockertips.readthedocs.io/en/latest/docker-volume/intro.html)內)
- Data Volume是產生一個**由Docker管理**的地方(若用Linux系統，預設為/var/lib/docker/volumes/*)。
- Bind Mount是由**用戶自訂**要儲存的資料，**掛在到實體機**的甚麼地方。

{{< img_imgur RC19HF7 60>}}

## {{< colorful_text color_="172, 90, 0" text_="6. Docker的網路">}}
介紹了**Docker的網路(Network)系統**。包含**Docker Bridge/Host/null 的介紹與區別**(但以Bridge為主/Host是跟實體機共用/null就只是一個塞空缺的，沒網路功能)，還有**Docker命名空間(namespace)的使用與介紹**

## {{< colorful_text color_="172, 90, 0" text_="7. Docker Compose">}}
Docker Compose算是Docker自動化部屬的功能，包含**水平擴展、環境變量的設定、服務器健檢**等功能

## {{< colorful_text color_="172, 90, 0" text_="8. Docker Swarm">}}
Docker Swarm這個章節我還沒去看，主要是講述**跨實體機**的容器管理。

## {{< colorful_text color_="172, 90, 0" text_="9. Docker vs Podman">}}
Podman比較傾向於Kubernetes的功能，他**有pod的技術**，可以**用非root的用戶**運行，且**是Daemonless的**(不像Docker需依賴後台的docker daemon)。

## {{< colorful_text color_="172, 90, 0" text_="10. Docker的多架構支持">}}
這算是一個小章節，因為我們提交image至Docker repository時，預設只支持當前實體機的硬體架構，我們可以透過一些操作設定，使自己的image可以支持多架構

## {{< colorful_text color_="172, 90, 0" text_="11. Git 和容器———— CICD">}}
本章介紹Github Action來自動部屬Dockerfile，並自動上傳至Docker Hub。當然CI/CD的工具不只有Github Action一個。 (圖片引用於[部落格](https://dockertips.readthedocs.io/en/latest/docker-cicd/intro.html)內)
{{< img_imgur aXnAauz 80>}}

## {{< colorful_text color_="172, 90, 0" text_="12. 容器安全">}}
主要講述Docker安全性的問題，包含程式碼、Dockerfile、image等的內容是否存在漏洞，而這些都分別有工具可以輔助講可能的漏洞找出來。