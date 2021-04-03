---
author: "Dake Hong"
title: "NVIDIA JETPACK TX2刷機"
date: 2020-04-03T17:35:12+08:00
tags: [
    "NVIDIA",
    "JETPACK TX2",
]
---
## 事前硬體準備
<!--more-->
* 一台裝有 __{{< colorful_text color_="0, 100, 0" text_="Linux Ubuntu 64位元(本文使用16.04版)" >}}__ 實體機：建議不要用VM的Ubuntu，不然在執行當中可能會有錯誤
* 一條MicroUSB轉USA Type-A的傳輸線(TX2原廠配備有提供)
* 一台網路交換器 + 2條網路線：之後須將實體機與TX2設置在同個區網下。若無交換器，可使用 __{{< colorful_text text_="跳線(非一般網路線)" text_dec="underline" >}}__ 代替

## 刷機步驟

TX2的刷機，其實就是一般電腦重灌系統的意思。因本身TX2出場時已自帶Ubuntu16.04 64位元作業系統，故我們要更新它的韌體的話就叫做刷機。

### 1. 首先，我們先到Nvidia官網上面下載[JetPack3.3](https://developer.nvidia.com/embedded/downloads#?search=Jetpack%203.3)。

在下載時，需先{{< colorful_text color_="0, 100, 0" text_="註冊/登入Nvidia會員" >}}，才可以進行下載。
{{< img_imgur smU5VlC 90 >}}

### 2. 等待下載完成後，我們會取得到一個 *.run* 檔，將它放置於 *Ubuntu的主機* 中。
建議在家目錄下建立一個Jetpack資料夾，因為在Jetpack 安裝的途中 __需要一個乾淨的資料夾__ 。並將.run移至該資料下{{< colorful_text br_="0">}}
-- 建立資料夾：```$ mkdir /home/(使用者名稱)/Jetpack>```{{< colorful_text br_="0">}}
-- 移動檔案：```$ mv ./(檔案名稱).run /home/(使用者名稱)/Jetpack/(檔案名稱).run ```

### 3. 更改下載的.run文件權限。
將{{< colorful_text color_="0, 100, 0" text_="'允許此檔案作為程式來執行'" >}}勾選起來
{{< img_imgur LAPatEX 50 >}}

### 4. 執行安裝檔(需先切換到Jetpack目錄)
命令：```$ ./JetPack-L4T-3.3-linux-x64_b39.run ```{{< colorful_text br_="0">}}
記得前面不需要加sudo(以super user執行)，否則會有以下訊息：{{< colorful_text br_="0">}}
(中譯：請使用非升級用戶運行JetPack。如果在安裝的過程中需要root權限，我們會提示您){{< colorful_text br_="0">}}
{{< img_imgur reTlTRw 90 >}}
再來你會看到一則警告訊息：{{< colorful_text br_="0">}}
(中譯：我們注意到你運行於非英語語系的作業系統。NVIDIA並不測試且不支援這種配置){{< colorful_text br_="0">}}
{{< img_imgur EX9hSkn 90 >}}
再來你會看到以下安裝畫面，如下圖所示：{{< colorful_text br_="0">}}
{{< img_imgur 8uuHbpv 70 >}}

### 5. 安裝過程
{{< colorful_text text_="5-1. 選擇安裝的路徑配置及是否同意資料收集：" text_dec="underline" br_="0">}}
安裝配置預設就是執行檔的資料夾。下面"Privacy Notice"的部分，就是問你是否同意NVIDIA取得你的相關資料讓他們做分析。{{< colorful_text br_="0">}}
{{< img_imgur tFVFbqj 70 >}}
{{< colorful_text text_="5-2. 選擇開發環境：" text_dec="underline" br_="0">}}
選擇"Jetson TX2"。{{< colorful_text br_="0">}}
{{< img_imgur uuvigfX 70 >}}
{{< colorful_text text_="5-3. 下載JetPack 3.3 組件：" text_dec="underline" br_="0">}}
這邊就是主要的套件管理介面，先按下"Next"。{{< colorful_text br_="0">}}
{{< img_imgur LXuTYOr 70 >}}
再來會跳出這個介面，選擇你要下載的組件，勾選"Accept All"(全選)，然後按下右下角的"Accept"。{{< colorful_text br_="0">}}
{{< img_imgur rAqJSNS 70 >}}
之後就要取得super user的權限，打完使用者密碼就可以安裝了。{{< colorful_text br_="0">}}
{{< img_imgur viDlWMD 50 >}}
{{< colorful_text text_="5-4. 準備安裝畫面" text_dec="underline" br_="0">}}
{{< img_imgur E3ipRU4 70 >}}
沒多久會跳出此畫面，按下"OK"即可。{{< colorful_text br_="0">}}
(中譯：根據組件選擇，請注意嵌入式終端中的提示 ： /可能需要其他用戶輸入  /按照屏幕上的說明繼續){{< colorful_text br_="0">}}
{{< img_imgur imGz6Bp 50 >}}
{{< colorful_text text_="5-5. 安裝中畫面：(安裝時間依據網路速度約3~6小時)" text_dec="underline" br_="0">}}
{{< img_imgur 6mbO8xk 70 >}}
安裝完後，會跳出此畫面，按下"Next"。{{< colorful_text br_="0">}}
{{< img_imgur BBfwZ1k 70 >}}
{{< colorful_text text_="5-6. 選擇網路配置" text_dec="underline" br_="0">}}
建議使用有線網路配置(傳輸上比較不會出問題)，故選擇第一個選項即可。{{< colorful_text br_="0">}}
{{< img_imgur ccmaLP3 70 >}}
{{< colorful_text text_="5-7. 選擇網路介面卡" text_dec="underline" br_="0">}}
如果你的主機沒有其他的介面卡，上面應該只顯示一張網路介面卡{{< colorful_text br_="0">}}
{{< img_imgur HIsZ6Vs 70 >}}
接下來這個畫面，就是告訴你它接下來要幹嘛的樣子{{< colorful_text br_="0">}}
{{< img_imgur 9kwbWV4 70 >}}

### 6. 接上TX2，開始刷機~~
{{< colorful_text text_="6-1. 請依照畫面指示做：" text_dec="underline" br_="0">}}
1. __將裝置關機：__ 如果你的電源是連接著，把電源線拔掉。{{< colorful_text color_="252, 29, 0" text_="裝置'必須'是關機狀態" text_dec="underline">}}，並不是待機或睡眠狀態。
2. __接上傳輸線__ (USB-A 對 mircoUSB)：一端接上開發版(TX2)、另一端接上主機(Ubuntu)。
3. __接上電源線__
4. __按下開機鍵__(長按約1s)：然後長{{< colorful_text color_="252, 29, 0" text_="按還原鍵不鬆開，並按下重置鍵約2s以上再鬆開，最後再鬆開還原鍵" text_dec="underline">}}，強制裝置進入還原模式。
5. 如果裝置進入還原模式，打lsusb命令裡面會有"NVidia Corp"。
{{< img_imgur gokfAoX 70 >}}
{{< colorful_text text_="6-2. 確認TX2是否連接成功：" text_dec="underline" br_="0">}}
命令：```$ lsusb``` {{< colorful_text br_="0">}}
有看到{{< colorful_text color_="0, 100, 0" text_="'NVidia Corp'代表有成功" text_dec="underline">}}。{{< colorful_text br_="0">}}
{{< img_imgur G0owDsJ 70 >}}
{{< colorful_text text_="6-3. 之後就放著給它跑，約30分鐘至1小時左右會完成。" text_dec="underline" br_="0">}}
完成後會看到{{< colorful_text color_="0, 100, 0" text_="'Installation of target components finished, close this windows to continue.'" >}}。{{< colorful_text br_="0">}}
{{< img_imgur o9C5eIF 70 >}}
最後，刷機結束畫面。會問你要不要把下載的檔案刪掉：{{< colorful_text br_="0">}}
{{< img_imgur 6u4xulL 70 >}}

----
參考來源：[CSDN | Jetson TX2 刷机并安装JetPack3.1](ttps://blog.csdn.net/QLULIBIN/article/details/78629305)