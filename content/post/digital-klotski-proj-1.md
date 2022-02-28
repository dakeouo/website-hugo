---
author: "Dake Hong"
title: "專題紀錄-數字華容道 #1：起源與Python程式撰寫"
date: 2021-11-04T13:42:45+08:00
category: "專題紀錄-數字華容道"
tags: [
    "Klotski",
    "Python",
]
---
因為疫情的關係，我在今年9月底才畢業並離開了學校，踏上了找工作之旅。但是要找甚麼樣種類的工作呢?我內心大概整理出了兩種職務：
<!--more-->
- 剛開始我的目標是**雲端系統工程師**，就是協助客戶做數位轉型、雲端架構部屬規劃，足客戶當前和未來的需求，主要就是需要知道各家雲端平台有哪些服務、怎麼去做運用以及規劃，而且要一定的網路基礎。但企業大多都會是招募有3至5年平台使用經驗，很少在招募新鮮人，而且這個職務類似於業務的感覺，初始的薪資相較低，除非做到類似顧問等級的大大薪資才比較高。
- 所以後來就覺得**後端工程師**這個職務，似乎對我比較有利，但是又不是純寫程式即可，主要是將應用軟體開發進行容器化、自動化的部屬，會接觸到一些雲端平台的部分。這個職務比較傾向於我想要的，寫程式薪水相對較高，但目前像是容器化、自動化、無伺服器這類的這些技能，目前我也都沒經驗。

所以基於以上的論述，這個傳案就誕生了!這個專題，主要會接觸到**容器化 (Docker)**、**後端常用語言 (Node.js)**、**非關聯式資料庫 (NoSQL)**，以及最後會運用到雲端平台 (AWS或GCP)來部屬。所以我的目標，就是建立一個無伺服器服務的"數字華容道"遊玩頁面!

## 數字華容道(Digital Klotski)
甚麼是"數字華容道"?就是小時候可以將數字推來推去的玩具，據說是由"華容道"這項遊戲所衍生而成的，有興趣的可以上網查一下 (圖片來源：[Amazon.com](https://www.amazon.com/Cuberspeed-magnetized-Klotski-Teasers-Intelligence/dp/B08X4T8FL4))
| {{< img_imgur vxrfRjs 70>}} | {{< img_imgur mPDpLbu 70>}} | {{< img_imgur 3pwNQfP 70>}} |
| :---: | :---: | :---: |
| 8 Klotski (3x3) | 15 Klotski (4x4) | 24 Klotski (5x5) |

那第一步驟，就是些寫成Python程式碼來呈現Digital Klotski

## [Part 1] Python
程式如何寫在這邊就不多做說明了，這邊主要是來敘述一下程式的流程：

**{{< colorful_text color_="120, 60, 0" font_size="1" text_="1. 程式一開始會出現歡迎畫面，也會讓你選擇你要的難度" br_="0">}}**
(選1是3x3、選2是-4x4以此類推，共有5個難度)
```
================================
==  Welcome to play Klotski!  ==
================================
  Use 'w/a/s/d' to moving block
  Press 'q' to leave this game.
================================
Which Klotski's level would you want to play?(1~5):
```
**{{< colorful_text color_="120, 60, 0" font_size="1" text_="2. 選完難度後，就會顯示出你選擇的難度以及題目，並遊戲開始" br_="0">}}**
(如果輸入有誤，預設會選擇最簡單難度)
|Level 1|Level 2|Level 3|Level 4|Level 5|
|:--:|:--:|:--:|:--:|:--:|
|Easy (3x3)|Normal (4x4)|Difficult (5x5)|Hard (6x6)|Expert (7x7)|
```
OK! Klotski's level will set 'Easy'.
================================
== GAME START ==
-------------
| 1 | 5 | 2 |
-------------
| 4 | 6 | 8 |
-------------
| 7 |   | 3 |
-------------
Press key (char):
```
**{{< colorful_text color_="120, 60, 0" font_size="1" text_="3. 使用w、a、s、d鍵來移動方塊(上面也會寫你目前移動了幾次)" br_="0">}}**
(在遊玩的過程中，可以隨時按下"q"離開遊戲)
```
Press key (char):s
Moves: 1
-------------
| 1 | 5 | 2 |
-------------
| 4 |   | 8 |
-------------
| 7 | 6 | 3 |
-------------
Press key (char):s
Moves: 2
-------------
| 1 |   | 2 |
-------------
| 4 | 5 | 8 |
-------------
| 7 | 6 | 3 |
-------------
...
```
**{{< colorful_text color_="120, 60, 0" font_size="1" text_="4. 最後，移動完畢會顯示你花費了幾秒" br_="0">}}**
```
Press key (char):w
Moves: 21
-------------
| 1 | 2 | 3 |
-------------
| 4 | 5 | 6 |
-------------
| 7 | 8 |   |
-------------
Congratulation! you move 21 times to finish this game.
Spend Time (sec): 17.760ms
```

上述的程式我有上傳至[Github](https://github.com/dakeouo/proj-klotski)上，有興趣的可以下載來玩看看。

下一階段，就是使用Docker，讓程式可以用容器進行