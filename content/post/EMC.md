---
categories:
- 笔记
- 技术
date: 2022-03-09T16:15:21+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "EMC"
url: ""
draft: false
math : true
mermaid : false
wavedrom : false
---


## SI signal integrity 信号完整性

信号边沿越快，信号越完整，信号品质越好，但对EMI不好

## PI power integrity 电源完整性

模拟数字，高频低频混合信号区域若分割不当容易相互串扰（传导干扰 conduction）

## EMC（EMI电磁干扰 + EMS电磁耐受）电磁兼容

EMI（电磁辐射） = 辐射干扰（conduction） + 传导干扰（emission）

## 眼图

由于示波器的余晖作用，将扫描所得的每个码元波形重叠在一起，形成眼图。眼图可观察码间串扰和噪声影响，是分析高速系统SI分析的核心。

</br>一个完整眼图应该包含从‘000’到‘111’的所有状态组。

</br>眼图包含眼高、眼宽、眼幅度、眼交叉比、“1”电平， “0”电平，消光比，Q 因子，平均功率等参数。

### ESD

1. 传导性ESD防护，敏感器件前端增加器件引导或耗散电流。陶瓷电容，压敏电阻MOV，TVS管，陶瓷气体放电管GDT等
2. 辐射性ESD防护，静电产生的场对敏感电路的影响。常使用等位体法，使壳体形成电位相同体来抑制放电。

## 信号完整性分析概论

1. 信号完整性（SI）：指在高速产品中由互联线引起的所有问题；研究当互联线与数字信号的电压电流波形相互作用时，其电气特性如何影响产品的性能，SI又叫信号波形失真。
2. 电源完整性（PI）：指为有源器件供电的互联线及各相关元件上的噪声；PDN（电源分配网络）
3. 电磁兼容（EMC）：主要是指产品自身产生的电磁辐射和由外场导入产品的电磁干扰；一般讨论方案时说电磁兼容，讨论辐射问题时说电磁干扰（EMI）。
4. 串扰：在传播信号时，有些电压和电流能够传递到邻近的静态网络上，而这个网络正在处理自己的事务。
5. 轨道塌陷：当通过电源路径和地路径的电流发生变化，如芯片输出翻转或内核中的门翻转时，在电源路径和地路径之间的阻抗上产生一个压降。
6. 电磁干扰（EMI）：电磁干扰包括三个方面：噪声源、辐射传播路径和天线。
7. SI、PI、EMI六种关键类型
</br>

（1）单一网络的信号失真；
（2）互联线中频率相关损耗引起的上升边退化；
（3）两个或多个网络之间的串扰；
（4）作为串扰特殊形式的地弹和电源弹；
（5）电源和地分配中的轨道塌陷；
（6）来自整个系统的电磁干扰和辐射。
8. 信号完整性的两个推论：一是随着上升边的减小，这六种问题会变得更严重；二是解决信号完整性的有效办法在很大程度上是基于对互联线阻抗的理解。
9. 仿真：三种电气仿真工具
（1）电磁仿真器或3D全波场求解器
（2）电路仿真器
（3）数值仿真工具

10. 模型与建模
（1）SPICE，通过求解电路元件表示的微分方程，然后计算时域或频域中的电压和电流，这一过程在时域中称为瞬态仿真，在频域中称为交流仿真。
（2）IBIS:输入/输出缓冲接口特性，输出的是V-I或V-T
（3）三种测量技术：①阻抗分析仪②矢量网络分析仪VNA矢量网络输出阻抗一般为50Ω③时域反射计 TDR
11. 通过计算创建电路模型：
（1）经验法则
（2）解析近似
（3）数值仿真
12. 上升边与时钟频率的关系近似为
RT =0.1Tclock
其中： RT：表示上升边，单位为ns. Tclock :表示时钟周期，单位 ns
13. 高频或高速领域：时钟频率超过100MHz或上升边小于1ns。
 
14. 电源和信号完整性，checklist，6个关键类型
端接匹配 电感 噪声 寄生参数 IR压降 辐射 串扰 衰减 地弹 轨道塌陷 反射 下冲过冲 上升边退化 阻抗突变 振铃 线延迟 RC时延 返回电流路径。等等

## 其他

SI: 由傅立叶变换可看出，信号上升越快, 高次谐波的幅度越大, MAXWELL方程组看知,这些交流高次谐波会在临近的线上产生交变电流. 甚至通过空间寄生电容直接辐射到另外的导体,
所以这些高次谐波就是造成辐射干扰(emission)的主要因素; (说的简单点，就是信号上升越快，信号越完整，信号品质越好，但是对于emi不好）

PI: PCB上存在数字//模拟区域, 高频//低频区域等不同的区域和平面, 如果分割不当则很容易相互干扰, 即传导干扰(conduction).

电源完整性之APSIM-SPI 篇

在PCB设计中，高速电路的布局布线和质量分析无疑是工程师们讨论的焦点。尤其是如今的电路工作频率越来越高，例如一般的数字信号处理(DSP)电路板应用频率在150－200MHz是很常见的，CPU板在实际应用中达到500MHz以上已经不足为奇，在通信行业中Ghz电路的设计已经十分普及。所有这些PCB板的设计，往往是采用多层板技术来实现。在多层板设计中不可避免地为采用电源层的设计技术。而在电源层设计中，往往由于多种类的电源混合应用而使得设计变为十分复杂。

那么萦绕在PCB工程师中的难题有哪些？PCB的层数如何定义？包括采用多少层？各个层的内容如何安排最合理？如应该有几层地，信号层和地层如何交替排列等等。如何设计多种类的电源分块系统？如3.3V, 2.5V, 5V, 12V 等等。电源层的合理分割和共地问题是PCB是否稳定的一个十分重要的因素。如何设计去耦电容？利用去耦电容来消除开关噪声是常用的手段，但如何确定其电容量？电容放置在什么位置？什么时候采用什么类型的电容等等。如何消除地弹噪声？地弹噪声是如何影响和干扰有用信号的？回路（Return Path）噪声如何消除？很多情况下，回路设计不合理是电路不工作的关键，而回路设计往往是工程师最觉得束手无策的工作。如何合理设计电流的分配？尤其是地电层中电流的分配设计十分困难，而总电流在PCB板中的分配如果不均匀，会直接明显地影响PCB板的不稳定工作。另外还有一些常见的如上冲，下冲，振铃(振荡)，时延，阻抗匹配，毛刺等等有关信号的奇变问题，但这些问题和上述问题是不可分割的。它们之间是因果关系。 


总的来说，设计好一个高质量的高速PCB板，应该从信号完整性(SI---Signal Integrity)和电源完整性(PI---Power Integrity )两个方面来考虑。尽管比较直接的结果是从信号完整性上表现出来的，但究其成因，我们绝不能忽略了电源完整性的设计。因为电源完整性直接影响最终PCB板的信号完整性。 


有一个十分大的误区存在于PCB工程师中间，尤其是那些曾经使用传统EDA工具来进行高速PCB设计的工程师。有很多工程师曾经问过我们：“为什么用EDA具的SI信号完整性工具分析出来的结果和我们用仪器实际测试的结果不一致，而且往往是分析的结果比较理想？”其实这个问题很简单。引起这个问题的原因是：一方面是EDA厂商的技术人员没有解释清楚；另一方面是PCB设计人员的对仿真结果的理解问题。我们知道，目前中国市场上使用比较多的EDA工具主要是SI（信号完整性）分析工具，SI 是在不考虑电源的影响下基于布线和器件模型而进行的分析，而且大多数连模拟器件也不考虑（假定是理想的），可想而知，这样的分析结果和实际结果肯定是有误差的。因为大多数情况下， PCB板中电源完整性的影响比SI更加严重。 


目前，虽然有些EDA厂商也已经部分的提供PI（电源完整性）的分析功能，但由于它们的分析功能和SI（信号完整性）完全分开进行，用户依然没有办法看到和实际测试结果接近的分析报告。PI 和 SI 是密切关联的。而且很多情况下，影响信号奇变的主要原因是电源系统。 例如，去耦电容没有设计好，地层设计不合理，回路影响很严重，电流分配不均匀，地弹噪声太大等等。 


作为PCB设计工程师，其实很希望看到接近于实际结果的分析报告，那样就便于校正和排除故障，做到真正意义上的仿真设计的效果。SPI 工具的出现使得上述的讨论变为可能。SPI的英文缩写是Signal-Power Integrity, 顾名思义， 它是将SI 信号完整性和PI 电源完整性集成于一体的分析工具。使得 SI 和PI 从此不再孤立进行。 
APSIM-SPI 是行业中第一家， 也是唯一一家将信号完整性和电源完整性结合于一起的产品。有了SPI工具，PCB工程师可以从此比较真实的从仿真波形中观察到和用仪器实际测试十分接近的波形。也就是说，从此理论设计和实际测试就有可比性了。 

以往的SI功能是在假设电源层等是理想状态下的孤立的分析。虽然有很大的辅助作用，但没有整体效果，用户也很难简单地根据SI分析结果来排除错误。作一个假设，如果一块PCB板，由于它的VCC和GROUND线布得很细，此时电路自然不工作。用示波器等仪表也很容易发现信号发生奇变很严重。但这种很容易想象的设计，如果用一般的SI分析工具，就无法仿真出信号的奇变情况。这时的情况是，尽管仿真结果的波形很完整，没有奇变，但实际是已经奇变到了不工作的地步。所以有工程师曾经质问：“为什么当我们将PCB板中电源线和地线布得无论多么多么窄， SI仿真中的信号波形都没有变化？”， 原因就是SI仿真中没有考虑你的PI， 也就是说没有考虑你的电源线和地线。而要解决这个问题， 唯一的办法就是采用SPI工具。SPI 在进行SI信号完整性分析是充分考虑地电层，包括信号层中的地电线，以及大面积地信号填充等。而这些地电层的不稳定信号或干扰将完全的叠加到SI的仿真结果中去。这样才能仿真真正的实际工作效果，当然其最终结果也就接近了实际测试结果。便于工程师直观考虑和校正。 
APSIM－SPI 为了实现SI 和PI 的有机结合，无论从内部模型、计算方法、用户界面、分析功能以及仿真机理等都作了重大调整。目的是使用户使用依然方便的前提下保证SPI功能的完美性。比如在RLGC建模和分布参数提取时，SPI 的RLGC参数提取就要比以前单纯的SI 参数提取要复杂的多。因为在SPI 中要必须充分的考虑地电层的寄生参数，以及地电层和信号线之间的连接关系。 

APSIM－SPI 在进行信号奇变分析时将充分考虑地电层的影响。因为SPI 在建模时将地电层的寄生参数模型和信号布线的参数模型，以及器件IBIS或SPICE模型一起综合考虑。因此无论你设计中的去耦电容、滤波电容、端子电阻等模拟部件还是电路在工作产生的SSO开关噪声、地弹噪声等等都将一起反应在最终的仿真结果波形上。 
利用APSIM公司的SPI工具，PCB工程师在设计PCB板时就可以直观地观察信号的奇变情况，并进行及时的调整。如当发现自己的地线布得不够宽时，信号会有噪声，甚至变形，这时你就可以调整地线宽度，直到满意为至。而以往地线终究应该布多宽？工程师们只有凭经验去调试，没有任何工具可以辅助它们进行设计指导。而如果地线布得不好，则引起PCB板不工作的概率将十分大。但如今的PCB板如此之复杂，不仅仅是地线宽度的问题，还应该包括地平面填充、多层地平面设计、尤其是地平面的分割技术处理等等， 对不同的频率要用不同的处理方法。 如果光凭有限的经验肯定是不能满足设计要求的。现在借助于APSIM－SPI， PCB工程师就可以很方便地知道他的地平面、地线系统设计是否合理及有效。

例如：当设计多层板时，很多工程师在要考虑每一层如何安排时经常不知是先放信号层还是先放地层？是信号层和地层交替放还是集中放？现在工程师可以根据SPI的仿真结果，清楚地得到是哪一种方法效果最好。 

再如：当在地线层上有多个电源时，如3.3V的地,、2.5V的地、5V的地等，如何进行分割处理？以往工程师只能凭有限的经验，而且也只能从边界划分去简单考虑合理性。如果这方面设计不合理，其后果是可想而知的，相信工程师们是有很深的体会的。但由于地层往往在PCB 板的中间层，因为物理上根本接触不到，调试是就很难进行修改。而事实上，在进行多电源地层设计时，不光要考虑各个地域之间的边界问题，还要考虑滤波问题、共地问题等等。有了SPI工具，工程师就可以很方便的进行多电源地域分割的合理设计了。如果不合理， 那么仿真时信号就会变形，这在以前是根本做不到的。 

在处理地弹噪声和SSO开关噪声时，大家知道这方面噪声的严重性（在EDA中，这方面的噪声归纳于PI电源完整性分析范围）， 尤其是高速PCB， 经常遇到工作状态不稳定， 其实很可能是由于开关噪声或者是地弹噪声所引起的。工程师们也一定知道一些简单的处理办法。但从定量的角度考虑时，就很复杂了。例如：一种简单的消除SSO开关噪声的有效方法是在电源和地之间加滤波电容， 常用的方法是加一些不同质量和类型的电解电容，工程师一定很容易定量确定这些电容的最大电压，（只要根据PCB 板的工作电压就可以进行计算 ），但如何定量确定这些电容的容量，（电容值）往往是只有凭经验了，或者是参考其它电路的设计。因为要*理论去计算将是十分困难的。 尤其是现在的PCB 板电路如此复杂就更加不容易*手工计算了。电容的放置位置也是不容易确定的因素之一。但这些电解电容的放置位置和它所起的滤波效果将密切相关。（常见的方法是放置在PCB板的电源入口处）。

现在利用APSIM－SPI工具，工程师就可以很方便地来设计和验证这些滤波电容的效果了。并且有效的确定这些电容的放置位置和它们的电容值。多余的电容坚决不要，应该有的电容一定不能少！ 
APSIM－SPI还有很多有关信号奇变和仿真设计方面的特点。我们相信，现在的高速PCB板设计必须采用先进的辅助手段来进行，SPI 结合了多年来的设计经验，集合了先进的SI和PI分析技术，直接真实地仿真PCB板的具体工作状态，更加接近于实际测试结果。SPI提供了全新的调试平台，使得多年来一直凭经验设计的方法过渡到仿真环境中。大大的提高了高速PCB的一次设计成功率。SPI 在业界已经逐步成为高速PCB 设计工程师最受欢迎，最必须的设计分析工具。SPI 和业界其它PCB设计工具密切配合使用。 如Mentor Graphics, Cadence, PADS, Protel等。
