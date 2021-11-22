---
categories:
- 笔记
date: 2021-11-22T16:19:36+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "Single_wire_comm"
url: ""
math : true
mermaid : false
---


**single wire interface communication**


## NAPA AID com

### HW circuit

**AID MASTER:**
</br>
receiver: AID-bus to BUF to MCU
</br>
thransmiter: MCU to NOR-BUF to mos-gate to mos-drain(AID-bus) + pull-up res to V_DD

**AID SLAVER:**
</br>
receiver: AID-bus to BUF to MCU
</br>
thransmiter: MCU to NOR-BUF to mos-gate to mos-drain(AID-bus)

**AID slaver BOOOOM:**
Cap:100pF 25V C0G
</br>
ATCPZ003-UUCZ ATMEL ROSWELL AUTH MFi
</br>
AS3616A-AFCT-13 BIGTEN

**I2C IF:**
ATCPZ003-MXHDB ATMEL ROSWELL AUTH MFi

### HW timing @DY

<div>
    <a href="/media/note_img/Single_wire_comm/AID Communication Protocol V03.pdf">AID</a>
</div>

0: low:8.2us high:2.8us
</br>
1: low:2.8us high:8.2us

### my test result :baudrate 1M

串口时序：1M baudrate 1起始位 8位数据 2停止位 无校验
</br>
-> All 11bits: START 1bit + 8bits数据 + 停止位2bit(拉高~2us)

**个人测试：**
</br>
0:0x00(低9高2) 0x80(低8高3)
</br>
1:0xFE(低2高9) 0xFC(低3高8)

<div>
    <img src="/media/note_img/Single_wire_comm/80 FC.jpg" width="1153px" height="203px"/>
</div>

<div>
    <img src="/media/note_img/Single_wire_comm/00 FE.jpg" width="1153px" height="203px"/>
</div>

**TI HDQ uart handle:**

<div>
    <a href="/media/note_img/Single_wire_comm/HDQ Communication Basics_slua408a.pdf">slua408a</a>
</div>

**Receiver:**
logic 0: 0x80 0xC0 0xE0 0xF0
logic 1: 0xFE 0xFC

**Transmit:**
logic 0: 0xC0
logic 1: 0xFE

**Judge:**
logic 0: <= 0xF8
logic 1: >  0xF8

## AT21CS01 AT21CS11 Routine (SWI EEPROM)

**High-Speed**
</br>
0:low 1us high 14us
</br>
1:low 10us high 5us
</br>

**Standard Speed**
</br>
0:low 4us high 41us
</br>
1:low 24us high 21us
</br>

*AC measurement conditions for the table above:*
</br>
– Loading capacitance on SI/O: 100 pF
</br>
– RPUP (bus line pull-up resistor to VPUP): 1 kΩ; VPUP: 2.7V

*AT21CS11 DC Characteristics:*
R_PUP min:0.2 — max:1.8 kΩ @VPUP = 2.7V
R_PUP 0.4 — 5.4 kΩ @VPUP = 4.5V
C_BUS max:1000 pF
Input Low Level(3)(4) VIL –0.6 — 0.5 V
Input High Level(3)(4) VIH VPUP x 0.7 — VPUP + 0.5 V

## AT21CSxx DS

<div>
    <a href="/media/note_img/Single_wire_comm/AT21CS11 1Kb串行EEPROM.pdf">AT21CS11 1Kb串行EEPROM</a>
</div>

<div>
    <a href="/media/note_img/Single_wire_comm/AT21CS01-AT21CS11-Data-Sheet.pdf">AT21CS01 DS</a>
</div>

<div>
    <a href="/media/note_img/Single_wire_comm/AN3304.pdf">AN3304</a>
</div>


## AT21CS11 Plot

<div>
    <a href="/media/note_img/Single_wire_comm/plot_SW need to optimize.zip">dsView plot</a>
</div>


## AT21CS11 CODE

<div>
    <a href="/media/note_img/Single_wire_comm/STM32F407ZGT6(已修改为USB_FS).zip">my test code for AT21CS11</a>
</div>

<div>
    <a href="/media/note_img/Single_wire_comm/AN3075 Source Code_V1.0.0.zip">AT21 SWI code</a>
</div>

<div>
    <a href="/media/note_img/Single_wire_comm/AN3304_Source_Code_V1.0.0.X.zip">AN3304 AT21 SWI code</a>
</div>