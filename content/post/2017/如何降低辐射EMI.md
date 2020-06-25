---
categories:
- 笔记
date: 2017-01-11T16:03:50+08:00
keywords:
- 电源
title: 如何降低辐射EMI
url: ""
---

<br/>

## 合理的PCB Layout 来降低设计中辐射EMI


SMPS中，开关动作电流产生高频分量（方波中含有丰富的高频分量）
<br/>！Buck电路中 只有一条线的支路电流是断续的

<br/>Key1：保证电流断续的回路所包围的面积最小
<br/>Key2：使反馈管脚的走线（敏感节点）短而细（寄生电容最小）两个分压电阻尽可能的靠近反馈管脚和AGND（Vout拉长线到FB脚附近的分压电阻）
<br/>Key3：中间增加接地层

<div>
    <img src="/media/competition_img/合理布局降低EMI.png" width="609px" height="184px"/>
</div>

### Layout Attention
1. High frequency bypass capacitors should be located as close as VIN & PGND Pins.
2. Cboot capacitor（高边自举电容）should be located as close as IC Pins.
3. FB pin's divider resistance should be located as close as IC（FB & AGND Pins）

**测试环境** 3m实验室 铁氧体墙壁+天线



<br/>
<br/>
<br/>
<br/>
<br/>