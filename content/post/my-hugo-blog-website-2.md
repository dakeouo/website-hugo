---
author: "Dake Hong"
title: "Hugo架站紀錄 #2 - 用Github+Netlify架設自己的公開網站"
date: 2021-08-07T23:28:23+08:00
category: "Hugo架站"
tags: [
    "Netlify",
    "網頁設計",
]
---
上一篇我們在本地端架好了Hugo網站，這一篇是要讓這個網站給全世界的人看到!!
<!--more-->

## 事前準備
需先準備好以下的東西：
* 一個Hugo網站原始碼(上一篇所建立好的)
* 一個[Github](https://github.com/)帳號
* 一個[Netlify](https://www.netlify.com/)帳號

[Github](https://github.com/)與[Netlify](https://www.netlify.com/)帳號的建立都相較簡單，這邊就不做介紹了

## Github設定與程式碼上傳
**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step1.登入Github" br_="0">}}**
登入[Github](https://github.com/)後，可以看到左上角有一個綠色的按鈕，按下後即可新增Repo
{{< img_imgur 9G8NpYa 80 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step2.新增Github Repo" br_="0">}}**
輸入"Repository name"後，即可按下下方的綠色的按鈕"Create repository"新增Repo
{{< img_imgur MvZzIjq 80 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step3.上傳網頁原始碼" br_="0">}}**
新增過後，你會看的這個畫面。複製紅色框框處的內容({{< codeview code="https://github.com/[你的GitHub帳號]/[你的Repo名稱].git">}})，貼回命令提示字元。
{{< img_imgur EhbVk12 80 >}}

之後複製以下指令，即可將網頁原始碼上傳至Github：
- {{< codeview cmd=1 code="git remote add origin https://github.com/[你的GitHub帳號]/[你的Repo名稱].git">}}
- {{< codeview cmd=1 code="git push -u origin master">}}

重新整理頁面後，就可以看到妳的原始碼已經上傳至Github了
{{< img_imgur K3mJzc8 80 >}}

## Netlify設定與跟Github Repo做連結
登入[Netlify](https://www.netlify.com/)後，在畫面正中間偏下面有個寫著"New site from Git"的藍綠色按鈕。這邊說明一下，因為我已經有在使用了，所以我的畫面可能會跟你們的不一樣
{{< img_imgur 4EODFdp 80 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.25" text_="Step1.建立Git新網站" br_="0">}}**
可以看到下方"Continuous Deployment"的地方，有三個匯入來源可以讓你選擇。因為我們剛剛是上傳的github，所以請點選github。
{{< img_imgur 91lssWT 80 >}}
{{< colorful_text color_="127, 0, 0" font_size="1" text_="這邊說一下，如果你是第一次使用Netlify的話，按下後會請你的Github帳戶授權給Netlify，才能繼續運作下去。" br_="0">}}

之後他會自動去抓你可以部屬到Netlify的原始碼。選擇我們剛剛所建立的Repo即可
{{< img_imgur 4z95mR6 80 >}}

再來需設定環境變數。開啟終端機，打上{{< codeview cmd=1 code="hugo version">}}，會得到類似以下結果：
- hugo v0.82.0-9D960784 windows/amd64 BuildDate=2021-03-21T17:28:04Z VendorInfo=gohugoio

其中那個"0.82.0"就是Hugo的版本號，要填入Netlify的環境變數去。回到網頁上，按下"Show advanced"開啟進階設定
{{< img_imgur bueUGxB 80 >}}

在進階設定當中，在"Advanced build settings"下方有個按鈕，按下他來新增環境變數
{{< img_imgur e0Ms573 80 >}}

"Key"填入{{< codeview code="HUGO_VERSION">}}, 然後"Value"填入剛剛查到的Hugo版本號。然後點選下面的"Deploy site"來部屬網站
{{< img_imgur IHy9w7B 80 >}}

等待幾秒鐘至幾分鐘左右，等到紅框處的地方變成綠色網址後，代表已經建置完成
{{< img_imgur yScO7Zm 80 >}}

## 更改網址
目前這個網址"很醜"，而且又很難記，所以依照以下步驟可以自訂"\*.netlify.net"的網址：
1. 點選上面那列的"Site setting"
2. 選擇"Domain management"
3. 在醜醜的那個網址後面有個"Option"，下拉選擇"Edit site name"

{{< img_imgur uSkpEFS 80 >}}

輸入你想要的名稱，使你的網址變成"[自訂名稱].netlify.net"。但記住，這個名稱需要是不重複且唯一的名字
{{< img_imgur 51r1ZfD 80 >}}

之後點選這個網址，即可連到你的網站
{{< img_imgur fX6WN0Q 80 >}}

到這邊為止你的網站就已經部屬完成了，但你可能會想說，如果我不想要"netlify.net"結尾的網址，我想要用自己的怎麼辦? 沒關係，下一篇會介紹怎麼設定。

---
**{{< colorful_text color_="100, 100, 100" font_size="1.25" text_="參考來源" br_="0">}}**
- [一毛錢都不用花就能擁有自己的網站 # 2：如何用 Netlify 讓我們的網站讓全世界看到 - J.N. Yiunn's blog](https://jnyiunn.com/build-website-with-hugo-2/)
