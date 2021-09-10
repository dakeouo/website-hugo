---
author: "Dake Hong"
title: "AWS實作紀錄 #1：定時開關機的AWS EC2執行個體"
date: 2021-09-06T11:00:13+08:00
category: "AWS實作紀錄"
tags: [
    "AWS",
    "AWS IAM",
    "AWS EC2",
    "AWS Lambda",
    "AWS CloudWatch",
]
---
我們有時候不想要讓[Elastic Compute Cloud (Amazon EC2)](https://aws.amazon.com/tw/ec2/)的執行個體每個月都開720小時(24小時x30天)，而是想要定時開關機來節省經費(例如：只想平日朝九晚五開啟執行個體)，那要如何做? 我們可以使用[Lambda](https://aws.amazon.com/tw/lambda/)和[CloudWatch](https://aws.amazon.com/tw/cloudwatch/) Events來達成定時開關機的任務。
<!--more-->
雖然目前AWS已經有提供[Instance Scheduler](https://aws.amazon.com/tw/solutions/implementations/instance-scheduler/)這個強大的排程服務，但是如果單純只想要定時開關機的話，使用Lambda和CloudWatch Events就好。

## 操作步驟
1. 建立給Lambda的IAM角色(Role)和政策(Policy)
2. 分別建立開機與關機的Lambda Function
3. 分別建立開機與關機的可自動排成的CloudWatch Events

## 解決方案
## Step1. 建立一個Lambda的IAM Policy
**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="1. 使用以下的JSON，貼至建立政策的JSON頁面" br_="0">}}**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Start*",
        "ec2:Stop*"
      ],
      "Resource": "*"
    }
  ]
}
```
{{< img_imgur DLRvcQ6 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="2. (選用)有需求可以新增標籤" br_="0">}}**
{{< img_imgur 7nfCgre 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3. 填入政策名稱" br_="0">}}**
{{< img_imgur SB5F8sh 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="4. 政策建立完成" br_="0">}}**
{{< img_imgur 4LrzokI 100 >}}

## Step2. 建立一個Lambda的IAM Role
**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="1. 選擇AWS服務->Lambda" br_="0">}}**
{{< img_imgur iybRuiM 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="2. 搜尋剛剛建立的政策名稱->勾選其政策" br_="0">}}**
{{< img_imgur yQG12Ki 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3. (選用)有需求可以新增標籤" br_="0">}}**
{{< img_imgur V9Hbrle 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="4. 填入角色名稱" br_="0">}}**
{{< img_imgur Xj7UU2G 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="5. 角色建立完成" br_="0">}}**
{{< img_imgur RTDkpty 100 >}}

## Step3. 分別建立開機/關機的Lambda Function
**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="1. 選擇'重頭開始撰寫'->輸入函式名稱->選擇執行語言->按下'變更預設執行角色'" br_="0">}}**
{{< img_imgur tfF6OEn 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="2. 選擇'使用現有的角色'->選擇剛剛建立的Lambda角色" br_="0">}}**
{{< img_imgur PgKNcn5 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3. 依據目前建立[開機/關機]將以下指定程式碼貼入'Lambda_function'的檔案裡->按下'Deploy'部屬程式" br_="0">}}**
```python
# =================================================================================
# == 將 YOUR_EC2_INSTANCE_REGION 修改成 "自己實行個體的區域(Region)" ==
# == 將 YOUR_EC2_INSTANCE_ID 修改成 "自己實行個體的ID(Instance ID)" (可新增多台) ==
# =================================================================================

# 開機(Start)的Lambda Function Code
import boto3
region = 'YOUR_EC2_INSTANCE_REGION(eg.us-east-1)'
instances = ['YOUR_EC2_INSTANCE_ID(eg.i-12345cb6de4f78g9h)']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('started your instances: ' + str(instances))

# ----------------------------------------------------------
# 關機(Stop)的Lambda Function Code
import boto3
region = 'YOUR_EC2_INSTANCE_REGION(eg.us-east-1)'
instances = ['YOUR_EC2_INSTANCE_ID(eg.i-12345cb6de4f78g9h)']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))
```
{{< img_imgur 9sinD1j 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="4. 將開機/關機的函式分別部屬完成" br_="0">}}**
{{< img_imgur V89j32o 100 >}}

## Step4. 分別建立開機/關機的CloudWatch Event
**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="1. 選擇'事件'&'規則'->點選'排程'->選擇'Cron表達式'->按下右側'新增目標'" br_="0">}}**

[Cron表達式](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)說明：

- 以 __分/時/每月-天/月/每月-周/年__ 排序
  - __{{< colorful_text text_="*" >}}__ 代表所有值
  - __每月-天__ 為每個月的第X天 / __每月-周__ 為每個月的星期X
    - __{{< colorful_text text_="*" >}}__ 在 _每月-天_ 與 _每月-周_ 不得同時使用，另一 個必須為 __?__
- 時間為 __中原標準時間(GMT)__
  - 如果設定每天 __台灣時間早上9點__ 開機， __台灣時間下午5點__ 關機
    - 開機(start)Cron表達式 => 0 1 ? * MON-FRI *
    - 關機(stop)Cron表達式 => 0 9 ? * MON-FRI *
- Cron設定完成後，下方會顯示接下來10個觸發的日期

{{< img_imgur M15j4Pb 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="2. 選擇'Lambda 函數'->選擇剛剛建立的[開機/關機]Lambda Function" br_="0">}}**
{{< img_imgur JTmygB8 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="3. 設定規則名稱與描述" br_="0">}}**
{{< img_imgur r4khaCX 100 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="4. 完成事件規則建立" br_="0">}}**
{{< img_imgur KCbckbg 100 >}}

---
**{{< colorful_text color_="100, 100, 100" font_size="1.25" text_="參考來源" br_="0">}}**
- [使用 Lambda 定期停止和啟動 Amazon EC2 執行個體](https://aws.amazon.com/tw/premiumsupport/knowledge-center/start-stop-lambda-cloudwatch/)
