---
categories:
- 笔记
- 技术
date: 2022-01-24T10:44:35+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "mcu_ctrl_cmd_demo"
url: ""
draft: false
math : true
mermaid : false
wavedrom : false
---


## Common board communication protocol (hw:*serial port*)

**baudrate : 115200 bps 8,1,None**
**command & feedback end with "\r\n"**

### Board summy

|status|board name | *slaver address </br> *range: 0-255*| eg. | remark |standard|
|:-:|:-:|:-:|:-:|:-:|:-:|
| <input type="checkbox" checked> |Herring board|2|2,get_volt,1\r\n||<input type="checkbox" checked>|
| <input type="checkbox" checked> | USB DAQ-S1 board|5|5,get_volt,1\r\n||<input type="checkbox" checked>|
| <input type="checkbox" disabled> | Voltage balance |-|cell1\r\n||<input type="checkbox" check>|

</br> * <input type="checkbox" checked>**standard board rules**
Format:*slaver_address(addr) + ',' + cmd (end with "\r\n")*

---

### Herring board

+ [x] slaver_address: '2'

|index|cmd|para|return |eg.|description
|:-:|:-:|:-:|:-:|:-:|:-:|
|01|get_curr|ch|0.0123|get_curr,[ch]|get [ch] csa chip current|
|02|get_volt|ch|12.345678|get_volt,[ch]|get [ch] csa chip voltage|
|03|get_pwr|ch|2.345678|TBD|TBD|
|04|set_ovp|ch,volt|null|set_ovp,[ch],[volt]|set [ch] ovp voltage as [volt]|
|05|read_ovp|ch|1.2345|read_ovp,[ch] |read [ch] ovp voltage|
|06|set_curr_rate|ch,rate|null|set_curr_rate,[ch],[rate]|set [ch] csa rate as [rate]|
|07|set_curr_range|ch,range|null|set_curr_range,[ch],[range]|set [ch] csa rate as [range]|
|08|cat_io_set|io,state|null|cat_io_set,[ch],[state]|set [io] as [state]|
|09|cat_io_read|io|state|cat_io_read,[io]|read [io] state|
|99|*idn?|-|-|read back version|

### USB DAQ-S1 board

+ [x] slaver_address: '5'

|index|cmd|para|return |eg.|description
|:-:|:-:|:-:|:-:|:-:|:--|
|01|get_volt|ch|[pass],volt|get_volt,[ch]|get [ch] voltage</br>**ch**</br> 1:AI1 </br> 2:AI2</br> 3:AI3</br> 4:AI4 </br> 5:reserve </br> 6:reserve </br> 7:reserve </br> 8:AO1 </br> 9:AO2|
|02|set_volt|ch,volt|[pass]|set_volt,[ch],[volt]|set dac [ch] chip volt</br>**ch**</br> 1:reserve </br> 2:reserve</br> 3:reserve</br> 4:reserve </br> 5:reserve </br> 6:reserve </br> 7:reserve </br> 8:AO1 </br> 9:AO2|
|03|relay_get|relay|[pass],state|relay_get,[relay]|get [relay] [state] </br>**relay**</br>1:Rp1&Rn1</br>2:Rp2&Rn2</br>3:Rp3&Rn3</br>4:Rp4&Rn4</br>5:Rp&Rn|
|04|relay_set|relay,state|[pass]|relay_set,[relay],[state]|set [relay] as [state]...|
|05|di_get|di|[pass],state|di_get,[di]|get [di] state</br>**di**</br>1:DI_ISO1</br>2:DI_ISO2</br>3:DI_ISO3</br>4:DI_ISO4|
|06|dio_get|io|[pass],state|dio_get,[io]|get [io] state</br>**io**</br>1:DIO1</br>2:DIO2</br>3:DIO3</br>x:DIOx</br>8:DIO8|
|07|dio_set|io,state|[pass]|dio_set,[io],[state]|set [io] as [state]...|
|08|dio_cfg|io,mode|[pass]|dio_cfg,[io],[mode]|**io**</br>**mode** </br>0:output pull-push </br> 1:output open drain </br> 2:input</br> 3:input analog</br> 4:input pull-up </br> 5:input pull-down </br> 6:input floating </br> 7:pwm output </br> 8:pwm open-drain </br> 9:comp intput|
|9|cal_get|ch|[pass],k,b,g|cal_get,[ch]| **ch** *default:g=1.0 b=0.0*</br>0:Vreference</br> 1:AI1 </br> 2:AI2</br> 3:AI3</br> 4:AI4 </br> 5:reserve </br> 6:reserve </br> 7:reserve </br> 8:AO1 </br> 9:AO2|
|10|cal_set|ch,k,b|[pass]|cal_set,[ch],[k],[b]| **ch** *default:g=1.0 o=0.0* ...|
|99|*idn?|-|version|-|-|

### Voltage balance board [nonstandard]

|index|cmd|return|description|
|:-:|:-:|:-:|:-:|
|1|cell_close|ok|close all relay|
|2|cell_now|cellx</br>null|get now relay is cellx, or null|
|3|cell1|ok|set cell1 ch relay|
|4|cell2|ok|set cellx ch relay|
|...|...|ok|set ... ch relay|
|18|cell16|ok|set cell16 ch relay|
|**remark**|-|-|1. *whole channel only support set a channel*</br>2. *others channel will auto close when set a channel*</br>3. *out of cmd list cmd_str will not feedback*|

### 经典示例

<div>
    <a href="/media/note_img/mcu_ctrl_cmd_demo/Test Harness Commands.xlsx">Test Harness Commands</a>
</div>

</br>