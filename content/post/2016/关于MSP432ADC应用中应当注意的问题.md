---
categories:
- 技术
date: 2016-08-09T18:44:02+08:00
keywords:
- 嵌入式
title: 关于MSP432ADC应用中应当注意的问题
url: ""
---

## SAR 型 ADC 的设计技巧

德州仪器高性能单片机和模拟器件在高校中的应用手册-精密信号链[.P25]
<br/>

> 在运放和 SAR ADC 间插入 RC 组合

<div>
    <img src="/media/note_img/1_1_MSP432ADC.jpg" width="609px" height="184px"/>
    <img src="/media/note_img/1_2_MSP432ADC.jpg" width="624px" height="465px"/>
	<img src="/media/note_img/1_3_MSP432ADC.jpg" width="609px" height="566px"/>
	<img src="/media/note_img/1_4_MSP432ADC.jpg" width="690px" height="403px"/> 
</div>


其中Cin通常选为1nF；
<br/>
MSP432 DS中有关12位SAR ADC 的介绍
<div>
    <img src="/media/note_img/1_5_MSP432ADC.jpg" width="609px" height="184px"/>
</div>

根据上边要求的值计算，先选择放大器到ADC的电容Cfilter选1000pF（常常选1nF，银云母 or 
CoG电容）-稳定的电压、频率特性 那么，放大器到ADC的电阻Rfilter选14-20欧姆

<br/>
<br/>
<br/>