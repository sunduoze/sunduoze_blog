---
categories:
- 笔记
- 技术
date: 2021-06-12T21:10:51+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "ARM_AC5_to_AC6"
url: ""
draft: false
math : false
mermaid : false
wavedrom : false
---

### Migrate ARM Compiler 5 to ARM Compiler 6 部分笔记

**Incompatible Language Extensions**

|ARM Compiler 5 | ARM Compiler 6 | CMSIS (Recommended)|
|:-:|:-:|:-:|
| `__align(x)` | `__attribute__((aligned(x)))` | `__ALIGNED(x)`|
| `__alignof__` | `__alignof__` ||
| `__ALIGNOF__` | `__alignof__` ||
| `__asm` | See Assembler Migration |`__ASM`|
| `__const` | `__attribute__((const))` ||
| `__forceinline` | `__attribute__((always_inline))` ||
| `__global_reg` | Not supported ||
| `__inline` | `__inline__`. The use of this depends on the language mode. |`__INLINE`</br>`__STATIC_INLINE`|
| `__int64` | No equivalent. Use **long long**. When you use long long in C90 mode, the compiler gives a warning. |`int64_t`|
|`__irq`| `__attribute__((interrupt))`|Not required for Cortex-M ISRs|
|`__packed`</br>`__packed x struct`|`__attribute__((packed))` </br> `struct x attribute((packed))`|`__PACKED` </br> `__PACKED_STRUCT x`|
|`__pure`| `__attribute__((const))`||
|`__smc` | Use inline assembler instructions or equivalent routine.||
|`__softfp`|` __attribute__((pcs("aapcs")))`||
|`__svc`| Use inline assembler instructions or quivalent routine.||
|`__svc_indirect`| Use inline assembler instructions or equivalent routine. ||
|`__thread`| `__thread` ||
|`__value_in_regs` | `__attribute__((value_in_regs))`||
|`__weak` | `__attribute__((weak))`|`__WEAK` |
|`__writeonly` | Not supported | |

---

### Select a Compiler Optimization Level

|Level | Description |
|:-:|:-:|
|-O0| No Optimization. Not recommended for use in ARM Compiler 6.6|
|-O1| Limited Optimization. This is currently the recommended level for source level debugging.|
|-O2| Optimization for speed. Code size will increase due to many loop-unrolls and function inlining.|
|-O3| Optimization for speed. Faster, but larger code than| 
|–O2| produces|
|-Os| Balanced Optimization. Optimizes for speed were code size increase is reasonable.|
|-Oz| Purely optimize for code size.|

<div>
    <embed src="/media/note_pdf/AC5 to AC6 Migrate ARM Compiler 5 to ARM Compiler 6.pdf" width="690px" height="600px"/>
</div>

### 编译器升级注意事项总结

1. CMSIS、HAL，直接使用，CMSIS使用5.6稳妥
2. 使用FreeRTOS需要更改port.c,AC5使用RVDS下的，AC6使用GCC的
3. CC++下，见图1，使用GNC99和GNC++11
4. AC6下中文的C文件需要更换成UTF-8，AC5如果继续使用此文件，需要在misc control下添加--locale=english
5. 养成良好习惯，可以在使用不同编译器时添加不同编译器定义
defined ( __CC_ARM )
#elif defined(__GNUC__)
6. AC5AC6相关的定义区别如图2
7. 为养成良好习惯，list、output生成的文件建议区分成AC5(AC6)
8. AC6定义相关指定地址，请使用section（“”name“”），或者__attribute__((section(.ARM.__at_0xxx)))

#### <编译>条件编译——判断当前编译器及操作系统

```
#if defined(__CC_ARM) || defined(__CLANG_ARM)          /* ARM C Compiler */
    extern const int console$$Base;          
    extern const int console$$Limit;     
    _cmd_init(&console$$Base, &console$$Limit);
#elif defined(__GNUC__)                                /* ARM Compiler 6 */
    extern const int console$$Base;        
    extern const int console$$Limit;      
    _cmd_init(&console$$Base, &console$$Limit);  
#elif defined (__ICCARM__) || defined(__ICCRX__)       /* for IAR Compiler */
    _cmd_init(__section_begin("console"), __section_end("console"));
#else
    #error "not supported tool chain..."
#endif
```

```
//! \name The macros to identify the compiler
//! @{

//! \note for IAR
#ifdef __IS_COMPILER_IAR__
#   undef __IS_COMPILER_IAR__
#endif
#if defined(__IAR_SYSTEMS_ICC__)
#   define __IS_COMPILER_IAR__                  1
#endif

//! \note for arm compiler 5
#ifdef __IS_COMPILER_ARM_COMPILER_5__
#   undef __IS_COMPILER_ARM_COMPILER_5__
#endif
#if ((__ARMCC_VERSION >= 5000000) && (__ARMCC_VERSION < 6000000))
#   define __IS_COMPILER_ARM_COMPILER_5__       1
#endif
//! @}

//! \note for arm compiler 6
#ifdef __IS_COMPILER_ARM_COMPILER_6__
#   undef __IS_COMPILER_ARM_COMPILER_6__
#endif
#if defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6010050)
#   define __IS_COMPILER_ARM_COMPILER_6__       1
#endif

#ifdef __IS_COMPILER_LLVM__
#   undef  __IS_COMPILER_LLVM__
#endif
#if defined(__clang__) && !__IS_COMPILER_ARM_COMPILER_6__
#   define __IS_COMPILER_LLVM__                 1
#else
//! \note for gcc
#   ifdef __IS_COMPILER_GCC__
#       undef __IS_COMPILER_GCC__
#   endif
#   if defined(__GNUC__) && !(  defined(__IS_COMPILER_ARM_COMPILER_5__)         \
                            ||  defined(__IS_COMPILER_ARM_COMPILER_6__)         \
                            ||  defined(__IS_COMPILER_LLVM__))
#       define __IS_COMPILER_GCC__              1
#   endif
//! @}
#endif
//! @}
```

``` 
编译器
GCC
#ifdef __GNUC__
#if __GNUC__ >= 3 // GCC3.0以上
 
Visual C++
#ifdef _MSC_VER
#if _MSC_VER >=1000 // VC++4.0以上
#if _MSC_VER >=1100 // VC++5.0以上
#if _MSC_VER >=1200 // VC++6.0以上
#if _MSC_VER >=1300 // VC2003以上
#if _MSC_VER >=1400 // VC2005以上
 
Borland C++
#ifdef __BORLANDC__
 
Cygwin
#ifdef __CYGWIN__
#ifdef __CYGWIN32__    //
 
 
MinGW
#ifdef __MINGW32__
 
操作系统
Windows
#ifdef _WIN32    //32bit
#ifdef _WIN64    //64bit
#ifdef _WINDOWS     //图形界面程序
#ifdef _CONSOLE     //控制台程序
//Windows（95/98/Me/NT/2000/XP/Vista）和Windows CE都定义了
#if (WINVER >= 0x030a)     // Windows 3.1以上
#if (WINVER >= 0x0400)     // Windows 95/NT4.0以上
#if (WINVER >= 0x0410)     // Windows 98以上
#if (WINVER >= 0x0500)     // Windows Me/2000以上
#if (WINVER >= 0x0501)     // Windows XP以上
#if (WINVER >= 0x0600)     // Windows Vista以上
//_WIN32_WINNT 内核版本
#if (_WIN32_WINNT >= 0x0500) // Windows 2000以上
#if (_WIN32_WINNT >= 0x0501) // Windows XP以上
#if (_WIN32_WINNT >= 0x0600) // Windows Vista以上
 
UNIX
#ifdef __unix
//or
#ifdef __unix__
 
Linux
#ifdef __linux
//or
#ifdef __linux__
 
FreeBSD
#ifdef __FreeBSD__
 
NetBSD
#ifdef __NetBSD__
 
Qt特有
<qtglobal.h>定义了Q_OS_*和Q_WS_*系列用于判断操作系统。Q_CC_*系列判断编译器。
具体的可以在Qt Assistant里索引qtglobal.h查看。

```
