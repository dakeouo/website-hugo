---
author: "Dake Hong"
title: "專題紀錄-數字華容道 #5：使用GCP Cloud Run部署Flask APP"
date: 2021-11-15T15:35:10+08:00
category: "專題紀錄-數字華容道"
tags: [
	"Docker",
    "GCP",
    "GCP Cloud Build",
    "GCP Cloud Run",
]
---
在上一篇，我們使用AWS Fargate來部署Docker Image，使我們用public IP就可以存取到我們的Flask-based網站。而這篇，我們要使用GCP雲端平台，來部署Docker Image。
<!--more-->
## [Part 5-1] 將Docker Image建立於Cloud Build中
由於我們如果要使用Cloud Run來部署Docker Image的話，就需要使用Cloud Build裡面的repository，所以我們就需要再使用Dockerfile將Docker Image建立於Cloud Build中。

第一步驟，就是先把程式原始碼下載下來。
{{< img_imgur 5e2uvCr 100 >}}

接下來，使用`gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/[IMAGE_NAME]:[IMAGE_TAG] .`來打包Cloud Build映像檔
{{< img_imgur qxX6hPY 100 >}}

完成之後，我們看到Cloud Build頁面有我們剛剛打包過後的紀錄
{{< img_imgur vnXvOE4 100 "#aaa">}}

## [Part 5-2] 部署容器至Cloud Run中
到Cloud Build頁面，點選"建立服務"
{{< img_imgur nrw5hpo 100 "#aaa">}}

選取容器映像檔，點選"選取"，在右側選擇我們剛剛建立的映像檔，並按下"選取"
{{< img_imgur hi7cy5e 100 "#aaa">}}

系統會自動代入registry的名稱成為服務名稱。之後在區域的下拉式選單選擇你要部署的區域，像是離我們最近的區域就是 **asia-east1 (台灣)** 。在自動配置的部分，因為我們目前不用去顧慮HA(高可用性)，所以 **執行個體數上限** 改成1即可。
{{< img_imgur Hh7U5Ni 100 "#aaa">}}

接下來，下拉"進階設定"，在 **容器通訊埠** 改成5000(因為我們flask預設端口就是5000)，CPU與記憶體的容量請依需求而更改，這邊因為為示範用，所以全部改成最小容量(1 CPU / 128MiB RAM)。
{{< img_imgur di3kcnC 100 "#aaa">}}

接下來，按下"下一步"，勾選流量與驗證的設定，請分別勾選 **允許所有流量** 與 **允許在未經驗證的情況下叫用** ，之後按下"建立"就會開始進行部署。
{{< img_imgur 6x3c0RP 100 "#aaa">}}

正在部署的畫面
{{< img_imgur RemOiaq 100 "#aaa">}}
部署完成後，會看到以下畫面
{{< img_imgur vRbvK7C 100 "#aaa">}}

這時，我們會看到它產生了一組網址，將該組網址貼上網址列，即可看到我們部署的結果
{{< img_imgur PD98qpw 90 "#aaa">}}

---
**{{< colorful_text color_="100, 100, 100" font_size="1.25" text_="參考來源" br_="0">}}**
- [[GCP] Cloud Run 六個實作: 解析麻雀雖小五臟俱全 | Cloud Run is Small but Complete | 黃大仙的雲端修行室](https://joehuang-pop.github.io/2020/05/01/GCP-Cloud-Run-%E5%85%AD%E5%80%8B%E5%AF%A6%E4%BD%9C-%E8%A7%A3%E6%9E%90%E9%BA%BB%E9%9B%80%E9%9B%96%E5%B0%8F%E4%BA%94%E8%87%9F%E4%BF%B1%E5%85%A8-Cloud-Run-is-Small-but-Complete/)