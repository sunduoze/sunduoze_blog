---
categories:
- 笔记
keywords:
- 技术
title: "Roundup_pow_of_two"
date: 2021-09-27T17:02:21+08:00
url: ""
---


### 最接近的最大2的指数次幂
```
#include <stdio.h>
#include <stdlib.h>

static inline int rpt_fls_asm(int x)
{
    int r;
    __asm__("bsrl %1,%0\n\t"
            "jnz 1f\n\t"
            "movl $-1,%0\n"
            "1:" : "=r" (r) : "rm" (x));
    return r + 1;
}

static inline int rpt_fls(int x)
{
    int position;
    int i;

    if(0 != x)
    {
        for (i = (x >> 1), position = 0; i != 0; ++position)
            i >>= 1;
    }
    else
    {
        position = -1;
    }
    return position + 1;
}


static inline unsigned int roundup_pow_of_two(unsigned int x)
{
    return 1UL << rpt_fls(x - 1);
}


int main()
{
    unsigned int test_value = 0b11010101;

    printf("Hello world!\n");
    printf("fls test value:%d\r\n", rpt_fls(test_value));

    printf("fls test value:%d\r\n", roundup_pow_of_two(test_value));

    return 0;
}
```

### MCU端高效方法
```
//找出最接近 最大2的指数次幂
uint32_t roundup_pow_of_two(uint32_t data_roundup_pow_of_two )
{
    /* 这里采用 STM32 硬件提供的计算前导零指令 CLZ
     * 举个例子，假如变量date_roundup_pow_of_two 0x09
     *（二进制为：0000 0000 0000 0000 0000 0000 0000 1001）, 即bit3和bit0为1
     * 则__clz( (date_roundup_pow_of_two)的值为28,即最高位1 前面有28个0,32-28 =3 代表最高位1 的 位置
     * 31UL 表示 无符号 int 数字 31，否则默认为 有符号 int 数字 31
     * 这里参考  FreeRTOS 的 寻找高级优先级任务 的写法，详细解释到朱工博客
     * 博客地址: http://blog.csdn.net/zhzht19861011/article/details/51418383
     */

#if defined(__CC_ARM) || defined(__CLANG_ARM)          /* ARM C Compiler */
  return ( 1UL << ( 32UL - ( uint32_t ) __CLZ( (data_roundup_pow_of_two) ) ) );
#elif defined(__GNUC__)                                /* ARM Compiler 6 */
  return 1UL << rpt_fls(data_roundup_pow_of_two - 1);
#elif defined (__ICCARM__) || defined(__ICCRX__)       /* for IAR Compiler */
  #error "not supported tool chain..."
#else
  #error "not supported tool chain..."
#endif
}
```