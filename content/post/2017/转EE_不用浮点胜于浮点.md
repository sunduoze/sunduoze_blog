---
categories:
- 笔记
date: 2017-03-12T10:40:51+08:00
keywords:
- 嵌入式
title: "转EE_不用浮点胜于浮点"
url: ""
---

<br/>
<br/>



## 例：

有一个16位数（以下运算后不会溢出），需要乘以2.8865xxx（它是ADC校准时用的，4096/1419），如果直接使之乘以2.8865xxx，编译器也不会有任何做不到：
```
Voltage = InputVolt * 2.8865xxx；
(Voltage = InputVolt * 4096/1419)
```

然而，它编译后的代码却非常大：
```
MOVW      DP,#_InputVolt;段       1周期
MOV       AL,@_InputVolt;直接寻址 1周期
LCR       #U$$TOFS; 调用编译器内部定义的函数-浮点转换 4周期+n周期
MOVL      XAR6,ACC;1周期
MOV       AL,#32635;1周期
MOV       AH,#16408;1周期
MOVL      *-SP[2],ACC;1周期
MOVL      ACC,XAR6;1周期
LCR       #FS$$MPY;调用编译器内部定义的函数-浮点数相乘 4周期+n周期
LCR       #FS$$TOU;调用编译器内部定义的函数-浮点数转整型 4周期+n周期
MOVW DP,#_Voltage;1周期
MOV       @_Voltage,AL;1周期
```
程序中，调用了9条单周期指令、三条4周期指令，三个不同的内部过程，其占用的时间没有去查，肯定不会太短。不讲过程调用，占21个周期，如果每个调用的内部过程按10周期算（没有具体察看它们到底用了多少时间），那么，执行时间超过50个时钟周期。


现在把运算办法改一下，即：
```
Voltage = （InputVolt * 1419 *16 ）/ 65536 ；
```
具体语句为：
```
        temp = (Uint32) InputVolt * 22704;
        Voltage = temp >> 16;
```

这时再看一下编译结果：
```
MOV       T,#22704; 这里连段都不用操作了。 1周期
MPYXU     ACC,T,@_InputVolt; 相乘       1周期
MOVL      *-SP[6],ACC;
临时数据，用汇编编程时可以不用这一句 1周期，这是由于temp变量产生的，可以去掉
MOVW      DP,#_Voltage;段操作           1周期
MOVH      @_Voltage,ACC << 0;
将32位的ACC寄存器中的高16位保存 ------编译器很聪明，移位16时，不用移位指令而直接使用寄存器的高半部 1周期
```

这里可见，仅用5个周期就完成任务。如果没有temp这个中间变量，将是4个时钟周期

两种方法作比较可知，第一种方法占用的时间不仅很长，而且存在浮点数与整数的来回转换，而第二种用时很短。两种方法的结果使程序的执行时间相差10多倍！   在精度上，第一种方法使用来回转换，肯定损失不小，而第二种方法仅将无效的后半部丢弃，保证最好的精度。
以上的两种方法，达到同样的目的，由此可见，**一个好的编程方法，对程序的运行关系重大**。

## QAQ：
**Q:右移16位，取高16位的效果？比单纯/4096的右移12位还快？**
<br/>
A:如果使用移位方法，就要加入一条移位指令。而这里实现了16位的移位，却看不到移位指令。
<br/>
A:移位16位，在32位寄存器的内容中，只取高半部，舍去低半部的16位，也等效于移位16，但却又少了至少一条指令。

## Q格式的运算
1> 定点加减法：须转换成相同的Q格式才能加减
2> 定点乘法：不同Q格式的数据相乘，相当于Q值相加
3> 定点除法：不同Q格式的数据相除，相当于Q值相减
4> 定点左移：左移相当于Q值增加
5> 定点右移：右移相当于Q减少
## Q格式的应用格式
实际应用中，浮点运算大都时候都是既有整数部分，也有小数部分的。所以要选择一个适当的定标格式才能更好的处理运算。一般用如下两种方法：
1> 使用时使用适中的定标，既可以表示一定的整数复位也可以表示小数复位，如对于2812的32位系统，使用Q15格式，可表示－65536.0～65535.999969482区间内的数据。
2> 全部采用小数，这样因为小数之间相乘永远是小数，永远不会溢出。取一个极限最大值（最好使用2的n次幂），转换成x/Max的小数（如果Max是取的2的n次幂，就可以使用移位代替除法）。

<br/>
<br/>