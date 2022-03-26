---
categories:
- 笔记
- 技术
date: 2022-03-26T22:26:22+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "Redefine_fopen_malloc"
url: ""
draft: false
math : true
mermaid : false
wavedrom : false
---




[转载链接，侵删](https://www.armbbs.cn/forum.php?mod=viewthread&tid=107885)


在我们进行嵌入式开发时，难免要移植一些现有的成熟代码库，这些库大部分要借助C标准库中的输入输出接口、内存分配函数等。这也就产生了库函数重定向的问题。我们最常用重定向库函数为printf函数，重定向的方法为：

```
AC5:
#ifndef __MICROLIB  //不勾选微库的话需要关闭半主从模式
#pragma import(__use_no_semihosting)
#endif
int fputc(int ch, FILE *f){
  //ch为要发送的字符
  return HAL_UART_Transmit(&huart1, (uint8_t *)&ch, 1, 100)==HAL_OK?ch:-1;
}

AC6:
#ifndef __MICROLIB //不勾选微库的话需要关闭半主从模式
__asm(".global __use_no_semihosting\n\t")
#endif
int fputc(int ch, FILE *f){
//ch为要发送的字符
return HAL_UART_Transmit(&huart1, (uint8_t *)&ch, 1, 100)==HAL_OK?ch:-1;
}
```

有时我们需要重定向malloc、free等内存分配函数，不使用C库的内存分配，这在使用rtos时很常见，重定向malloc、free的方法为：

```
AC5
#pragma import(__use_no_heap_region)  //声明不使用C库的堆

void *malloc (size_t size){
        return OS_Malloc(size);
}

void free(void* p){
        OS_Free(p);
}

void *realloc(void* p,size_t want){
        return OS_Realloc(p,want);
}

void *calloc(size_t nmemb, size_t size){
        return OS_Calloc(nmemb,size);
}

AC6:

__asm(".global __use_no_heap_region\n\t"); //声明不使用C库的堆
void *malloc (size_t size){
        return OS_Malloc(size);
}

void free(void* p){
        OS_Free(p);
}

void *realloc(void* p,size_t want){
        return OS_Realloc(p,want);
}

void *calloc(size_t nmemb, size_t size){
        return OS_Calloc(nmemb,size);
}
```
有的时候我们需要重定向C库的文件IO，如在移植LUA解释器时，源码中会调用C库的fopen、fread等函数，需要对这些IO重定向，这里以FATFS为例实现重定向。
最后给出AC5与AC6均适用的例子，包含重定向printf、重定向malloc、free、重定向io，这里需要注意的是，一定要将前面的fputc注释掉，因为在编译时fputc的优先级要大于_sys_write，这就导致printf、fwirte都会重定向到fputc中。

```
#include <rt_sys.h>
#include <stdio.h>

#define SUPPORT_FILE_SYSTEM                0
#define SUPPORT_MALLOC                     1

#include "stm32h7xx_hal.h"
extern UART_HandleTypeDef huart1;

//约定返回值为1函数执行成功，0函数执行失败
#define MESSAGE_PRINT(BUF,LEN)  HAL_UART_Transmit(&huart1, (uint8_t*)BUF,LEN, 100)==HAL_OK
#define MESSAGE_SCANF(BUF,LEN) 0
#define OS_Malloc(SIZE)   NULL
#define OS_Free(P)
#define OS_Calloc(N,SIZE) NULL
#define OS_Realloc(P,SIZE) NULL

#if SUPPORT_FILE_SYSTEM
        #include "ff.h"
#endif

#if defined(__clang__)
        __asm(".global __use_no_semihosting\n\t");
        #if SUPPORT_MALLOC
                __asm(".global __use_no_heap_region\n\t");
        #endif
#elif defined(__CC_ARM)
        #pragma import(__use_no_semihosting)
        #if SUPPORT_MALLOC
                #pragma import(__use_no_heap_region)
        #endif
#endif

#if defined(__MICROLIB)
        #if defined(__clang__)
                __asm(".global __use_full_stdio\n\t");
        #elif defined(__CC_ARM)
                #pragma import(__use_full_stdio)
        #endif
#endif

#define STDIN        0
#define STDOUT        1
#define STDERR        2
#define IS_STD(fn)        ((fn)>=0&&(fn)<=2)
/*
* These names are used during library initialization as the
* file names opened for stdin, stdout, and stderr.
* As we define _sys_open() to always return the same file handle,
* these can be left as their default values.
*/
const char __stdin_name[] = ":tt";
const char __stdout_name[] = ":tt";
const char __stderr_name[] = ":tt";


FILEHANDLE _sys_open(const char *pcFile, int openmode)
{
#if SUPPORT_FILE_SYSTEM
        BYTE mode;
        FIL *fp;
        FRESULT fr;
#endif
        if(pcFile==__stdin_name)
                return STDIN;
        else if(pcFile==__stdout_name)
                return STDOUT;
        else if(pcFile==__stderr_name)
                return STDERR;
#if SUPPORT_FILE_SYSTEM
        fp=malloc(sizeof(FIL));
        if(fp==NULL){
                printf("malloc fail!\r\n");
                return -1;
        }
        /* http://elm-chan.org/fsw/ff/doc/open.html */
        if(openmode & OPEN_W){
                mode = FA_CREATE_ALWAYS | FA_WRITE;
                if (openmode & OPEN_PLUS)
                        mode |= FA_READ;
        }
        else if(openmode & OPEN_A){
                mode = FA_OPEN_APPEND | FA_WRITE;
                if (openmode & OPEN_PLUS)
                        mode |= FA_READ;
        }
        else{
                mode = FA_READ;
                if (openmode & OPEN_PLUS)
                        mode |= FA_WRITE;
        }

        fr = f_open(fp, pcFile, mode);
        if (fr == FR_OK)
                return (FILEHANDLE)fp;

        free(fp);
#endif
        return -1;
}

int _sys_close(FILEHANDLE fh)
{
#if SUPPORT_FILE_SYSTEM
        FRESULT fr;
#endif
        if(IS_STD(fh))
                return 0;
#if SUPPORT_FILE_SYSTEM
        fr = f_close((FIL *)fh);
        if (fr == FR_OK){
                free((void *)fh);
                return 0;
        }
#endif
        return -1;
}

int _sys_write(FILEHANDLE fh, const unsigned char *buf,\
        unsigned len, int mode)
{        
#if SUPPORT_FILE_SYSTEM
        FRESULT fr;
        UINT bw;
#endif
        if(fh==STDIN)
                return -1;
        
        if(fh==STDOUT||fh==STDERR){
                return MESSAGE_PRINT(buf,len)?0:-1;
        }
#if SUPPORT_FILE_SYSTEM        
        fr = f_write((FIL *)fh, buf, len, &bw);
        if (fr == FR_OK)
                return len - bw;
#endif        
        return -1;
}

int _sys_read(FILEHANDLE fh, unsigned char *buf,\
        unsigned len, int mode)
{
#if SUPPORT_FILE_SYSTEM
        FRESULT fr;
        UINT br;
#endif
        if(fh==STDOUT||fh==STDERR){
                return -1;
        }
        if(fh==STDIN){
                return MESSAGE_SCANF(buf,len)?0:-1;
        }
#if SUPPORT_FILE_SYSTEM                
        fr = f_read((FIL *)fh, buf, len, &br);
        if (fr == FR_OK)
                return len - br;
#endif
        return -1;
}

void _ttywrch(int ch)
{
        char c = ch;
        MESSAGE_PRINT(&c,1);
}

int _sys_istty(FILEHANDLE fh)
{
        return IS_STD(fh); /* buffered output */
}

int _sys_seek(FILEHANDLE fh, long pos)
{
#if SUPPORT_FILE_SYSTEM
        FRESULT fr;
        if(!IS_STD(fh)){
                fr = f_lseek((FIL *)fh, pos);
                if (fr == FR_OK)
                        return 0;
        }
#endif
        return -1;
}

long _sys_flen(FILEHANDLE fh)
{
#if SUPPORT_FILE_SYSTEM
        if (!IS_STD(fh))
                return f_size((FIL *)fh);
#endif
        return -1;
}
int _sys_ensure(FILEHANDLE fh){
#if SUPPORT_FILE_SYSTEM
        if (!IS_STD(fh)){
                if(f_sync((FIL*)fh)==FR_OK)
                        return 0;
        }
#endif
        return -1;
}
void _sys_exit(int code){
        printf("This Program unexpected exit! err:%d\r\n",code);
        while(1);
}

int remove(const char *pcPath){
#if SUPPORT_FILE_SYSTEM
        if(pcPath==__stdin_name||pcPath==__stdout_name||pcPath==__stderr_name)
                return -1;
        if(f_unlink(pcPath)==FR_OK)
                return 0;
#endif
        return -1;
}

//不清楚如何实现
int _sys_tmpnam(char * name, int sig, unsigned maxlen){
        return 0;
}

//重定向内存分配的相关库函数
#if SUPPORT_MALLOC
void *malloc (size_t size){
        return OS_Malloc(size);
}

void free(void* p){
        OS_Free(p);
}

void *realloc(void* p,size_t want){
        return OS_Realloc(p,want);
}

void *calloc(size_t nmemb, size_t size){
        return OS_Calloc(nmemb,size);
}

#endif

```