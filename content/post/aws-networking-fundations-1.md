---
author: "Dake Hong"
title: "AWS演講/實作紀錄 #3：AWS 網路基礎架構 - 上篇 (AWS Summit Taiwan 2021)"
date: 2021-10-02T21:20:38+08:00
category: "AWS演講/實作紀錄"
tags: [
    "AWS",
]
---
非常高興可以參加今年的AWS台灣線上研討會，而我在[AWS演講/實作紀錄 #2](https://terahake.in/post/aws-workshop-ha-vault-env/)也有簡單介紹這次的雲端高峰會，歡迎大家可以去瀏覽。
<!--more-->
而我今天要介紹的是[2021 AWS 台灣雲端高峰會](https://aws.amazon.com/tw/events/taiwan/2021summit/) __IT 管理__ 分堂議程 - AWS 網路基礎架構。

## AWS IT 管理 - AWS 網路基礎架構
講者：Shih-Yong Wang, Senior Solutions Architect, AWS

{{< img_imgur omqzFNn 90 >}}

## AWS 全球基礎設施 (AWS Global infrastructure)
目前AWS總共有25個地理區域(region)，81個可用區(Availability Zones, AZs)，詳細可以瀏覽[AWS的相關頁面](https://aws.amazon.com/tw/about-aws/global-infrastructure/)。
{{< img_imgur 21pHLls 90 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="AWS 區域設計(Region Design)理念" br_="0">}}**
一個區域皆由多個可用區(AZs)所組成，而每一個AZ底下皆由多個機房所組成。AWS會這樣設計的原因，是因為要達到 __高可用性(High availability),__ __高擴展性(High scalability)__ 以及 __高容錯性(High fault tolerance)__ 。
{{< img_imgur 8mTqTYN 90 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="AWS 可用區設計(AZ Design)理念" br_="0">}}**
* 一個或多個完全獨立(fully isolated)的基礎建設環境
* 在AWS環境當中，每個AZ之間物理距離會相距非常的遙遠
* 每個AZ都是可以完全獨立運作的環境，包含電力設備、冷氣空調等
* 每個AZ都會配置高達數十萬計(100K+)的伺服器，來達到一定的經濟規模
* 各個AZ之間，都是用光纖(fiber)來做連接

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="可用區內部(intra-AZ)與可用區之間(inter-AZ)連接" br_="0">}}**
* 使用電信等級的**Dark fiber(暗光纖)**來做AZ之間的連結
  - 低延遲、可靠度高
  - Amazon使用它來做可用區內部的連接
* 在可用區之間使用**密集波長分波多工(Dense Wavelength Division Multiplexing, DWDM)系統**來做連接
* 當機房或是可用區(AZ)有出現問題時，故障轉移(failover)的速度會等於光纖等級的故障轉移(failover)速度

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="AWS 網路連結設計" br_="0">}}**
在AWS內部的所有連接點，都會做到 __完全冗餘 (fully redundant)__，換句話說就是完全連接。當線路有出問題時，AWS都會有備用的頻寬與線路去做連接。
{{< img_imgur t818EAu 90 >}}

## AWS Virtual Private Cloud (VPC)
你可以將VPC想像成網路中**虛擬的隔離網路環境**。例如，如果你租用了幾個機櫃，而資料中心會跟你說"這幾個機櫃就是您使用的"，而在雲端上這個隔離環境就稱為VPC。

而在VPC當中，我們可以放置自己的資源(resource)，例如虛擬機、資料庫等。而在VPC裡面，你可完全控制這個虛擬網路環境，包含IP網段範圍(IP address
range)、分割幾個子網域(subnets)、配置路由表(route tables)、配置那些網路閘道器(network gateways)等。且VPC支援IPv4與IPv6。

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="VPC 架設" br_="0">}}**
當我們選擇一個AWS的區域(Region)時，就需要設定一個VPC，而這個VPC會有多個AZ存在，而AZ的功用就是要達到高可用性。
{{< img_imgur eUkN744 70 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Subnet 分割" br_="0">}}**
當我們選擇好VPC與其有哪些的AZ後，下一步驟就是要分割出子網域(subnet)。如同下圖所示，我們可以在"1A"分割一個或多個公有或私有的子網域出來，同樣"1B"也可以分割其他的子網域出來。
{{< img_imgur 3OT16On 70 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="VM 配置" br_="0">}}**
當分割好子網域(subnet)後，下一步驟就可以把虛擬機(VM)平均的配置在所有AZ裡面，而平均配置的用意，是要達到高可用性，如果有一邊的AZ出問題時，就可以自動做切換。
{{< img_imgur qHFayBD 70 >}}

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="VPC 規劃範例" br_="0">}}**
假設我們有好幾台Web Server放置在不同的AZ內，在不同的AZ之間，我們可以用虛擬的防火牆(安全組, Security group)在保護；在後端的application server也一樣用虛擬的防火牆做保護，來達到**高可用性**以及**高安全性**。
{{< img_imgur jhTBVtK 70 >}}

## AWS Gateways 閘道器
**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Amazon Internet Gateway (IGW)" br_="0">}}**
由於VPC是"虛擬私有"的網路環境，並不具有對外連到公開網路的能力，所以假設我們VPC需要對外聯軮的話，就需要安置一個Internet Gateway，它是讓VPC連線到公有網路一個重要的工具。 而由於這個工具基本上是VPC-based，所以可以做到完全的HA(高可用性)，可以不用擔心頻寬上限的問題

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="Amazon NAT Gateway (NAT GW)" br_="0">}}**
假設私有subnet需要互相做連接，或是對外連線的話，就需要NAT Gateway。 NAT Gatway的作用，就是會將私有網路的IP位址，轉譯成對外可以連線到的IP位址，但是外面的IP是連不進這個私有網域的，所以當外面的服務要回應的時候，NAT Gatway會將IP位址轉譯回內部的私有IP位址。 而NAT Gatway是屬於AZ-based，所以每一個AZ都要啟用一個NAT Gateway。

## 連線至其他的VPCs
假設我們要多個VPC，而VPC之間又要互相時，就可以使用VPC Peering。

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="VPC Peering" br_="0">}}**
如果我們希望所有的VPC都兩兩互連的話，就會像是下圖這樣。而VPC Peering可以在**同一個Region**、也可以在**不同的Region**、可以在**同一個帳號裡面**、可以在**不同帳號裡面**，但是這所有互連的VPC，**網段(CIDR ranges)是都不能重疊的**。
{{< img_imgur T8sdnJd 50 >}}

所以如果使用VPC Peering的話，以下幾點需要注意：
- 可以**跨Region**，也可以**跨帳號**
- 可以**直接使用自己的DNS**，跨了VPC還是可以用私有的Hostname
- Peering可以是**IPv4或是IPv6**
- IP網段位址**不能重疊**
- VPC與VPC之間**只能有一個Peering**，因為不需要也不能做的多個Peering
- 跨VPC無法使用jumbo frames(大型封包切割)的功能

**{{< colorful_text color_="192, 100, 50" font_size="1.1" text_="AWS Transit Gateway (TGW)" br_="0">}}**
假設我們有10個VPC，而這10個VPC又兩兩互聯的話，就需要45條Peering((10x9)/2)；但今天如果有100個VPC，就需要4950條Peering((100x99)/2)，這數量相當龐大，所以AWS就推出了**Transit Gateway**來解決這個問題。

我們可以將**Transit Gateway**想成是一個中央的樞紐，任何VPC想要連線到另一個VPC的話，都可以透過這個中央樞紐來做數據交換。 除了可以使用在VPC與VPC之間的連線外，如果今天是透過VPN connection來連線到customer gateway，也是可以透過Transit Gateway來做連線，又或者透過AWS Direct Connect Gateway也是可以連線，者樣就不需要一個個網段去做peering。
{{< img_imgur Rhpxh85 70 >}}

而Transit Gateway(TGW)會有以下的特性：
- 在一個帳號或VPC裡，可以安裝(attach)**5個TGW**
- 每一個TGW，在最大突發(burstable)可以達到**50Gbps的頻寬上限**
- 每一個TGW，可以設定**10,000條**的路由表(Routes)
- 每一個TGW裡面，可以安裝(attach)**5,000 VPC**在裡面