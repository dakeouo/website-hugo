---
author: "Dake Hong"
title: "Hugo架站紀錄 #3 - Netlify網址變身記"
date: 2021-08-08T16:07:45+08:00
category: "Hugo架站"
tags: [
    "Freenom",
    "Netlify",
    "網頁設計",
]
---
上一篇我們將網頁原始碼上傳到github，並且利用Netlify讓這個網頁有個網址(\*.netlify.net)可以供所有人存取。這篇我們要讓這個網頁使用我們自己的網址
<!--more-->

## 事前準備 - 一個Domain Name
在變更Netlify網址之前，你需要準備一個你認為好記的網址。這邊介紹一個可以免費申請Domain Name的網站 - [Freenom](https://www.freenom.com/)
{{< img_imgur RpehrGd 80 >}}

若你還沒有Freenom的帳號可以先註冊。登入過後，我們可以在上面選擇"Service">"Register a New Domain"來註冊一個新Domain
{{< img_imgur bnldsUv 80 >}}

可以在紅色框框處輸入你要的名稱，並按下右側"Check Availability"按下是否有可用的網址
{{< img_imgur lBOOp1d 80 >}}

我們可以看到，Freenom提供了五個免費的網域：\*.tk、\*.ml、\*.ga、\*.cf、\*.gq。從畫面上可以看到，這個網域名稱目前只有一個網域是可用的：hugo.tk，我們點擊右側的藍色按鈕"Get it now!"
{{< img_imgur Wz0RBmQ 80 >}}

之後可以看到，剛剛的藍色按鈕變成了綠色的"Selected"，代表你已經選擇了它，並加進去購物車。這時我們只需點擊上方的"Checkout"按鈕結帳去即可
{{< img_imgur XsFLhxt 80 >}}

我們看到這個購物車畫面，最右邊的下拉式選單可以選擇你要購買幾個月，Freenom提供只要不超過12個月都是免費的
{{< img_imgur 4J7Q6tf 80 >}}

接下來可以看到結帳畫面，勾選左側紅框綠色的勾來確定你已經閱讀他們的注意事項，然後就可以點擊右側藍色的按鈕完成訂單
{{< img_imgur gNXTidC 80 >}}

之後看到這個畫面，就代表你已經結帳成功，可以開始使用你的Domain了
{{< img_imgur CgFy0os 80 >}}

## 網頁改為自訂網址
讓我們先回到Netlify這邊，一樣先點選上面的"Site settings"
{{< img_imgur lXcdVUn 80 >}}

點選"Domain management"，然後再按下"Add custom domain"按鈕新增Domain
{{< img_imgur txlIwCp 80 >}}

在紅色框框處輸入你的自訂網址，然後按下下方的"Verify"按鈕驗證這個網址
{{< img_imgur EPIZ05F 80 >}}

然後就會跟你說"這個網址已經有擁有者了。是你的嗎?"，要確認一下是不是真的是你的(不要去亂加別人家的網址)，然後按下下方的"Yes, add domain"按鈕
{{< img_imgur xHFHXdA 80 >}}

按下後，會跳轉到"Domain management"，會發現Netlify將有"www"的網址也順便一同幫你設定進去了。但是目前Netlify還不能使用這個網址，可按下"Check DNS configuration"來檢查發生甚麼問題
{{< img_imgur hJ4bznY 80 >}}

點開以後，發現Netlify需要你將他指定的A record寫入到你自訂網址的DNS server，讓你這個網址可以指向到Netlify指定的IP去
{{< img_imgur wUQyZbp 80 >}}

現在我們回到Freenom來設定A record。點選"Services">"My Domain"
{{< img_imgur gucDcrg 80 >}}

這邊可以看到我們剛剛申請的網址的資訊，包含註冊日期、有效日期等(因為我這個網址僅示範用途，所以只購買一個月而已)。之後點選右側的"Manage Domain"來設定DNS
{{< img_imgur V5AvqYR 80 >}}

點擊上方的"Manage Freenom DNS"
{{< img_imgur JtF9O0W 80 >}}

弄兩個A record的條目，一個"Name"欄位空白；另一個"Name"欄位輸入"www"，然後兩個條目的"Target"欄位都輸入剛剛在Netlify看到指定的IP，然後按下右下角的"Save Changes"按鈕存檔
{{< img_imgur p6AI02q 80 >}}

存檔後，回到Netlify這邊，將頁面滾動到最下面"SSL/TLS certificate"，按下"Verify DNS configuration"按鈕驗證SSL是否通過。因為Netlify使用的網址都必須是有SSL驗證的，也就是可以用https來連線的
{{< img_imgur DLsfXjA 80 >}}

SSL通過後的畫面
{{< img_imgur jpZOxEj 80 >}}

但這時我們發現，上面那兩個網址的DNS還是有問題，點開"Check DNS configuration"後發現它要我們將這四條DNS紀錄加到的我們的DNS去，也就是讓Netlify託管
{{< img_imgur ph0CHf5 80 >}}

回到Freenom頁面，點選上方的"Management Tools">"Nameservers"
{{< img_imgur n4EcFdv 80 >}}

選擇"Use custom nameservers (enter below)"，將剛剛在Netlify頁面看到的四條DNS紀錄依序填入，之後按下"Change Nameserers"按鈕
{{< img_imgur 7m0Hkjk 80 >}}

回到Netlify這邊，將頁面滾動到最下面"SSL/TLS certificate"，發現SSL/TLS認證資訊都出來了
{{< img_imgur yDwczjW 80 >}}

然後我們在網址列打上我們自訂的網址，發現可以連到我們的Hugo網頁了~~~
{{< img_imgur v796l5q 80 >}}