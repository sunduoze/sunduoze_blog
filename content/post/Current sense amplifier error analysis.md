---
categories:
- 笔记
keywords:
- 技术
title: "Current sense amplifier error analysis"
date: 2021-02-23T19:50:55+08:00
url: ""
---

## RSS Error Analysis

Ideal shunt resistor:
An ideal shunt resistor is a resistor with 0% tolerance error and zero variation over temperature

Sensed current range:
These fields enable you to select an operational current range.

Common-mode voltage:
The common-mode voltage range is determined by the node voltage to which the device is connected where the current is being measured.

Supply voltage:
The supply voltage is the voltage required for the device to operate.

Operating temperature:
The error curve will be generated at room temperature (25°C) and the specified temperature.

(The limits for each parameter are preset according to the TI device selected.)

Help
Note No.1:
This error tool calculates the root sum square (RSS) error as opposed to the worst-case error. The worst-case error assumes that all error sources are simultaneously at the worst value an unlikely scenario. The RSS error methodology is a more realistic worst-case system error condition.

Note No.1:
This equation calculates the room-temperature curve:

e = (V OSV SHUNT+|V CMSYS - VCMDS| x CMRRV SHUNT+|V SSYS - VSDS| x PSRRV SHUNT)2+(eGN)2
where:

VOS
is the amplifier offset voltage at 25 °C.
VSHUNT
is the sensed current multiplied by the shunt resistor.
VCMSYS
is the selected common-mode voltage.
VCMDS
is the data-sheet-specified common-mode voltage for VOS.
CMRR
is the amplifier's specified common-mode rejection in V/V.
VSSYS
Chosen supply voltage
VSDS
is the data-sheet specified supply voltage for VOS.
eGN
is the amplifier gain error.

For the at-temperature curve, the drift specified in the data sheet is added to both the VOS term and the eGN term.

This analysis does not include additional error sources such as amplifier linearity, bias current and reference voltage. The individual device data sheets describe the effect of these error sources.

For more information on calculating error see the "Getting Started with Current Sense Amplifier" video training series.


<br/>
<br/>
<br/>
<br/>
