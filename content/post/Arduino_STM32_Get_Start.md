---
categories:
- 笔记
- 技术
date: 2022-03-17T13:06:42+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "Arduino_STM32_Get_Start"
url: ""
draft: false
math : true
mermaid : false
wavedrom : false
---

## 硬件

STM32 Blue Pill (STM32duino) STM32F103C8

## 环境配置

1. 安装[Arduino环境](https://www.arduino.cc/en/software/OldSoftwareReleases), 版本1.8.13
2. 下载[Arduino_STM32](https://github.com/rogerclarkmelbourne/Arduino_STM32/releases/tag/v1.0.0)并Arduino_STM32xxx文件夹解压到Arduino安装路径下：```C:\Program Files (x86)\Arduino\hardware```
3. 安装驱动(Maple DFU driver & Maple Serial driver)，运行路径```C:\Program Files (x86)\Arduino\hardware\Arduino_STM32\drivers\win```下的install_drivers.bat，安装成功提示：（请勿连接硬件，否则信息会有区别）

```
Installing Maple DFU driver...
Extracting driver files...
  Success
Installing driver(s)...
  Success

Installing Maple Serial driver...
Extracting driver files...
  Success
Installing driver(s)...
  Success

请按任意键继续. . .
```

4. 打开Arduino环境，执行以下几个步骤

* 选择 "工具 -> 开发板:"xxxx" -> Generic STM32F103C series"
* 选择 "工具 -> Variant:"xxxx" -> STM32F103C8(20k RAM, 64k Flash)"
* 选择 "工具 -> Upload method:"xxxx" -> STM32duino bootloader"
* 选择 "工具 -> CPU Speed(MHz):"xxxx" -> 48Mhz(Slow - with USB)"
* 选择 "工具 -> Optimize:"xxxx" -> Smallest (default)"

test.ino
```
// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin PB1 as an output.
  pinMode(PC13, OUTPUT);

  Serial.begin(115200); // Ignored by Maple. But needed by boards using hardware serial via a USB to Serial adaptor
  Serial.println("setup");
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(PC13, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(100);              // wait for a second
  digitalWrite(PC13, LOW);    // turn the LED off by making the voltage LOW
  delay(100);              // wait for a second

  Serial.println("Hello world! This is the debug channel.");
}
```

编译器链接：```C:\Users\Ez\AppData\Local\Arduino15\packages\arduino\hardware\sam\1.6.12\system\CMSIS\Examples\cmsis_example\gcc_arm```

## STM32 Blue Pill 第一次配置（烧录BootLoader）

烧录bootloader后，初次将硬件连接电脑并打开设备管理器，可看到```libusb-win32 devices -> Maple DFU```设备，此时硬件板卡状态还处于USB DFU设备类状态。

参考**环境配置** 4. 的步骤，编译并上传，

显示上传成功并反馈：

```
项目使用了 15712 字节，占用了 (23%) 程序存储空间。最大为 65536 字节。
全局变量使用了3128字节，(15%)的动态内存，余留17352字节局部变量。最大为20480字节。
maple_loader v0.1
Resetting to bootloader via DTR pulse
Reset via USB Serial Failed! Did you select the right serial port?
Searching for DFU device [1EAF:0003]...
Assuming the board is in perpetual bootloader mode and continuing to attempt dfu programming...

Found it!

Opening USB Device 0x1eaf:0x0003...
Found Runtime: [0x1eaf:0x0003] devnum=1, cfg=0, intf=0, alt=2, name="STM32duino bootloader v1.0  Upload to Flash 0x8002000"
Setting Configuration 1...
Claiming USB DFU Interface...
Setting Alternate Setting ...
Determining device status: state = dfuIDLE, status = 0
dfuIDLE, continuing
Transfer Size = 0x0400
bytes_per_hash=314
Starting download: [##################################################] finished!
state(8) = dfuMANIFEST-WAIT-RESET, status(0) = No error condition is present
error resetting after download: usb_reset: could not reset device, win error: ָ�������ڵ��豸��
Done!

Resetting USB to switch back to runtime mode
```

首次使用Arduino环境，执行以上步骤后：
设备管理器 端口（COM和LPT） -> Maple Serial (COMx)

## 异常处理

上传失败后提示：

```
...
上传项目出错
Resetting to bootloader via DTR pulse
Reset via USB Serial Failed! Did you select the right serial port?
Searching for DFU device [1EAF:0003]...
Assuming the board is in perpetual bootloader mode and continuing to attempt dfu programming...

dfu-util - (C) 2007-2008 by OpenMoko Inc.
Couldn't find the DFU device: [1EAF:0003]
This program is Free Software and has ABSOLUTELY NO WARRANTY
```

出现此问题时，需要在报出错误前手动按一下STM32 Blue Pill复位按键