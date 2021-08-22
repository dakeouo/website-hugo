---
author: "Dake Hong"
title: "AWS CCP證照準備紀錄與心得分享"
date: 2021-08-21T10:30:24+08:00
tags: [
    "AWS",
    "Cloud Practitioner",
    "心得文",
]
---
我為了之後可以找到可以使用AWS這個平台的工作，也預計在畢業之前可以考到AWS的證照。故大約在去年下半年的時候，我就開始準備[AWS解決方案架構師助理級(SAA)證照](https://aws.amazon.com/tw/certification/certified-solutions-architect-associate/)，但因為研究所的課業以及論文稍微繁重，其實都沒有很專注於SAA的準備，所以從開始準備到現在，準備的時長也大約有4~6個月左右。
<!--more-->
但在這個月初，我想說不行，我評估SAA的準備至少還要個1~2個月左右，然後我也大約有考[AWS雲端從業人員(CCP)證照](https://aws.amazon.com/tw/certification/certified-cloud-practitioner/)的知識了，所以我就乾脆直接先考AWS CCP證照了。所以嚴格來講，我實際準備AWS CCP的時間，大約只有10天左右而已。

## 準備資源
以下我會分成SAA與CCP兩個部分的資源來做講述。因為我主要還是以SAA資源來準備證照為主，所以CCP的部分會包含雖然我沒有看過，但推薦去做的資源。

### [AWS官方資源]
**{{< colorful_text color_="100, 100, 100" font_size="1.15" text_="1. AWS 白皮書">}}**[[連結]](https://aws.amazon.com/tw/whitepapers/) **{{< colorful_text color_="192, 100, 100" text_="[FREE]">}}**

AWS的白皮書的內容很多，而且都是英文，許多線上AWS證照課程也都建議你閱覽一下AWS的白皮書，但也有些課程的講者會幫你將白皮書的內容重點整理給你，所以如果你時間充裕的話，是可以稍微看一下的。

以下是[Well-Architected五大支柱](https://aws.amazon.com/tw/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc)的白皮書，也是準備AWS證照蠻重要的五本白皮書：

* 卓越營運支柱(Operational Excellence Pillar) - [網頁](https://docs.aws.amazon.com/wellarchitected/latest/operational-excellence-pillar/welcome.html) / [PDF](https://docs.aws.amazon.com/wellarchitected/latest/operational-excellence-pillar/wellarchitected-operational-excellence-pillar.pdf)
* 安全性支柱(Security Pillar) - [網頁](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/welcome.html) / [PDF](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/wellarchitected-security-pillar.pdf)
* 可靠性支柱(Reliability Pillar) - [網頁](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/welcome.html) / [PDF](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/wellarchitected-reliability-pillar.pdf)
* 效能效率支柱(Performance Efficiency Pillar) - [網頁](https://docs.aws.amazon.com/wellarchitected/latest/performance-efficiency-pillar/welcome.html) / [PDF](https://docs.aws.amazon.com/wellarchitected/latest/performance-efficiency-pillar/wellarchitected-performance-efficiency-pillar.pdf)
* 成本最佳化支柱(Cost Optimization Pillar) - [網頁](https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/welcome.html) / [PDF](https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/wellarchitected-cost-optimization-pillar.pdf)

**{{< colorful_text color_="100, 100, 100" font_size="1.15" text_="2. AWS 學習庫(Learning Library)">}}**[[連結]](https://www.aws.training/LearningLibrary) **{{< colorful_text color_="192, 100, 100" text_="[FREE]">}}**

在AWS Training頁面有許多教學資源，除了證照準備的課程外，還有一些資源介紹、研討會、實例演示等資源可以學習。
{{< img_imgur Qx1UwkD 80 "#aaa">}}

在證照準備課程方面，AWS Training有提供不同語言的數位課程，例如繁體中文、簡體中文、日文、德文等。但其實基本上也就只是字幕以及畫面上的文字是該語言而已，課程的內容講者還是以英文去講述。
{{< img_imgur BMDtmbZ 80 "#aaa">}} 
在你整個都學習完後，會給你一張證書
{{< img_imgur PrJYVHW 70 >}} 

**{{< colorful_text color_="100, 100, 100" font_size="1.15" text_="3. AWS 範例考題">}}**[[CCP連結]](https://d1.awsstatic.com/training-and-certification/docs-cloud-practitioner/AWS-Certified-Cloud-Practitioner_Sample-Questions.pdf) [[SAA連結]](https://d1.awsstatic.com/training-and-certification/docs-sa-assoc/AWS-Certified-Solutions-Architect-Associate_Sample-Questions.pdf)

每一個AWS證照官方都會提供20題的範例問題，讓你可以熟悉題目會出甚麼，但我是認為與正式考題的差距還是有點大。AWS也有提供練習考試(USD$20)，考題會相較比較接近些。

### {{< colorful_text color_="172, 90, 0" text_="[AWS SAA]">}}
**{{< colorful_text color_="100, 100, 100" font_size="1.15" text_="1. Udemy 課程 - TOTAL: AWS Certified Solutions Architect Associate 2021">}}**[[連結]](https://www.udemy.com/course/aws-essentials-solutions-architect-assoc-the-total-course/)

這個是Udemy線上的付費課程，我那時候購入的價格是NT$360。課程內容從CCP的重點開始講述，之後才講一些SAA會遇到的一些雲端服務，在每一個大章節的最後都會有一個小測驗，整個課程進入尾聲時，有兩個模擬考讓你進行練習。
{{< img_imgur Hxrx9Em 80 "#aaa">}}
完成整個課成後，會給你一張課程證明書。我上完這個課的心得是，這門課程不足以可以讓你考取SAA證照，但大概也有5、6成的實力了，後面兩個模擬考試似乎也與正式的官方SAA題目相差勝遠。但如果你想說退而求其次考個CCP，是有機會可以考過的，但畢竟CCP跟SAA的題目方向不一樣，還是要自己斟酌一下
{{< img_imgur lGmrODC 70 "#aaa">}}

**{{< colorful_text color_="100, 100, 100" font_size="1.15" text_="2. 大話AWS雲端架構：雲端應用架構圖解輕鬆學">}}**

這本書是雲育鏈資深講師所撰寫的，主要是介紹AWS各服務器的介紹，以及經典的雲端架構。我認為對於實際架設AWS雲端環境很有幫助，對於考證照也多少有些幫助。在今年七月底(2021/07)出了第二版，有興趣的人可以購入看看。
| {{< img_imgur mfLXnTp 60 >}} | {{< img_imgur WHp62vc 60 >}} |
| :---: | :---: |
| 第一版 [[博客來連結]](https://www.books.com.tw/products/0010872886) | 第二版 [[博客來連結]](https://www.books.com.tw/products/0010897351) |

**{{< colorful_text color_="100, 100, 100" font_size="1.15" text_="3. Dojo - AWS Certified Solutions Architect Associate Practice Exams 2021">}}**[[連結]](https://portal.tutorialsdojo.com/courses/aws-certified-solutions-architect-associate-practice-exams/)

這個是我看網路上文章推薦可以刷題的網站，而且據說與實際題目相似度高達87%，所以我就購入了，當時購入的價格是USD$11.99。這個網站主要是販售AWS的課程與刷題庫，而且題庫會針對你不熟的部分作分析。另外還有GCP ACE與Azure的課程與刷題庫可以選購，並且也有電子書與Cheat Sheet可以購入及觀看。
{{< img_imgur NQ6aIXq 80 "#aaa">}}

### {{< colorful_text color_="172, 90, 0" text_="[AWS CCP]">}}
**{{< colorful_text color_="100, 100, 100" font_size="1.15" text_="1. Udemy 課程 - AWS Certified Cloud Practitioner Training Bootcamp 2021">}}**[[連結]](https://www.udemy.com/course/intro-to-aws-cloud-computing/)

這個課程好像當初有拿到100%OFF的折價券。課程內容我認為還蠻完整的，而且小節有小考題、每個大章節也會有個5到10題的複習考題，最後也有附贈兩個CCP模擬考題。但令我意外的是，有一些考題竟然在我當天CCP正式考試的時候竟然有出現。
{{< img_imgur XqAWyBc 80 "#aaa">}}
課程完成後，一樣會有證明書
{{< img_imgur J1QdJjw 70 "#aaa">}}

## AWS 雲端從業人員(Certified Cloud Practitioner, CCP)證照介紹
- 考試等級：基礎
- 考試長度：90分鐘
- 考試價格：100美金
- 考試題數：約65題
- 考試語言：英文、法文、日文、簡體中文等
- 通過分數：700 (滿分1000)
- 報名方式：Pearson VUE 和 PSI 測驗中心皆可報名
- 考試方式：線上監考考是，考題有選擇題與多選題
- 考試範圍：
{{< pure_table
	"Domain | % of Exam"
	"Domain 1： Cloud Concepts (雲端概念) | 26%"
	"Domain 2： Security and Compliance (安全與合規性) | 25%"
	"Domain 3： Technology (技術) | 33%"
	"Domain 4： Billing and Pricing (帳單與定價)  | 16%"
>}}

### {{< colorful_text color_="172, 90, 0" text_="[整個證照考取過程]">}}

我是在Pearson VUE測驗中心網站預約，在8/19(四)開考，一般預約考試完成後，如果你要**更改考試時間與地點的話，總共有三次**可以更改，而且我記得在**考試的前兩天**是**不得更改任何資訊**的。

在考試當天，記得需要帶"雙證件"(身分證、健保卡、駕照等有照片的證件)。VUE有說需要有"你簽名"的證件(護照、信用卡等)，但我考試那天是沒有被檢查，但建議要帶。 在考試前，需要**拍攝半身照**與**電子簽名**，而且進去考場前，個人物品要放置物櫃，**口到要淨空**、**水、手機、手錶**那些的都不能帶進去。但考場基本上會提供給你小白板、板擦、白板筆，讓你可以計算或是寫一些東西。

而我這次考CCP，語言是選擇簡體中文，考試介面有原文(英文)的題目可以看，所以如果英文不太好的我建議可以選擇簡體中文。考試後，也會有問卷詢問你考試的過程是否滿意，然後**當場就會知道你有沒有考過**，現場也會列印一張""非正式""的成績單給你。
{{< img_imgur 0KYRIo9 80 "#aaa">}}

上面是說"要評估考試政策與合規性"所以最多要5個工作日，不過我大約2天後就收到正式的證照了
{{< img_imgur C1PeqTo 90 "#aaa">}}

而"正式的"考試成績單也會順便給你，而我的成績是788，算是有點低空飛過啦。你考過後，AWS會給你**50%OFF的考試折價券**供你下次考試可以使用，而且還有**證照數位徽章**，讓你可以分享到你想要的地方。
{{< img_imgur DDsYCrQ 80 "#aaa">}}