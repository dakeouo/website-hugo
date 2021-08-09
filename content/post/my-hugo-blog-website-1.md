---
author: "Dake Hong"
title: "Hugo架站紀錄 #1：使用Hugo讓自己的網站變乾淨整齊"
date: 2021-08-07T13:13:08+08:00
category: "Hugo架站紀錄"
tags: [
    "Hugo",
    "網頁設計",
]
---
原本我的[個人網站](http://dake.work/ciblog)是使用Codeigniter MVC框架所製作而成的，而且是那種有包含後台可以自己編輯增修網頁內容的網站。雖然使用MVC架構已經相較一般陽春網站安全許多，但是畢竟我的後台的安全性配置沒有到很高強度，而且網站運行的程式碼還是放在付費的網頁主機上。
<!--more-->
(雖然我的網站大約在五月的時候就已經建置完成，當時也有想做個紀錄，但是直到最近才有時間寫)

{{< img_imgur XqShsxs 80 >}}
所以想說，畢竟我的需求是個人的靜態網站，那剛好Github是可以放靜態網站的地方，然後又找到說Hugo這套Framework可以架站，所以就開啟我的網站搬遷之旅，然後我原本的[個人網站](http://dake.work/ciblog)就不再更新，退役下來當我的作品網站之一。

## Hugo安裝(Windows)
Hugo安裝檔下載位置：[https://github.com/gohugoio/hugo/releases](https://github.com/gohugoio/hugo/releases)

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step1.找尋所需Hugo版本" br_="0">}}**
使用者可以找尋想要的版本，或是下載目前最新版本的就好。
{{< img_imgur mjTRJA1 80 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step2.下載Hugo安裝檔" br_="0">}}**
將頁面向下滾動，可以找到Windows版本「32bit」和「64bit」版本，選擇適合自己電腦的版本下載。
{{< img_imgur LFysqGu 80 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step3.將EXE檔放置C槽" br_="0">}}**
下載完畢後，將檔案解壓縮，並將裡面的"hugo.exe"放置在"C:\hugo"當中
{{< img_imgur eQfk9q9 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step4.新增環境變數" br_="0">}}**
開啟控制台，並依序點選"系統及安全性"->"系統"->"進階系統設定"
{{< img_imgur RiCyHeT 80 >}}

點選"環境變數"按鈕
{{< img_imgur E52f9pG 50 >}}

點選"使用者變數"中，"Path"變數，再點選"編輯"按鈕
{{< img_imgur Pk3J93w 70 >}}

點選"新增"按鈕，輸入"C:\hugo"，將hugo.exe的路徑加入至環境變數中
{{< img_imgur bywbPQM 70 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step5.確認是否按裝完成" br_="0">}}**
之後開啟"命令提示字元"，輸入{{< codeview cmd=1 code="hugo version">}}確認Hugo是否安裝成功
{{< img_imgur pZmsH9X 80 >}}

## 架設新Hugo網站

### 建立網站
在"命令提示字元"中，輸入{{< codeview cmd=1 code="hugo new site [Folder Name]">}}，即可快速的建立Hugo網站。並輸入{{< codeview code="cd [Folder Name]">}}進入該網站資料夾
{{< img_imgur T5koxPF 80 >}}

在該網站資料夾內，會有七個項目：
* archetypes/: 文章預設配置
* content/: 放文章的地方
* data/: (空的)
* layout/: 這個網站一些的配置，包含頁首頁尾那些
* static/: 放圖片、CSS等檔案的地方
* themes/: 你使用的模板配置
* config.toml: Hugo網站的核心配置檔
{{< img_imgur sBUnXdL 80 >}}

### 版本控制-1
在進行下去之前，我們先將這個資料夾作版本控制。這邊不會深入介紹版本控制，照著步驟進行即可。

1. 版本控制初始化：{{< codeview cmd=1 code="git init">}}
2. 將目前資料加入版控：{{< codeview cmd=1 code="git add .">}}
3. 提交第一次的Commit：{{< codeview cmd=1 code="git commit -m \"[提交訊息]\"">}}
{{< img_imgur SSmeIoL 80 >}}

### 套用主題
我們現在可以輸入{{< codeview cmd=1 code="hugo serve">}}，來看看目前網站長怎樣。筆者這邊預設是在網址列輸入"http://localhost:1313"就可以看到目前網站
{{< img_imgur pIcDBcP 80 >}}
恩...空白的XDD。所以我們現在要套主題模板

使用者可以至[Hugo主題庫](https://themes.gohugo.io/)，選擇自己喜歡的主題模板下載
{{< img_imgur SKLJRgX 80 >}}

像是筆者這個部落格使用的是[Blackburn](https://github.com/yoshiharuyamashita/blackburn)這個主題模板。選定好主題，按下"Download"鍵就會連結到該主題的下載頁面。
{{< img_imgur 5ei1mC3 80 >}}

然後把**你選擇的主題**(eg. Blackburn)使用git語法，加到你的網站資料夾裡面
{{< codeview cmd=1 code="git submodule add https://github.com/xxx/xxx.git themes/xxx">}}

之後開啟網站資料夾內，在"config.toml"檔案內加入"theme = \"[你選擇的主題名稱(eg. blackburn)]\""
{{< img_imgur hVL5PJA 90 >}}

存檔後，這時候你回來看你的網站就變不一樣了
{{< img_imgur bfnF9VX 80 >}}

### 建立文章
在建立文章之前，先來對這個網站作設定：(將以下的內入複製貼上即可)
```toml
[menu]
  [[menu.main]]
    identifier = "post"
    url = "/post/"
    # title will be shown when you hover on this menu link
    title = ""
    weight = 1
```


{{< img_imgur CcCBmSL 90 >}}

設定完後，輸入{{< codeview cmd=1 code="hugo new post/[文章名稱].md">}}即可建立第一篇新文章。回到網頁去，結果你會發現...
{{< img_imgur pQOgQAz 80 >}}
頁面上除了多了一個連結，其他甚麼都沒有。發生甚麼事了?

讓我們看一下{{< codeview code="post/[文章名稱].md">}}內容。可以看到第四行寫著{{< codeview code="draft: true">}}，代表這個文章處於"草稿"狀態，只要將這行改成{{< codeview code="draft: false">}}即可。
{{< img_imgur lh8CZgp 90 >}}

這時可以發現，我們文章出現了~~~
{{< img_imgur W6vSulJ 80 >}}

### 版本控制-2
由於我們剛剛新增/修改了一些東西，需要作版本的更新，步驟跟第一次的大相同：

1. 將目前資料加入版控：{{< codeview cmd=1 code="git add .">}}
2. 提交第二次的Commit：{{< codeview cmd=1 code="git commit -m \"[提交訊息]\"">}}
{{< img_imgur wsbI6ue 80 >}}

這樣整個Hugo架站的流程就完成了! 但是目前這個網站還在本地端，也就是你的電腦，所以下一篇要讓這個網站所有人都可以看的到~~

---
**{{< colorful_text color_="100, 100, 100" font_size="1.25" text_="參考來源" br_="0">}}**
- [Windows 上安裝HUGO，打造HTML純靜態網頁環境 | 梅問題．教學網](https://www.minwt.com/webdesign-dev/html/21467.html)
- [一毛錢都不用花就能擁有自己的網站 # 1：如何用 Hugo 架設又快又乾淨的網站 - J.N. Yiunn's blog](https://jnyiunn.com/build-website-with-hugo-1/)
