---
author: "Dake Hong"
title: "AWS演講/實作紀錄 #2：高可用性保管服務 (AWS Summit Taiwan 2021)"
date: 2021-09-10T10:18:27+08:00
category: "AWS演講/實作紀錄"
tags: [
    "AWS",
]
---
很榮幸可以參加到[2021 AWS 台灣雲端高峰會](https://aws.amazon.com/tw/events/taiwan/2021summit/)，今年主辦單位為了鼓勵大家踴躍學習而提供了多重好禮，有AWS 隨行充電鑰匙圈、AWS 無線充電滑鼠墊、Apple Watch S6、 美食平台外送卷等。
<!--more-->
{{< img_imgur Az2Kds3 90 >}}

而今年除了有**主題演講**、**分堂議程**、**AWS培訓與認證專區**、**合作夥伴專區**外，還有**AWS Lab**提供一些實際的場景以及應用案例，如何運用AWS進行解決與實作。而AWS Lab又分成以下三個區域(以下為官方的敘述)：
* __AWS 開發者專區__：精選各式真實場景，跟來自 AInnovate、Migo、g0v 等專家好手線上切磋，身歷其境演練不同應用情境、紮實獲得實務技能，你將成為組織的營運關鍵！
* __Builders 練功坊__：從不同角色的實際應用案例出發，由技術專家帶領活用 AWS 解決方案，一起參與為需求量身打造的 Builders 練功坊，破解開發技術盲點！
* __Workshop 工作坊__：精選兩大關鍵主題工作坊，Workshop 將由 AWS 技術專家親自帶領演練，雙管齊下解決棘手難關！

其中，有一個議程是可以實作的，就是在**AWS 開發者專區**內的**在 AWS 環境中，找到高可用性保管服務**議程!!所以以下會以"微逐稿"的方式記錄過程。

## AWS 開發者專區 - 在 AWS 環境中，找到高可用性保管服務
講者：Gea-Suan Lin (DK) / Director of SW Platform and Infrastructures / Migo

{{< img_imgur xHwTihM 90 >}}

在一個網路服務當中，內部會有許多受到控管的資料，例如帳密、API token等，而HashiCorp Vault就可以處理這方面的情境。[HashiCorp Vault](https://www.hashicorp.com/products/vault)為一個完整且獨立的應用程式，對於管理密碼方面有特別的架構，且在處理一些非密碼但敏感性資料也有很好的稽核機制。

## 相關技術
* __AWS EC2__： 由於HashiCorp Vault屬於獨立的軟體，所以我們可以安裝在獨立的機器上。
* __AWS DynamoDB__： 利用它來儲存敏感性資料。
* __AWS KMS__： 因為放置於DynamoDB裡的資料預設是不經過加密的，所以我們使用它。而KMS是在安全性與整合性做得非常好的系統，可以在不公開金鑰的情況來做管理。並且有很好的稽核機制，在任何人使用該金鑰來開任何東西的時候，KMS都會做紀錄。
* __AWS ELB__： 我們在雲端服務當中，為了盡量能夠做到高可靠性，在建立多台的執行個體(Instance)或是容器(Container)等機器後，我們會在機器前面建立Load balancer(LB)，使流量可以引導到後面的機器。

## 實作步驟
1. 建立AWS DynamoDB資料表(名稱可自訂，例如`vault`)
   - __Primary partition key(分區索引鍵)__ 設為`Path`
   - __Primary Sort key(排序索引鍵)__ 設為`Key`
   - 其餘的都預設設定就好

{{< img_imgur 04PYpwC 90 >}}

2. 建立AWS KMS加密金鑰
   - 要取**別名**，其餘的預設即可
   - 建立時，金鑰規格選擇SYMMETRIC_DEFAULT(對稱式加密)就好

{{< img_imgur azVXR36 90 >}}

3. 建立AWS EC2執行個體
   - **兩個**類別為**t3a.nano或t4g.nano**的執行個體
   - AMI使用**Ubuntu Server 20.04 LTS**
   - 兩台須不同的可用區(AZ)，以達到高可靠性

{{< img_imgur sHV55tp 90 >}}
{{< colorful_text text_="" br_="0">}}
{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3-1 安裝指令：(請依據機器架構選擇安裝指令)" br_="0">}}
```bash
# x86_64
cd /tmp;
wget c https://releases.hashicorp.com/vault/1.7.3/vault_1.7.3_linux_amd64.zip; \
unzip vault_1.7.3_linux_amd64.zip; \
sudo cp f vault /usr/local/bin/vault; \
sudo chmod 755 /usr/local/bin/vault

# arm64
cd /tmp;
wget c https://releases.hashicorp.com/vault/1.7.3/vault_1.7.3_linux_arm64.zip; \
unzip vault_1.7.3_linux_arm64.zip; \
sudo cp f vault /usr/local/bin/vault; \
sudo chmod 755 /usr/local/bin/vault
```
{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3-2 建立新使用者與群組：" br_="0">}}
```bash
sudo groupadd r vault;\
sudo useradd g vault r vault
```
{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3-3 建立vault檔案：" br_="0">}}
```bash
sudo mkdir /etc/vault.d;
sudo touch /etc/vault.d/vault.hcl;
sudo chown vault:vault /etc/vault.d/vault.hcl;
sudo chmod 600 /etc/vault.d/vault.hcl #讓這個檔案只有vault可以存取
```
{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3-4 建立vault相關資訊：" br_="0">}}
```bash
# YOUR_CLUSTER_REGION (eg. us-east-1)
# YOUR_ACCOUNT_NAME (eg. 123456789012)

# vault cluster相關設定
api_addr = "http://10.10.10.10:8200" #自己的IP:port
cluster_addr = "http://10.10.10.10:8201" #cluster之間溝通的IP:port
log_level = "Info" #debug相關資訊
ui = true #vault有使用者介面，一般會開啟

# 這台cluster要聽那些port
listener "tcp" {
	address = "0.0.0.0:8200"
	cluster_address = "10.10.10.10:8201"
	tls_disable = "true"
}

# 資料受到甚麼系統保護
seal "awskms" {
	region = "<YOUR_CLUSTER_REGION>"
	access_key = "x" #可省略，但要開對應IAM Role權限
	secret_key = "x" #可省略，但要開對應IAM權限
	kms_key_id = "x" #必定要設定
}

# 資料放置的地方
storage "dynamodb" {
	ha_enabled = "true" #vault本身會去協調哪台現在擁有DynamoDB的權限
	region = "<YOUR_CLUSTER_REGION>"
	table = "vault"
	access_key = "x" #可省略，但要開對應IAM Role權限
	secret_key = "x" #可省略，但要開對應IAM Role權限
}
```
{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3-5 設置systemd設定檔：(vault官方網頁上的範例檔來改)" br_="0">}}
原理：開機的時候運行，如果發現vault有問題時，就需要重跑(裡面有**對應的權限**、**重跑的設定**跟**該檢查的項目**)
```bash
[Unit]
Description="HashiCorp Vault
A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network
online.target
After=network
online.target
ConditionFileNotEmpty=/etc/vault.d/vault.hcl
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read
only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep
caps
AmbientCapabilities=CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server
config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill
signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
Restart=on
failure
RestartSec=5
TimeoutStopSec=30
StartLimitInterval=60
StartLimitIntervalSec=60
StartLimitBurst=3
LimitNOFILE=65536
LimitMEMLOCK=infinity

[Install]
WantedBy=multi
user.target
```

4. 建立AWS IAM角色(Role)
   - 因為沒有設定Access key/Secret_key所以建立IAM Role
   - 先建立一個IAM Role，再將兩個inline policy掛上去，再附加到兩台EC2執行個體上

EC2 IAM Role - Policy-Vault-DynamoDB (JSON)：
* 限制只有"vault"這個資料表是有權限存取的，其餘的不行
```json
// YOUR_CLUSTER_REGION (eg. us-east-1)
// YOUR_ACCOUNT_NAME (eg. 123456789012)
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"dynamodb:BatchGetItem",
				"dynamodb:BatchWriteItem",
				"dynamodb:PutItem",
				"dynamodb:DescribeTable",
				"dynamodb:DeleteItem",
				"dynamodb:GetItem",
				"dynamodb:Scan",
				"dynamodb:ListTagsOfResource",
				"dynamodb:Query",
				"dynamodb:UpdateItem",
				"dynamodb:DescribeTimeToLive",
				"dynamodb:GetRecords"
			],
			"Resource": [
				"arn:aws:dynamodb:<YOUR_CLUSTER_REGION>:<YOUR_ACCOUNT_NAME>:table/vault/stream/*",
				"arn:aws:dynamodb:<YOUR_CLUSTER_REGION>:<YOUR_ACCOUNT_NAME>:table/vault/index/*",
				"arn:aws:dynamodb:<YOUR_CLUSTER_REGION>:<YOUR_ACCOUNT_NAME>:table/vault"
			]
		},
		{
			"Sid": "VisualEditor1",
			"Effect": "Allow",
			"Action": [
				"dynamodb:DescribeReservedCapacityOfferings",
				"dynamodb:ListTables",
				"dynamodb:DescribeReservedCapacity",
				"dynamodb:DescribeLimits"
			],
			"Resource": "*"
		}
	]
}
```
EC2 IAM Role - Policy-Vault-KMS (JSON)：
* 加解密權限設定
```json
// YOUR_CLUSTER_REGION (eg. us-east-1)
// YOUR_ACCOUNT_NAME (eg. 123456789012)
// YOUR_KMS_KEY (eg. 01234567-89ab-cdef-0123-456789abcdef)
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"kms:Decrypt",
				"kms:Encrypt",
				"kms:DescribeKey"
			],
			"Resource": "arn:aws:kms:<YOUR_CLUSTER_REGION>:<YOUR_ACCOUNT_NAME>:key/<YOUR_KMS_KEY>"
		}
	]
}
```
{{< img_imgur s57UTxY 90 >}}

5. 建立AWS ELB
   - 選擇Application Load Balancer (ALB)
     - 以HTTP為主的負載平衡器
   - 可以知道哪台機器是活著的(設定health check路徑)
     - /v1/sys/health
   - Backend in port 8200 (官方常見預設port)
   - Frontend in port 80(HTTP) or 443(HTTPS)
     - 如果有特殊需求需開放至網路上，需使用internet-face ELB

{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="5-1 運行vault：" br_="0">}}
```bash
sudo systemctl daemon reload;  #跟systemd講說要將檔案reload
sudo systemctl enable vault;   #跟systemd講說要跑vault
sudo service vault start    #把跑vault server跑起來
```
{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="5-2 初始化vault：" br_="0">}}
```bash
# Remember to write down the root token
vault operator init
	-recovery-shares=1
	-recovery-threshold=1
	-address=http://127.0.0.1:8200
```
{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="5-3 於vault開始工作任務：" br_="0">}}
* http://vault.example.com
* https://vault.example.com

{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="5-4 Full explanation：" br_="0">}}
* [https://wiki.gslin.org/wiki/Vault/Install](https://wiki.gslin.org/wiki/Vault/Install)