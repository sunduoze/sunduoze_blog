---
categories:
- 笔记
keywords:
- 技术
title: "i2c设计规范"
date: 2021-02-26T11:31:31+08:00
url: ""
---

## I2C总线的电气连接

</br>
#### 1.上拉电阻Rp的选择

**不同模式基本参数信息**

|Mode|Sink Curr Iol|Speed|Max capacitive load|tr|Vol @Vdd>2V|Vol @Vdd<2V|
|---|---|---|---|---|---|---|
|Standard-mode |3mA |0 Hz to 100 kHz|400pF|1000ns|0.4V@3mA sink|0.2*Vdd|
|Fast-mode     |3mA |0 Hz to 400 kHz|400pF|300ns |0.4V@3mA sink|0.2*Vdd|
|Fast-mode Plus|20mA|0 Hz to 1 MHz  |550pF|120ns |0.4V@3mA sink|0.2*Vdd|
|Hs mode       |20mA|0 Hz to 3.4 MHz|400pF|160ns@400pF 80ns@10-100pF|0.4V@3mA sink|0.2*Vdd|
|Ultra Fs mode |? mA|0 Hz to 5.0 MHz|?pF  |50ns  |0.4V@4mA sink|-|

</br> 

**Rp上限**

总线电容由导线，连接和pin决定，由于特定的上升时间，总线电容限制了Rp的最大值。
考虑Vdd的高低电平阈值，Vih=0.7*Vdd，Vil=0.3*Vdd，借此计算RC值，V(t)=Vdd*(1-e^(-t/RC));

```
V(tl) = 0.3 * Vdd = Vdd * (1 - e ^ (-tl / RC)), then tl = 0.3566749 × RC;
V(th) = 0.7 * Vdd = Vdd * (1 - e ^ (-th / RC)), then th = 1.2039729 × RC;
T = th - tl = 0.8473 * RC;
所以
Rp(max) = tr / (0.8473 * Cb);
tr:不同总线速率下的最大上升时间.
Cb:预估总线电容
```
200pF极限情况下：
</br>
Eg. 100kHz Cb=200pF -> tr = 1000ns -> Rp(max) = 5.71k
</br>
Eg. 400kHz Cb=200pF -> tr = 300ns -> Rp(max) = 1.71k


**Rp下限**

```
Rp(min) = (Vdd - Vol(max)) / Iol
Vdd: I2C上拉电阻供电电源电压最小值
Vol(max)：低电平输出电压最大值 LOW-level output voltage
Iol: 低电平输出电流 LOW-level output current
```
</br>
Eg. Vdd = 5.0V Vol(max) = 0.4V Iol = 3mA -> Rp(min) = 1.53k
</br>
Eg. Vdd = 3.3V Vol(max) = 0.4V Iol = 3mA -> Rp(min) = 967

</br> 

**TI USB to GPIO Adaptor Hardware Config**
```
VDD:3.3V 
2.2k, 1k, 688(1k//2k)[此值与设计Rp min 冲突？]三种上拉电阻配置选择
use BSS84 P-MOS, Rg=33R from mcu gpio driver config Rp
I2C pin use GL05T low cap TVS to protect.

USB Dp enum resistor design: usb vdd + 15k res ctrl MMBT2222A B base (C: PUR pin ? may be mcu VDD, E:mcu dp pin)  usb port dp & dn use 33R res then to mcu
```

<div>
    <img src="/media/note_img/i2c_规范/usb_to_gpio_catch_wave.png" width="1153px" height="203px"/>
</div>
<br/>
<div>
    <img src="/media/note_img/i2c_规范/usb_to_gpio_400kHz_Read.png.png" width="1200px" height="184px"/>
</div>
<br/>
<div>
    <img src="/media/note_img/i2c_规范/usb_to_gpio_400kHz Write.png" width="1200px" height="184px"/>
</div>
<br/>

<br/>

</br>
#### 2.串联保护电阻Rs的选择

Eg. 300 Ω can be used for protection against high-voltage spikes on the SDA and SCL lines (resulting from the flash-over of a TV picture tube, for example). If series resistors are used, designers must add the additional resistance into their calculations for Rp and allowable bus capacitance.


The required noise margin of 0.1VDD for the LOW level, limits the maximum value of Rs.
Rs(max) as a function of Rp is shown in Figure 46. Note that series resistors affect the
output fall time.

<div>
    <img src="/media/note_img/i2c_规范/i2c_串行电阻及调试.png" width="1200px" height="184px"/>
</div>
<br/>

### 3. SMBus & I2C & PMBus

SMBus 1.0 & 2.0主要的区别在Vol = 0.4V 下sink电流能力的差异.
PMBus是在SMBus 1.1基础上拓展部分指令构成

* SMBus low power = 350 μA (SMBus 1.0 main for Smart Batteries)
* SMBus high power = 4 mA  (SMBus 2.0)
* I2C-bus = 3 mA

SMBus 'high power' devices and I2C-bus devices will work together if the pull-up resistor is sized for 3 mA.

**SMBus and I2C 差异**

* 通信速率

SMBus and I2C protocols are basically the same: A SMBus master is able to control I2C devices and vice versa at the protocol level. The SMBus clock is defined from 10 kHz to 100 kHz while I2C can be 0 Hz to 100 kHz, 0 Hz to 400 kHz, 0 Hz to 1 MHz and 0 Hz to 3.4 MHz, depending on the mode. This means that an I2C-bus running at less than 10 kHz is not SMBus compliant since the SMBus devices may time-out.

* 逻辑电平

Logic levels are slightly different also: TTL for SMBus: LOW = 0.8 V and HIGH = 2.1 V, versus the 30% / 70% VDD CMOS level for I2C. 
This is not a problem if VDD > 3.0 V. If the I2C device is below 3.0 V,
then there could be a problem if the logic HIGH/LOW levels are not properly recognized.


</br>


## 参考文档
<div>
    <a href="/media/note_img/i2c_规范/I2C-bus specification and user manual_UM10204.pdf">NXP I2C 总线规范&UM UM10204</a>
</div>
<br/>
<div>
    <a href="/media/note_img/i2c_规范/I2C总线规范.pdf">周立功 I2C总线规范</a>
</div>
<br/>
<div>
    <a href="/media/note_img/i2c_规范/System Management Bus (SMBus) Specification_SMBus_3_0_20141220.pdf">SMBUS Spec</a>
</div>
<br/>
