---
author: "Dake Hong"
title: "AWS演講/實作紀錄 #4：AWS 網路基礎架構 - 下篇 (AWS Summit Taiwan 2021)"
date: 2021-10-04T17:02:23+08:00
category: "AWS演講/實作紀錄"
tags: [
    "AWS",
]
---
上篇主要使在講述雲端上的VPC互相連線，而這篇是要講述連回實體機房，或是自己公司內部的部分是如何連線的。
<!--more-->

## 連線至本地端網路(on-premises networks)
**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="AWS site-to-site VPN" br_="0">}}**
我們可以透過site-to-site的VPN，把本地端的環境與雲端的環境做串接，建立一個VPN的connection，但要注意的一點，在customer gateway與virtual private gateway之間，是會有兩條隧道(tunnel)的，原因是做到高可用性，AWS會自動許怎其中一條隧道來當作active、另一條當做standby。
{{< img_imgur 2OsELN7 90 >}}

## Amazon VPC 端點(endpoints)
大致上可以分成三個類型：

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Amazon VPC 閘道型(Gateway) endpoints" br_="0">}}**
如果在VPC裡面，我們有許多的子網段，而這些子網段都有不同的虛擬機在裡面。假設我們需要連線到AWS S3或是DynamoDB，那我們要如何做?

1. 需要一個**網路閘道(IGW)**來對外做溝通。
2. 在不同的子網段內部須**設定相對應的路由**，讓我們的traffic可以連到外部的世界。
3. 在IGW上面，還需要有公有的IP位址(Elastic IP, EIP)

所以如果需要對外連到S3或是DynamoDB，路由走法就是透過IGW，走外部的公有網路，才能連接到S3或是DynamoDB。
{{< img_imgur LjvP3JH 70 >}}

但有沒有更好的解法? 有的，AWS提供了Gateway Endpoint，在VPC上面裝一個端點，而這個端點可以透過路由表的設定，這樣就不用公有的網路存取，走內部的網段就可以連接到S3或是DynamoDB。(VPCE = Virtual Private Cloud Endpoint)
{{< img_imgur rV3IYNQ 70 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Amazon VPC 介面型(Interface) endpoints" br_="0">}}**
AWS有很多其他全託管的服務，是可以不需要修改路由表就可以使用的，而這些就叫做**介面型端點(interface endpoints)**。所以只要啟用了介面型的端點，就可以AWS大約五十到六十個的服務，例如CloudWatch、CloudFormation等。
{{< img_imgur Cc1FWNj 90 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="AWS PrivateLink for service providers" br_="0">}}**
假設這個服務不是由AWS託管，而是自建立的，但又希望整個最終計畫(end plan)留在AWS裡面，這時候就是要使用PrivateLink。 PrivateLink的做法，就是會在我們要連出來的VPC裡面，使用VPC Endpoint，透過它來連線到我們想要的地方，例如對方服務上的ELB。這整條路上都會在AWS的內部，完全不會接觸的外部的世界。
{{< img_imgur AuJmGLd 70 >}}

## Amazon 網路安全(Network Security)
在一個雲端環境當中，要如何做到**安全、可靠**的資安環境? 在AWS環境，做到安全有兩個方法：

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Network Access Control Lists (NACLs)" br_="0">}}**
- 它是一個subnet-based的安全方式，且是一個無狀態(stateless)的控制方式
  - 無狀態(stateless)：進去/出來須分別設定，如果只設定出去，會不知道如何回來
- 它可以設定**允許(allow)**與**禁止(Deny)**兩個狀態，依照順序與功能而定。
  - 初始的話，建議是全部先禁止，再將允許一條條的加進去
  - 預設是**全部允許(Allow All)的**
- 限制：
  - Network ACLs per VPC: 200
  - Rules per network ACL: 20/40
{{< img_imgur zDqg6lz 90 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Security Groups" br_="0">}}**
- 它是一個instance-based的安全控制方式，是設定在虛擬機上面的，且是一個有狀態(stateful)的控制方式
  - 有狀態(stateful)：設定了出去，就知道怎麼回來
- 它"只能"設定**允許(allow)**狀態
- 限制：
  - Security groups per ENI: 5
  - Rule per security group: 60
{{< img_imgur MAf6KPo 90 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Security Groups vs. NACLs" br_="0">}}**
|Security Groups|Network ACLs|
|:--|:--|
|運作於執行個體上 Operates at instance level | 運作於子網域上 Operates at subnet level|
|只支援允許規則 Supports allow rules only | 支援允許與禁止規則 Supports allow and deny rules|
|有狀態：無論規則如何，都會自動允許返回流量 Stateful: return traffic is automatically allowed regardless of any rules | 無狀態：規則必須明確允許返回流量 Stateless: return traffic must be explicitly allowed by rules|
|在決定是否允許流量之前評估所有規則 All rules evaluated before deciding whether to allow traffic | 決定是否允許流量時按順序評估的規則 Rules evaluated in order when deciding whether to allow traffic|
|僅適用於與安全組明確關聯的實例 Applies only to instances explicitly associated with the security group | 自動應用於啟動到關聯子網中的所有實例 Automatically applies to all instances launched into associated subnets|