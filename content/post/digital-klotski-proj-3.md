---
author: "Dake Hong"
title: "專題紀錄-數字華容道 #3：使用Flask建立網站"
date: 2021-11-08T20:48:54+08:00
category: "專題紀錄-數字華容道"
tags: [
	"Klotski",
    "Python",
    "Flask",
]
---
在我們Docker Image建立完成後，就能建置Python-based的Flask網站了。但首先，我們需要把原本的華容道程式(Klotski)給模組化。
<!--more-->
## [Part 3-1] 模組化Digital Klotski程式
我們將華容道程式移至另外一個檔案(DigitalKlotski.py)中，並改寫成名為"DigitalKlotski"的類別(class)，並包含稍後之後會用到的方法(method):
- **makeQuizMatrix()**: 產生華容道題目
- **moveBlock()**: 移動華容道方塊
- **showQuizMatrix()**: 顯示華容道方塊
- **MatrixFinish()**: 判斷遊戲是否結束

那在我們的主程式(app.py)當中，運行的主要程式就可以縮減成：
```python
from DigitalKlotski import DigitalKlotski
moveTimes = 0 #使用者移動次數
# 前置作業與準備
inputSize = input("Which Klotski's level would you want to play?(1~5):")
klotski = DigitalKlotski(level=int(inputSize)) # 建立數字華容道
klotski.showQuizMatrix() # 顯示題目
# 遊戲開始與進行
while not klotski.MatrixFinish():
	key = input("Press block number:")
	success = klotski.moveBlock(int(key))
	if success:
		moveTimes += 1
	print("Moves:", moveTimes)
	klotski.showQuizMatrix() # 顯示題目
# 遊戲結束與結算
if klotski.MatrixFinish():
	print("Congratulation! you move %d times to finish this game." %(moveTimes))
else:
	print("You are not finish yet!")
```

## [Part 3-2] Python flask建立
要建立flask環境其實很容易，因為它是python的套件，所以只要使用pip來安裝flask就可以了：`pip install flask`

安裝完成後，我們可以複製下面的程式碼來實現顯示"Hello World"的網站：
```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
	return "Hello World"
```
之後在終端機運行以下指令就可以看到網頁了：
```bash
export FLASK_APP=app.py #設定運行的檔名
export FLASK_ENV=development #設定環境模式(預設是production，也可以用程式的方式變更)
```
Windows的用戶須將"export"改成"set"：
```bash
set FLASK_APP=app.py #設定運行的檔名
set FLASK_ENV=development #設定環境模式(預設是production，也可以用程式的方式變更)
```

設定完成後，即可透過以下指令來運行程式碼:
```bash
python app.py #一般檔案執行方式
flask run [--reload] [--debugger] [--host 0.0.0.0] [--port 80]
```
* flask相關參數：
  * __–reload__：修改 py 檔後，Flask server 會自動 reload
  * __–debugger__： 如果有錯誤，會在頁面上顯示是哪一行錯誤
  * __–host__： 可以指定允許訪問的主機IP，0.0.0.0 為所有主機的意思
  * __–port__： 自訂網路埠號的參數

而這邊有兩個資料夾值得關注：
* [static]：存放像是image、CSS、Javascript等靜態的檔案
* [template]：存放網頁頁面(HTML)，就像是MVC架構當中的V(views)

而在flask計算與傳遞變數方面，有兩種形式：
* __{% %}__：用來進行像是for、if、while等判斷或是迴圈，通常為兩兩一組
  * 例如：{% for row in query %}...{% endfor %}、{% if a==1 %}...{% endif %}
* __{{ }}__：用來傳遞變數，變數後面加上"| [Type]"可以轉變型態進行運算
  * 例如：{{ num.abc }}、{{ (task | int)/2 }}

而下一步，就是來完成klotski網頁版遊戲了。最終我們使用了兩個頁面：
* __index.html__：起始頁面。讓client選擇難度
* __klotski.html__：遊玩畫面

**{{< colorful_text color_="120, 60, 0" font_size="1.2" text_="呈獻成果(首頁)" br_="0">}}**
{{< img_imgur BNQ3hvu 90 >}}

**{{< colorful_text color_="120, 60, 0" font_size="1.2" text_="呈獻成果(遊戲頁面)" br_="0">}}**
|{{< img_imgur 3p0dSfx 90 >}}|{{< img_imgur 98QF4oK 90 >}}|{{< img_imgur jr5b7vh 90 >}}|
| ------ | ------ | ------ |
| 遊戲起始畫面 | 遊戲進行畫面 | 遊戲結束畫面 |

目前這個在操作上，可能會還有需要改進的地方，不過沒關係，先求有再求好。我們下一階段，就將目前這個flask網頁，打包成Docker Image，然後再看看能不能佈署到雲端上去吧!

---
**{{< colorful_text color_="100, 100, 100" font_size="1.25" text_="參考來源" br_="0">}}**
- [【Hello word】實作一個簡單的 Flask 入門 | Max行銷誌](https://www.maxlist.xyz/2020/04/30/flask-helloworld/)