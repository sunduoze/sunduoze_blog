---
categories:
- 笔记
date: 2021-11-02T13:45:06+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "High_speed_layout"
url: ""
math : true
mermaid : false
---


## ADI高速印刷电路板布局实用指南

high-speed-printed-circuit-board-layout

* 作者John Ardizzoni

尽管其在高速电路中具有重要性，但是PCB布局通常是设计过程的最后步骤之一。高速PCB布局有很多方面；已经写了很多卷关于这个问题。本文从实用角度触发阐述高速布局。主要目的是帮助新手了解高速电路板布局时需要解决的众多因素。但是它也旨在作为一个复习，让原理电路布局一段时间的人受益。这里不会对每个主题进行详细介绍，但我们解决了在提高电路性能，缩短设计时间和最大限度的减少耗时修订方面获得巨大回报的关键领域。

</br>

### 原理图

虽然没有保证，但好的布局从好的原理图开始。在绘制原理图时要周到和慷慨，并且考虑通过电路的信号流。按从左到右的流向绘制的原理图也有利于板上布局。尽可能在原理图上放置更多有用信息。设计者，技术人员和工程师从事这份工作时将非常感激，包括我们自己；有时设计者不在的情况下客户会要求有关此电路的帮助。
</br>
除了通常的参考标号，功耗，容差之外哪些信息属于原理图？ 这里有一些可将普通原理图转化为高级原理图的建议！增加波形，有关机箱或外壳的机械信息，线长，禁止布线区，设计哪些器件在板子top面；包含调谐，元件值范围，热信息，受控阻抗线，注释，简要操作说明......

### Trust No One

如果你没有自己layout，请务必留足够的时间和layout人员一起完成设计。此时的片刻预防可省下很多时间。不要期望layout人员能够读懂你的想法。你的输入和指导在layout的开始阶段至关重要，在整个布局过程中你提供越多的信息将产出更好的layout设计。给layout人员提供临时完成点---你希望在其中得到layout进度信息方便快速review，这种“循环闭合”可防止layout误入歧途并尽可能减少rework。

</br>
你对layout人员的说明应该包括：

1. 简短的描述电路功能
2. 输入输出位置的草图
3. 叠层信息（板厚，层数，信号层和信号平面的细节：电源，接地，模拟，数字，RF）
4. 哪个信号需要在哪一层
5. 关键器件的位置
6. 旁路器件的位置
7. 哪些信号先需要控制阻抗线
8. 哪些信号线需要匹配长度
9. 元件尺寸
10. 哪些电路需要远离or靠近
11. 哪些器件需要远离or靠近
12. 哪些器件位于顶层和底层

</br>
你永远不要觉得你告诉了别人太多信息
</br>
</br>
一个学习经验：约10年前我设计了一个多层表贴的2面贴装板。电路板用许多螺丝固定在镀金铝制外壳（由于严格的震动规格）。bias feed-through脚穿过整个板子并通过wire-bonded（键合线）合到PCB上。这是个复杂的装配工作。一些板上的器件是用于SAT（测试时设置set as test），但是我并未阐述这些器件的放置位置，你可以猜到摆到哪？-对，板子底部。这样生产工程师和技术员不得不拆开装配部分调整该值...... shit, WTF?

### 位置 位置 位置

和房地产一样位置就是一切。电路放置到板上，各个器件位置和相邻的部分都是关键。
</br>
通常，输入输出和电源是被定义的，但他们之间发生的事情是“可供争抢”，这是关注layout细节将获得显著回报的地方。从单个电路和整个电路板和关键器件的摆放开始，早先制定关键器件位置和信号布线（signal routing）路径有助于电路按照设计预期来工作，这样有助于降低成本和压力并缩短周期。

### 电源旁路

在运放供电端旁路电源来最小化噪声是PCB设计的关键方面---高速运放或高速电路。
</br>
**2种通用的旁路高速运放的配置：**

* Rails to ground:

多数情况下效果很棒，它使用多个并联的电容直接接到运放的电源和地引脚。统称两个电容足够，但一些电路会受益于电容的多个并联。
</br>
并联不同容值的电容有助于电源脚在宽频带范围的低的交流阻抗。这在运放的PSR（电源抑制）滚降的情况下非常重要。电容有助于补偿降低了的PSR。在数个10倍频程下保持低阻接地有助于保证不希望的噪声流入运放。Figure1展示了多个电容并联的好处。低频下大电容提供了低阻路径到地。一旦接近电容的SRF（自谐振频率）其电容质量下降并成为电感。这就是为何使用多个电容的重要原因：当一个电容频率响应开始滚降，另一个变得很大，从而在数个10倍频程下保持低的交流阻抗。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure1.png" width="1153px" height="203px"/>
</div>

直接从电源的pin脚开始；从低值和小尺寸开始放置到运放的同侧并尽可能靠近。电容的接地测走线应尽可能的短。地的连接应该尽可能靠近运放的负载以最大限度的减少电源&地之间的干扰，Figure2说明了该技术。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure2.png" width="1153px" height="203px"/>
</div>

接下来摆放的更大值的电容应该重复这个过程。一个好的布局开始会放置10nF作为最小值的电容，2.2uF or 更大的低ESR电解电容作为下一个电容(?)。0805封装的10nF电容具有低ESL和卓越的高频性能。


* Rail to rail:

一种备选的配置是使用1or多个电容放置到运放正负电源轨之间。当电路很难有所有4个电容(VCC-2cap-GND-2cap-VEE)时通常使用该方法，此方法的缺点是电容的尺寸会变大，同时电容的耐压是单电源旁路的2倍。高的电压需要更高耐压的电容，有更大的尺寸，但是此选项可改善PSR和失真性能。

</br>
由于每个电路和布局不同，电容的配置和数量需要酌情考虑。

#### 寄生效应

讨厌的寄生虫会进入PCB并对电路造成严重破坏。他们是隐藏的杂散电容和电感，可以渗透到高速电路。他们包括封装引脚和多余的走线；焊盘对地，焊盘到电管焊盘，焊盘到电容走线；过孔等等。
Figue3(a)是典型的同相放大器，如果考虑寄生元件则会演变为Figue3(b).

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure3.png" width="1153px" height="203px"/>
</div>

在高速电路中，不需要太大的值就可以影响电路性能。有时只需要0.1pF就足够了。Eg. 在反相输入端增加1pF的寄生电容可引起频域的2dB峰值（Figure4）。如果有足够的电工，它会导致不稳定和震荡。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure4.png" width="1153px" height="203px"/>
</div>

在寻找有问题的寄生效应来源时，一些计算那些小鬼的基本公式可以出场：
</br>
平行板电容公式：公式1 & Figure5

$C=\frac{kA}{11.3d}pF\tag{1}$

$C:电容, A:板的面积 cm^2, k:板材相对介电常数, d:板之间距离 cm$

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure5.png" width="1153px" height="203px"/>
</div>

条形电感是另一种需要考虑的寄生电路，这是由于走线长度过大或缺少接地层造成。
</br>
走线电感公式：公式2 & Figure6

$Inductance=0.0002L\Bigg[ln\frac{2L}{W+H}+0.2235\Big(\frac{W+H}{L}\Big)+0.5\Bigg]uH \tag{2}$

$L:线长 mm, W:线宽 mm, H:走线厚度 mm$

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure6.png" width="1153px" height="203px"/>
</div>

图7中的震荡显示了2.54mm(100mil)走线对高速运放同相输入的影响。等效杂散电感为29nH，在整个瞬态响应期间存在，足以引起连续的低电平震荡。该图还显示了如何使用接地层来减轻杂散电感的影响。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure7.png" width="1153px" height="203px"/>
</div>

</br>

过孔Vias是寄生参数的另一个来源；它们可以引入电感和电容。
</br>
Vias寄生电感：公式3 & 图8

$L=2T\Bigg[ln\frac{4T}{d}+1\Bigg]nH \tag{3}$

$T:电路板厚度 cm, d:通孔直径 cm$

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure8.png" width="1153px" height="203px"/>
</div>

Vias寄生电容：公式4

$C=\frac{0.55\epsilon_rTD_1}{D_2-D_1}pF \tag{4}$

$\epsilon_r$:基板材料相对导磁率, T:电路板厚度 cm, $D_1$:围绕通孔的垫的直径 cm, $D_2$:接地平面中的间隙孔的直径 cm$\tag{4}$
</br>
0.157cm厚的电路板中，单个通孔可增加1.2nH的电感和0.5pF的电容；这就是layout的时候不舍昼夜来尽可能减少寄生虫的渗透！

### 地平面

此部分的内容远不止此，但我们重点介绍一些关键特性并鼓励读者更详细的研究该主题。本文结尾将有一些参考列表。

</br>

接地层的作用是公共参考电压，提供屏蔽，实现散热，减少分布电感（但是会增加寄生电容）。虽然使用地平面有很多优点，但实施时必须小心，因为它做什么或不做什么都有限制。

</br>

理想情况下，PCB的一层专门用作接地。整个盘没有间断可获得最佳效果。需要抵制住在此层走其他信号线的诱惑。接地平面通过导体和接地平面的磁场相互抵消来减少引线电感。当接地平面取消时，可将不希望的寄生电感引入走线下方或者接地平面上方。

</br>

尽管如此也有例外，有时地平面越小越好。如果从高速运放的输入输出焊盘的下方移除地平面可以获得更好的性能。
输入端接地引入的杂散电容会加到运放的输入电容上，会降低phase margin并导致不稳定。从寄生参数来看，运放输入端的1pF电容会导致严重的峰值。输出端的电容负载（包括杂散）会在反馈环中产生一个极点pole，这会降低phase margin并可能导致电路变得不稳定。

</br>

模拟和数字电路，包括地和地平面应该尽可能的分开。快速的上升沿会流入电流尖峰到地平面中。这些快速电流尖峰会产生噪声可能会破坏模拟电路性能。弄滴和数字接地（和电源）应该单点接地以最小化数字和模拟接地环流和噪声。

</br>

在高频下，必须考虑趋肤效应。趋肤效应引起电流在导体外表面流动，从而使导体变窄，因此增加了DCR。虽然趋肤效应超过了本文范围，比较近似的趋肤深度cm用公式5计算：</br>
$Skin Depth=\frac{6.61}{\sqrt{f(Hz)}} \tag{5}$
</br>
不太敏感的电镀金属有助于减少趋肤效应。

### 封装

运放通常提供各种封装，这些封装可影响运放的高频性能。主要影响寄生参数（前面提及的）和信号布线（signal routing）。这些我们着重看输入，输出，电源到运放的布线。

</br>

图9显示了SOIC(a), SOT-23(b)这两种封装运放的layout差异。每种封装都有其自身的挑战。关注(a)，仔细检查反馈路径表明有多种选择来routing反馈线，保持最短的走线是最重要的，反馈中的寄生电感会引起振铃和过冲。在图9(a) & (b)中是围绕放大器布线的。图9(c)中显示了另一种方法---在SOIC封装下方走反馈线---最小化反馈路径长度。每种选择都有细微差别，第一种选择会导致走线过长，ESL增加；第二种选择使用过孔，可能会引入寄生电容和电感。在layout过程中必须考虑这些寄生效应带来的影响。SOT-23封装的layout机会是理想的：最小的反馈走线长度和过孔影响；负载和旁路电容通过短的路径共同接地连接；正轨旁路电容（图中未标出）直接位于负轨旁路电容的下方PCB的bottom面。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure9a.png" width="1153px" height="203px"/>
</div>

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure9b.png" width="1153px" height="203px"/>
</div>

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure9c.png" width="1153px" height="203px"/>
</div>

</br>

* 低失真的放大器引脚排布：

新的低失真引脚排布用在了ADI的一些放大器中（Eg.AD8045），有助于消除以上两个问题；他还改善了2个其他重要领域的表现。LFCSP封装的低失真引脚排序（Figure10）采用传统放大器的引脚排列，逆时针旋转一个引脚并添加第二个输出引脚作为专用反馈引脚。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure10.png" width="1153px" height="203px"/>
</div>

低失真引脚排列允许输出（专用反馈引脚）和反向输入引脚精密连接，如图Figure11所示。这极大的简化了线路layout。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure11.png" width="1153px" height="203px"/>
</div>

另外一个好处是降低了二次谐波失真。传统的运放引脚配置中的二次谐波失真的一个重要原因是同相输入端与负电源轨之间的耦合。LFCSP封装的低失真引脚排列消除了这种耦合，大大降低了二次谐波失真；在某些情况下降低幅度可达14dB。Figure12显示了AD8099 SOIC和LFCSP封装之间的失真性能差异。
</br>
该封装的另一个优势---功率耗散。LFCSP提供裸露焊盘，可降低封装热阻，并可将$\theta_{JA}$提高约40%，凭借其低热阻，该设备运行温度更低，从而提高了可靠性。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure12.png" width="1153px" height="203px"/>
</div>

目前3款ADI的告诉运算放大器均采用新型低失真引脚排列：AD8045 AD8099 AD8000

### 布线及屏蔽

电路板上存在各种数字和模拟信号，具有高压低压和直流到GHz的电流。保持信号彼此的干扰很困难。

回顾“Trust No One”的建议，提前考虑如何在电路板上处理信号的计划至关重要。要注意哪些信号是敏感的，并确定必须采取哪些步骤来保持完整性。接地层为电信号提供公共参考点，他们也可以用于屏蔽。当信号需要被隔离时，首先要提供2信号线之间的物理距离。以下是需要遵循的良好做法：

1. 最小化同一板子的长的并行走线和间距将减少电感耦合
2. 最小化相邻层之间的长的走线以防止电容耦合
3. 高隔离度的信号走线要layout到不同的层上---并且如果他们不能被完全隔开---应该在其间具有接地平面的情况下彼此正交。正交布线将使得电容耦合最小化，并且接地将形成电屏蔽，该技术用于形成*受控阻抗线*

高频（RF）信号通常在受控阻抗线上允许，也就是说走线保持特征阻抗，Eg50 Ohms（典型的RF应用）。两种常见类型的受控阻抗线，微带线和带状线都可以产生类似的结果，但是具有不同的实现方式。

</br>

微带控制阻抗线，如Figure13所示，可以在电路板的任意侧允许；它使用紧邻其下方的地平面作为参考平面。
<div>
    <img src="/media/note_img/Hi_speed_layout/Figure13.png" width="1153px" height="203px"/>
</div>

公式6用于计算FR-4的特征阻抗：

$Z_0=\frac{87}{\sqrt{\epsilon_r + 1.41}}ln\Bigg[\frac{5.98H}{0.8W + T}\Bigg] \tag{6}$

H:地平面到信号走线的距离 mil, W:走线宽度 mil, T：走线厚度 mil, $\epsilon_r$是板材介电常数

</br>

带状线控制阻抗线（见Figure14）使用两层接地层，信号迹线夹在它们之间。这种方法使用更多的走线，需要更多的电路板层，对电介质厚度变化敏感，并且成本更高---因此它通常仅用于要求苛刻的应用中。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure14.png" width="1153px" height="203px"/>
</div>

带状线的特征阻抗设计方程如公式7所示：
$Z_0=\frac{60}{\sqrt{\epsilon_r }}ln\Bigg[\frac{1.9B}{0.8W + T}\Bigg] \tag{7}$

</br>
</br>

保护环是与运放一起使用的另一种屏蔽类型；它用于防止杂散电流流入敏感节点。该原理是直接的---完全围绕敏感节点，其中保护导体保持在或者被驱动到（在低阻抗下，例如电压跟随）与敏感节点相同的电位，并因此从杂散节点吸收杂散电流。
Figure15(a)显示了反相和同相放大器配置保护环的原理图。Figure15(b)显示了SOT-23-5封装的两个保护环的典型实现。

<div>
    <img src="/media/note_img/Hi_speed_layout/Figure15.png" width="1153px" height="203px"/>
</div>

屏蔽和布线还有许多其他选择。读者可参考以下文献获取更多。

### 结论

智能电路板布局对于成功的运算放大器电路设计非常重要，特别是对于高速电路。良好的原理图是良好布局的基础; 电路设计师和布局设计师之间的紧密协调至关重要，特别是在零件和布线的位置方面。需要考虑的主题包括电源旁路，最小化寄生效应，使用接地层，运算放大器封装的影响以及布线和屏蔽方法。
</br>
</br>

### 参考文献

Ardizzoni, John, “Keep High-Speed Circuit-Board Layout on Track,” EE Times, May 23, 2005.

Brokaw, Paul, “An IC Amplifier User’s Guide to Decoupling, Grounding, and Making Things Go Right for a Change,” Analog Devices Application Note AN-202.

Brokaw, Paul and Jeff Barrow, “Grounding for Low- and High-Frequency Circuits,” Analog Devices Application Note AN-345.

Buxton, Joe, “Careful Design Tames High-Speed Op Amps,” Analog Devices Application Note AN-257.

DiSanto, Greg, “Proper PC-Board Layout Improves Dynamic Range,” EDN, November 11, 2004.

Grant, Doug and Scott Wurcer, “Avoiding Passive-Component Pitfalls,” Analog Devices Application Note AN-348.

Johnson, Howard W., and Martin Graham, High-Speed Digital Design, a Handbook of Black Magic, Prentice Hall, 1993.

Jung, Walt, ed., Op Amp Applications Handbook, Elsevier-Newnes, 2005.

</br>

<div>
    <a href="/media/note_img/EA/high-speed-printed-circuit-board-layout.pdf">high-speed-printed-circuit-board-layout</a>
</div>

<div>
    <a href="/media/note_img/EA/Altera公司高速PCB布线指南.pdf">【待整理学习】Altera公司高速PCB布线指南</a>
</div>

</br>
</br>