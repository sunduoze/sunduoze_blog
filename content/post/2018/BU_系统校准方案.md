---
categories:
- 笔记
date: 2018-10-27T16:12:14+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "BU_系统校准方案"
url: ""
---

</br>


---
## 校准方案
---

![校准流程](Snipaste_2018-10-22_15-36-14.png)
---


<details>
  <summary> 1.标准源校准  </summary>
  </br>L. C. R ...</br>
</details>
</br>
<details>
  <summary> 2.校准仪器校准  </summary>
  </br>V. I. f ...</br>
</details>

### 校准流程

 稳定性分析 </br>
 数据采集及分段 </br>
 分段校准 </br>
 结果验证（校验）</br>

校准：数据拟合-数据-滤波-拟合-判断拐点-分段-拟合-去除不连续点

### 校准类型
* 单板校准
 </br> 适用于简单的系统
* 系统校准  
适用于复杂的系统
</br> 系统中存在多种因素的耦合，单板校准可能不是十分理想。

#### 建议

* 单板校准
1. 现有方案：单个板卡独立成模块，类似于标准仪器， 通过uart交互。
1. 新方案1：单个板卡包含电路部分和校准数据存储部分。通过IC的协议进行交互。
1. 新方案2：前2种方案并存。







|  板卡類型  |   板卡名  |  指标  |  應用  |
|:--------:|:--------:|:----------:|:-------:|
|   电池模拟器|   PWR0402 | 单节锂电池 电流最大3A |  IA565  |
|   电池模拟器|   PWR0902 |  两节锂电池 电流2A   | IA94X和IA620 |
|   电子负载|   PWR0905 |  20V 5A | IA94X和IA620 |
|   电子负载|   proton |  2A | IA94X和IA620 |
|四线电源|PWR0204 |  2A | IA912，IA565，IA695输出0.1～12V电流最大1.5A |
|四线电源|PWR2004 |  3A | IA94X，IA620 |

|  应用  |   指标  |  其他  |
|:--------:|:--------:|:----------:|
|mac type-c|	61W，20.3V-3A，9V-3A，5.2V-2.4A|---|
|平板|	87W，20V-3A，15V-3A，5V-2A|---|

<details>
  <summary>这里是下拉</summary>
*  wedfgh
*  1。12233
*  <summary>这里是下拉</summary>33444
*  45433
</details>
