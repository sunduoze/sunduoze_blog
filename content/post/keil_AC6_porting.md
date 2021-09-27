---
categories:
- 笔记
keywords:
- 技术
title: "Keil_AC6_porting"
date: 2021-09-27T13:33:08+08:00
url: ""
---

## Cubemx LWIP & FREERTOS Keil AC5 to AC6

### 1.MASK cc.h  define & include

```
path : ..\Middlewares\Third_Party\LwIP\system\arch\cc.h
```

```
MASK:

#if defined (__GNUC__) & !defined (__CC_ARM)

//#define LWIP_TIMEVAL_PRIVATE 0
//#include <sys/time.h>

#endif
```

### 2.ADD #define __CC_ARM to ..\LWIP\App\lwip.c

```
#include "lwip.h"
#include "lwip/init.h"
#include "lwip/netif.h"
#define __CC_ARM
#if defined ( __CC_ARM )  /* MDK ARM Compiler */
#include "lwip/sio.h"
#endif /* MDK ARM Compiler */
```

### 3.Modify port.c & portmacro.h

```
copy

C:\Users\Ez\STM32Cube\Repository\STM32Cube_FW_F4_V1.23.0\Middlewares\Third_Party\FreeRTOS\Source\portable\GCC\ARM_CM4F

to

..\Middlewares\Third_Party\FreeRTOS\Source\portable\RVDS\ARM_CM4F

```
