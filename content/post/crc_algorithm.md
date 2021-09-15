---
categories:
- 笔记
keywords:
- 技术
title: "Crc_algorithm"
date: 2021-02-22T14:45:33+08:00
url: ""
---

## CRC

循环冗余校验（Cyclic Redundancy Check， CRC）是一种根据网络数据包或计算机文件等数据产生简短固定位数校验码的一种信道编码技术，主要用来检测或校验数据传输或者保存后可能出现的错误。它是利用除法及余数的原理来作错误侦测的。

## CRC8

常用CRC8的生成多项式 Poly(最终只取低8Bits)
Reverse order is from (Bin & 0xFF) Eg.0x31（0011 0001）变成了0x8C (1000 1100)

|Type|Poly|Bin|Poly val|Raw val|Reverse order|
|:-:|:-:|:-:|:-:|:-:|:-:|
|CRC-8      |x8+x2+x1+1        | 1 0000 0111 | 0x07|（0x107）|0xE0|
|CRC-8/MAXIM| x8+x5+x4+1       | 1 0011 0001 | 0x31|（0x131）|0x8C|
|CRC-8      | x8+x6+x4+x3+x2+x1| 1 0101 1110 | 0x5E|（0x15E）|0x7A|

</br>
XOR从数据的高位开始，称为顺序异或；对于数据低位先
传的方式，XOR从数据的低位开始，称之为反序异或

* 区别1：CRC判断的高低位区别，0x01 or 0x80
* 区别2：CRC poly 不同，顺序和逆序值二进制方式颠倒
</br>

### 顺序异或CRC8

```
unsigned char crc_msb(unsigned char *ptr, unsigned char len)
{
    unsigned char poly = 0x07;//0x31;
    unsigned char init = 0x00;/* 初始crc值 */
    unsigned char i;

    unsigned char crc=init;
    while(len--)
    {
        crc ^= *ptr++;    /* 每次先与需要计算的数据异或,计算完指向下一数据 */
        for(i=0;i<8;i++)  /* 计算一个字节crc */
        {
            if (crc & 0x80)
                crc = (crc << 1) ^ poly;
            else
                crc = (crc << 1);
        }
    }
    return (crc);
}
```

### 逆序异或CRC8

```
unsigned char crc_lsb(unsigned char *ptr, unsigned char len)
{
    unsigned char poly_inverse = 0xE0;//0x8C;
    unsigned char init = 0x00;/* 初始crc值 */
    unsigned char i;

    unsigned char crc=init;
    while(len--)
    {
        crc ^= *ptr++;  /* 每次先与需要计算的数据异或,计算完指向下一数据 */
        for(i=0;i<8;i++)/* 同样需要计算8次 */
        {
            if (crc & 0x01)  /* 反序异或变成判断最低位是否为1 */
                /* 数据变成往右移位了 */
                /* 计算的多项式从0x31（0011 0001）变成了0x8C (1000 1100) */
                /* 多项式d值，原来的最高位变成了最低位，原来的最低位变成最高位，8位数据高低位交换一下位置 */
                crc = (crc >> 1) ^ poly_inverse;
            else
                crc = (crc >> 1);
        }
    }
    return (crc);
}
```

### CRC8测试用例

demo:
```
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

//DA 01 A0 FF FF 19 14 07 D0 25 6D FF 74 FF 32 02 B8 6D FF FF FF FF FF FF FF FF FF FF FF FF 4B FF
unsigned char data_raw[] = {0xDA,0x01,0xA0,0xFF,0xFF,0x19,0x14,0x07,0xD0, \
                            0x25,0x6D,0xFF,0x74,0xFF,0x32,0x02,0xB8,0x6D, \
                            0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF, \
                            0xFF,0xFF,0xFF,0x4B,0xFF};// CRC8 0x77   maxim

//16 f1 34 12 11
unsigned char data_raw2[] = {0x16, 0xf1, 0x34, 0x12, 0x11};// CRC8---- 0xC7

unsigned char crc_msb(unsigned char *ptr, unsigned char len)
{
    unsigned char poly = 0x07;//0x31;
    unsigned char init = 0x00;/* 初始crc值 */
    unsigned char i;

    unsigned char crc=init;
    while(len--)
    {
        crc ^= *ptr++;    /* 每次先与需要计算的数据异或,计算完指向下一数据 */
        for(i=0;i<8;i++)  /* 下面这段计算过程与计算一个字节crc一样 */
        {
            if (crc & 0x80)
                crc = (crc << 1) ^ poly;
            else
                crc = (crc << 1);
        }
    }
    return (crc);
}

unsigned char crc_lsb(unsigned char *ptr, unsigned char len)
{
    unsigned char poly_inverse = 0xE0;//0x8C;
    unsigned char init = 0x00;/* 初始crc值 */
    unsigned char i;

    unsigned char crc=init;
    while(len--)
    {
        crc ^= *ptr++;  /* 每次先与需要计算的数据异或,计算完指向下一数据 */
        for(i=0;i<8;i++)/* 同样需要计算8次 */
        {
            if (crc & 0x01)  /* 反序异或变成判断最低位是否为1 */
                /* 数据变成往右移位了 */
                /* 计算的多项式从0x31（0011 0001）变成了0x8C (1000 1100) */
                /* 多项式d值，原来的最高位变成了最低位，原来的最低位变成最高位，8位数据高低位交换一下位置 */
                crc = (crc >> 1) ^ poly_inverse;
            else
                crc = (crc >> 1);
        }
    }
    return (crc);
}


int main()
{
    unsigned int crc_value = 0;
    unsigned char data_len = sizeof(data_raw)/sizeof(unsigned char);

    crc_value = crc_msb(data_raw, data_len);
    printf("crc msb is:0x%x\r\n", crc_value);
    crc_value = crc_lsb(data_raw, data_len);
    printf("crc lsb is:0x%x\r\n", crc_value);

    return 0;
}

```

console output info:

```
crc msb is:0x69
crc lsb is:0x6f

Process returned 0 (0x0) execution time : 0.035 s
Press any key to continue.
```

<div>
    <a href="/media/note_img/CRC/CRC8/test_crc8.zip">测试用例工程 附件下载</a>
</div>

<br/>

<div>
    <a href="/media/note_img/CRC/CRC8/CRC_Calc+v0.1.exe">CRC小工具 附件下载</a>
</div>

### create CRC8 table

生成CRC8 table
```
unsigned char cal_table_msb(unsigned char value)
{
    unsigned char i, crc;

    crc = value;
    /* 数据往左移了8位，需要计算8次 */
    for (i=8; i>0; --i)
    {
        if (crc & 0x80)  /* 判断最高位是否为1 */
        {
        /* 最高位为1，不需要异或，往左移一位，然后与0x31异或 */
        /* 0x31(多项式：x8+x5+x4+1，100110001)，最高位不需要异或，直接去掉 */
            crc = (crc << 1) ^ 0x07;        }
        else
        {
            /* 最高位为0时，不需要异或，整体数据往左移一位 */
            crc = (crc << 1);
        }
    }

    return crc;
}

unsigned char cal_table_lsb(unsigned char value)
{
    unsigned char i, crc;

    unsigned char poly_inverse = 0xE0;//0x8C;

    crc = value;
    /* 数据往左移了8位，需要计算8次 */
    for(i=0;i<8;i++)/* 同样需要计算8次 */
    {
        if (crc & 0x01)  /* 反序异或变成判断最低位是否为1 */
            /* 数据变成往右移位了 */
            /* 计算的多项式从0x31（0011 0001）变成了0x8C (1000 1100) */
            /* 多项式d值，原来的最高位变成了最低位，原来的最低位变成最高位，8位数据高低位交换一下位置 */
            crc = (crc >> 1) ^ poly_inverse;
        else
            crc = (crc >> 1);
    }

    return crc;
}


void  create_crc_table(void)
{
    unsigned short i;
    unsigned char j;

    for (i=0; i<=0xFF; i++)
    {
        if (0 == (i%16))
            printf("\n");

        j = i & 0xFF;
        printf("0x%.2x, ", cal_table_msb(j));  /*依次计算每个字节的crc校验值*/
    }
}
```

使用CRC8 table

```
unsigned char cal_crc_table(unsigned char *ptr, unsigned char len) 
{
    unsigned char  crc = 0x00;
    while (len--)
    {
        crc = crc_table[crc ^ *ptr++];
    }
    return (crc);
}
```

<br/>
<br/>

### [HotPower超级CRC计算器(转载 侵删)](/media/HotCRC.html)

```
<div style="width:100%; border:none; text-align:left">
    <iframe allowtransparency="yes" frameborder="0" width="700" height="1600" src="/media/HotCRC.html"/>
</div>
```



<br/>
<br/>
<br/>
<br/>
