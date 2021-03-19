---
categories:
- 思考
date: 2021-03-05T19:22:22+08:00
description: Resonance,natural language communication
keywords:
- 技术
title: "C高级用法"
url: ""
---

## 思想

* 高内聚 低耦合
* 语言只是工具，思想才是用好工具的关键 Eg. 面向对象编程思想

块：Block 空间换时间
流：Stream 时间换空间

</br>

# C实现面向对象的基本形式及用例

## 封装

数据的组织形式，把属于一个对象的所有属性（数据）组织起来

```C
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct _class_fun_t{
    uint8_t num;
    void (*tao)(struct _class_fun_t *p)
}fun_t;

void print_num(fun_t *p)
{
    printf("print_num:%d\r\n", p->num);
}

int main()
{
    fun_t fun1;
    fun_t fun2;

    fun1.num = 123;
    fun2.num = 234;

    fun1.tao = print_num;
    fun2.tao = print_num;

    fun1.tao(&fun1);
    fun2.tao(&fun2);

    return 0;
}

```

## 继承 (child 可以继承 parent 所有的‘基因’)

```C
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct _class_fun_parent_t{
    uint8_t num;
    void (*tao)(struct _class_fun_parent_t *p)
}fun_parent_t;

typedef struct _class_fun_child_t{
    fun_parent_t parent; // 父类必须放到前边，不能与后边的成员交换顺序，原因不清楚
    uint8_t child_num;
    void (*tao)(struct _class_fun_child_t *p)
}fun_child_t;

void parent_print_num(fun_parent_t *p)
{
    printf("parent_num:%d\r\n", p->num);
}

void child_print_num(fun_child_t *p)
{
    printf("child_num :%d\r\n", p->child_num);
}

void p_fun(fun_parent_t *p)
{
    p->tao(p);
}

int main()
{
    fun_parent_t fun1;
    fun_child_t fun2;

    fun1.num = 11;
    fun1.tao = parent_print_num;

    fun1.tao(&fun1);

    fun2.parent.num = 222;
    fun2.parent.tao = parent_print_num;
    fun2.child_num = 111;
    fun2.tao = child_print_num;

    fun2.tao(&fun2);
    fun2.parent.tao(&fun2);

    //p_fun((fun_parent_t *)&fun1);
    //p_fun((fun_parent_t *)&fun2);

    return 0;
}
```

## 多态 (一个接口可产生多种执行状态)

* 编译时多态 （函数重载 & 类重载）
* 运行时多态 （虚函数 等）
！如果一门语言只支持类而不支持多态，它只能称之为基于对象而非面向对象

    
```C
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct _class_fun_t{
    uint8_t num;
    void (*tao)(struct _class_fun_t *p)
}fun_t;

void print_num_dec(fun_t *p)
{
    printf("print_num:0d%d\r\n", p->num);
}

void print_num_hex(fun_t *p)
{
    printf("print_num:0x%x\r\n", p->num);
}

int main()
{
    fun_t fun1;

    fun1.num = 123;

    fun1.tao = print_num_dec;
    fun1.tao(&fun1);
    fun1.tao = print_num_hex;
    fun1.tao(&fun1);

    return 0;
}

```

## 动态接口

static/media/note_img/C高级用法/c_code_if_test.zip

main.c

```C
#include <stdint.h>

#include "led.h"
#include "type_a_led.h"
#include "type_b_led.h"

int main()
{
    register_led(a_led);
    led_on();
    led_off();

    register_led(b_led);
    led_on();
    led_off();

    return 0;
}
```

led.h
```C
#ifndef LED_H_
#define LED_H_

typedef struct
{
    void (*on)(void);
    void (*off)(void);
}led_if_t;

void register_led(led_if_t led);
void led_on(void);
void led_off(void);

#endif // LED_H_INCLUDED
```


led.c
```C
#include "led.h"

static led_if_t led_if;

void register_led(led_if_t led)
{
    led_if = led;
}

void led_on(void)
{
    led_if.on();
}

void led_off(void)
{
    led_if.off();
}
```

type_a_led.h
```C
#ifndef TYPE_A_LED_H_
#define TYPE_A_LED_H_

#include "led.h"

extern led_if_t a_led;
extern void test(void);

#endif // TYPE_A_LED_H_INCLUDED
```
type_a_led.c
```C
#include "type_a_led.h"

static void on(void)
{
    printf("type_a on\r\n");
}
static void off(void)
{
    printf("type_a off\r\n");
}

led_if_t a_led = {
    on,
    off,
};

```
type_b_led.h
```C
#ifndef TYPE_B_LED_H_
#define TYPE_B_LED_H_

#include "led.h"

led_if_t b_led;


#endif // TYPE_B_LED_H_INCLUDED
```
type_b_led.c
```C
#include "type_b_led.h"

static void on(void)
{
    printf("type_b on\r\n");
}
static void off(void)
{
    printf("type_b off\r\n");
}

led_if_t b_led = {
    on,
    off,
};
```



# C 优化内存

## union 共用体
```
```

## 位域 bit fields

```C
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct
{
    uint8_t a : 1;
    uint8_t b : 1;
    uint8_t c : 1;
    uint8_t d : 5;
}bit_area1_t;

typedef struct
{
    uint8_t a : 1;
    uint8_t b : 1;
    uint8_t c : 1;
    uint8_t   : 1;// 无名位域 同样占用bit位空间
    uint8_t d : 5;
}bit_area2_t;

/*
typedef struct
{
    uint8_t a : 1;
    uint8_t b : 1;
    uint8_t c : 1;
    uint8_t d : 9;// 不能超过 uint8_t 的bit大小
}bit_area2_t;
*/

int main()
{
    bit_area1_t test;
    printf("bit_area1_t size:%d\r\n", sizeof(bit_area1_t));
    printf("bit_area2_t size:%d\r\n", sizeof(bit_area2_t));
    test.a = 2;
    test.b = 1;
    test.c = 2;
    test.d = 5;
    printf("%d\r\n", test.a);
    printf("%d\r\n", test.b);
    printf("%d\r\n", test.c);
    printf("%d\r\n", test.d);

    return 0;
}
```

## 结构体对齐

```C
#include <stdio.h>
#include <stdint.h>

//#pragma pack(1)

//有字节对齐预编译结果为：12，8
//无字节对齐预编译结果为：6，6

typedef struct{
    uint8_t a;
    uint32_t b;
    uint8_t c;
}align1_t;

typedef struct{
    uint8_t a;
    uint8_t c;
    uint32_t b;
}align2_t;

int main()
{
    printf("align1_t size:%d\r\n", sizeof(align1_t));
    printf("align2_t size:%d\r\n", sizeof(align2_t));
    return 0;
}

```