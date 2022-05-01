---
author: "Dake Hong"
title: "專題紀錄-數字華容道 #4：使用AWS Fargate部署Flask APP"
date: 2021-11-11T20:46:32+08:00
category: "專題紀錄-數字華容道"
tags: [
	"Docker",
    "AWS",
]
---
在我們建立好Python Flask本地端網站後，我們可以將程式碼打包成Docker Image，並且我們可以使用AWS Fargate，公開讓全世界的人都可以存取。
<!--more-->
## [Part 4-1] 將Flask應用程式打包成Docker Image
由於這次我們是建立flask的Image，Dockerfile的內容較先前打包純python程式還要再多一些，而之前程式碼我也盡量避免使用原本python3沒有的套件(因為之前在打包時會一直出問題)。

以下是這次的Dockerfile程式碼：
```Dockerfile
#之前是用alpine(同版本裡面容量最小)，但後來發現slim使用pip命令不會失敗
FROM python:3.7.12-slim

# 1)安裝flask  2)建立flask群組與使用者  3)建立src資料夾  4)將src資料夾權限都給flask用
RUN pip install flask && \
    groupadd -r flask && useradd -r -g flask flask && \
    mkdir /src && \
    chown -R flask:flask /src

# 將兩個flask重要的資料夾(static, templates)複製進去
COPY static/ /src/static/
COPY templates/ /src/templates/

# 複製三個主要的pyhton檔案： klotski遊戲檔、flask核心檔、flask設定環境檔
COPY DigitalKlotski.py /src/DigitalKlotski.py
COPY app.py /src/app.py
COPY config.py /src/config.py

# 1)將工作目錄切換至src資料夾  2)指定flask運行的檔案 3)設定這個Image可以監聽的port
WORKDIR /src
ENV FLASK=app.py
EXPOSE 5000

# 運行flask命令(指定允許訪問所有主機)
CMD ["flask", "run", "-h", "0.0.0.0"]
```
建立完成後，我們就可以直接打包成Docker Image了。不過這邊要注意到一點，在Dockerfile中，我們是使用 __`flask run`__ 來運行flask APP的，所以他預設是會使用production mode來運行(雖然我程式碼裡面是由直接改成development mode)，所以在運行時會出現警告。

而目前我們[Docker Image](https://hub.docker.com/repository/docker/gcp852/klotski-app)的版本，都有做多架構的支援(buildx)，不過在建立這個版本(2.0)的時候，在ARM架構下，模擬AMD架構來打包Image會出問題；但在AMD架構下，模擬ARM架構來打包Image也是會出問題，而且問題都是一樣的，所以2.0我拆成兩個架構：
- **1.0**：純Python程式 - 無Class形式 (Linux AMD/ARM版)
- **1.1**：純Python程式 - 有Class形式 (Linux AMD/ARM版)
- **2.0**：Python Flask APP (Linux AMD版)
- **2.0-arm**：Python Flask APP (Linux ARM版)

## [Part 4-2] AWS Fargate實作
接下來，我們利用AWS ECS(Elastic Conatiner Service)，使用Docker Image來搭建Flask APP。
{{< img_imgur P9MWgy9 90 "#aaa" >}}

**{{< colorful_text color_="120, 60, 0" font_size="1.2" text_="1. 建立叢集(Cluster)" br_="0">}}**
點選 **AWS ECS > 叢集(Cluster) > 建立叢集(Create cluster)** 就會到以下畫面
{{< img_imgur 7Xl1TfN 90 "#aaa" >}}

選擇 **Networking only** 並按下 **Next step**
{{< img_imgur DEKpjKh 90 "#aaa" >}}

在 **Configure cluster** 填入叢集名稱(Cluster name)，並在 **Networking** 勾選 __Create a new VPC for this cluster__ ，下方欄位的值使用預設的就好，最後按下 **Create**
{{< img_imgur tYLw5ll 90 "#aaa" >}}

最後，會幫你建立 **VPC(Virtual Private Cloud), Internet Gateway, Route table** 等相關資源
{{< img_imgur MeB7iuo 90 "#aaa" >}}

**{{< colorful_text color_="120, 60, 0" font_size="1.2" text_="2. 建立任務定義(Task definition)" br_="0">}}**
點選 **AWS ECS > 任務定義(Task definition) > 建立新的任務定義(Create new task definition)** 就會到以下畫面

在 **任務定義組態(Configure task Definition)** 填入任務定義系列(Task definition series)名稱，並填入容器的詳細資訊(包含名稱、映像(Image)URI、容器映射端口等)。容器新增完成後，最後按下 **下一步**。
{{< img_imgur Jd0mrxM 90 "#aaa" >}}

再來就是設定 **環境、儲存、監控和標籤**，大部分的設定就是都預設即可，有要更動的有兩個： __環境__ 和 __監控和記錄__。

首先，先來設定環境，預設的應用環境是採用 **AWS Fargate(無伺服器)** ，我們採預設的就可以了，畢竟我們就是要架構無伺服器而不是有伺服器(AWS EC2)。 再來就是設定 **任務尺寸(Task size)**，我們使用0.25vCPU、記憶體0.5GB，就是兩項採最小的大小，因為我們的流量不是很大。
{{< img_imgur 7Uy3lCI 90 "#aaa" >}}

再來就是設定 __監控和記錄__ 。預設會將 **使用日誌集合** 選項勾選起來，如果有需要紀錄日誌的話，可以稍微設定一下，但因為產生日誌會產生一些空間以及費用，且我的主要目的只是將網頁能公開給全世界的人可以存取到，所以我會將勾勾給點掉，最後按下 **下一步**。
{{< img_imgur rowoKZ2 90 "#aaa" >}}

最後會將所有設定項目列出來讓你確認，確認沒問題就可以按下 **建立** 。
{{< img_imgur Az4CsB9 90 "#aaa" >}}

**{{< colorful_text color_="120, 60, 0" font_size="1.2" text_="3. 建立叢集服務(Cluster Services)" br_="0">}}**
回到我們所建立的叢集，點選右下方的 **部署**
{{< img_imgur SNay0QM 90 "#aaa" >}}

到了部署頁面後，在 **部署組態** 裡，勾選 __任務__ 的應用類型，並在下方 **Family** 選擇我們剛剛新增的任務定義，**修訂選"1"**，之後其他使用預設即可，按下 **部屬**
{{< img_imgur bUFqfAM 90 "#aaa" >}}

**{{< colorful_text color_="120, 60, 0" font_size="1.2" text_="4. 修改安全群組(Security Groups)" br_="0">}}**
AWS EC2 > 網路和安全(Networking and Security) > 安全群組(Security Groups)，然後進到當時建立cluster的安全群組
{{< img_imgur FK1KtJc 90 "#aaa" >}}

點選 **編輯傳入規則(Inbound rules)** ，並依以下規則新增：
* 類型： **自訂TCP**
* 連接埠： **5000**
* 來源： **隨處 - TPv4 (0.0.0.0/0)**

最後按下 **儲存規則**
{{< img_imgur V2pl9DG 90 "#aaa" >}}

**{{< colorful_text color_="120, 60, 0" font_size="1.2" text_="5. 可以看到網站啦~~~" br_="0">}}**
回到我們剛剛所建立的"任務(task)"，點選 **聯網** 分頁就可以看到 **公有IP**
{{< img_imgur MWeq1Mx 90 "#aaa" >}}

之後在網址列打上 **[公有IP]:5000** 就可以看到我們的網站啦
{{< img_imgur DmAZE8M 90 "#aaa" >}}

---
**{{< colorful_text color_="100, 100, 100" font_size="1.25" text_="參考來源" br_="0">}}**
- [一起构建一个 Python Flask 镜像 — Docker Tips 0.1 documentation](https://dockertips.readthedocs.io/en/latest/dockerfile-guide/python-flask.html)
- [AWS Fargate tutorial - Running a Docker container with a Python Flask app](https://www.youtube.com/watch?v=-Vsuzi4OByY)