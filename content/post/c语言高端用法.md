---
categories:
- 笔记
date: 2020-11-02T10:45:42+08:00
keywords:
- 嵌入式
title: "C语言高端用法"
url: ""
---
<br/>
<br/>
from:(https://www.zhihu.com/question/386657140/answer/1172560546)

## 泛型

#### 基本操作

```
#include <stdio.h>
#include <stdlib.h>

//#define pair(T1,T2, ...) pair$_##T1##_$$_##T2##_$##__VA_ARGS__ // $：貌似没有作用
#define pair(T1,T2, ...) pair##T1##T2##__VA_ARGS__

#define pair_def(T1,T2) \
typedef struct pair(T1,T2) pair(T1,T2);\
struct pair(T1,T2) {\
T1 first;\
T2 second;\
}

typedef char* str;

pair_def(int, char);
pair_def(str, float);

int main()
{
    pair(int, char) p1;
    pair(str, float) p2;

    p1.first = 123;
    p1.second = 'a';

    p2.first = "hello";
    p2.second = 3.14f;

    printf("p1:%d,%c\r\n", p1.first, p1.second);
    printf("p2:%s,%f\r\n", p2.first, p2.second);

    return 0;
}

output:
p1:123,a
p2:hello,3.140000

```

#### 增加构造函数

```
#include <stdio.h>
#include <stdlib.h>

//#define pair(T1,T2, ...) pair$_##T1##_$$_##T2##_$##__VA_ARGS__
#define pair(T1,T2, ...) pair##T1##T2##__VA_ARGS__

#define pair_def(T1,T2) \
typedef struct pair(T1,T2) pair(T1,T2);\
struct pair(T1,T2) {\
T1 first;\
T2 second;\
}; \
\
void pair(T1, T2, init)(pair(T1, T2)* _this,\
                             T1 t1,\
                             T2 t2)\
                        {\
                          _this->first = t1;\
                          _this->second = t2;\
                        } // add 构造函数

typedef char* str;

pair_def(int, char);
pair_def(str, float);

int main()
{
    pair(int, char) p1;
    pair(str, float) p2;

    p1.first = 123;
    p1.second = 'a';

    p2.first = "hello";
    p2.second = 3.14f;

    printf("p1:%d,%c\r\n", p1.first, p1.second);
    printf("p2:%s,%f\r\n", p2.first, p2.second);

    // add 构造函数
    pair(int, char, init)(&p1, 123, 'a');
    pair(str, float, init)(&p2, "hello", 3.14f);

    printf("p1:%d,%c\r\n", p1.first, p1.second);
    printf("p2:%s,%f\r\n", p2.first, p2.second);
    return 0;
}

output:
p1:123,a
p2:hello,3.140000
p1:123,a
p2:hello,3.140000

```

#### 增加静态成员函数

```
#include <stdio.h>
#include <stdlib.h>

//#define pair(T1,T2, ...) pair$_##T1##_$$_##T2##_$##__VA_ARGS__
#define pair(T1,T2, ...) pair##T1##T2##__VA_ARGS__

#define pair_def(T1,T2) \
typedef struct pair(T1,T2) pair(T1,T2);\
struct pair(T1,T2) {\
T1 first;\
T2 second;\
void (*print_type)(void);\
}; \
\
void pair(T1, T2, print_type)(void) {\
    printf("T1:"#T1", T2:"#T2"\r\n");\
}\
void pair(T1, T2, init)(pair(T1, T2)* _this,\
                             T1 t1,\
                             T2 t2)\
                        {\
                          _this->print_type = pair(T1, T2, print_type);\
                          _this->first = t1;\
                          _this->second = t2;\
                        } // add 构造函数

typedef char* str;

pair_def(int, char);
pair_def(str, float);

int main()
{
    pair(int, char) p1;
    pair(str, float) p2;

    p1.first = 123;
    p1.second = 'a';

    p2.first = "hello";
    p2.second = 3.14f;

    printf("p1:%d,%c\r\n", p1.first, p1.second);
    printf("p2:%s,%f\r\n", p2.first, p2.second);

    // add 构造函数
    pair(int, char, init)(&p1, 123, 'a');
    pair(str, float, init)(&p2, "hello", 3.14f);

    printf("p1:%d,%c\r\n", p1.first, p1.second);
    printf("p2:%s,%f\r\n", p2.first, p2.second);

    // add 静态成员函数
    p1.print_type();
    printf("p1:%d,%c\r\n", p1.first, p1.second);
    p2.print_type();
    printf("p2:%s,%f\r\n", p2.first, p2.second);

    return 0;
}

output:
p1:123,a
p2:hello,3.140000
p1:123,a
p2:hello,3.140000
T1:int, T2:char
p1:123,a
T1:str, T2:float
p2:hello,3.140000
```

#### 增加静态成员函数（必须得传入this指针的）

```

#include <stdio.h>
#include <stdlib.h>
//#define pair(T1,T2, ...) pair$_##T1##_$$_##T2##_$##__VA_ARGS__
#define pair(T1,T2, ...) pair##T1##T2##__VA_ARGS__

#define pair_def(T1, T2) \
typedef struct pair(T1, T2) pair(T1, T2); \
struct pair(T1, T2) { \
    T1 first; \
    T2 second; \
    void (*print_type)(void); \
    void (*print_val)(const pair(T1, T2)* _this); \
}; \
\
void pair(T1, T2, print_type)(void) { \
    printf("T1: "#T1", T2: "#T2"\n"); \
} \
\
void pair(T1, T2, init)( \
    pair(T1, T2)* _this, \
    void (*pair(T1, T2, print_val))(const pair(T1, T2)*), \
    T1 t1, \
    T2 t2) \
{ \
    _this->print_type = pair(T1, T2, print_type); \
    _this->print_val = pair(T1, T2, print_val); \
    _this->first = t1; \
    _this->second = t2; \
}

typedef const char* str;

pair_def(int, char);
pair_def(str, float);

void pair(int, char, print_val)(const pair(int, char)* _this) {
    printf("%d, %c\n", _this->first, _this->second);
}

void pair(str, float, print_val)(const pair(str, float)* _this) {
    printf("%s, %f\n", _this->first, _this->second);
}

int main() {
    // Pair(int, char)模仿C++的Pair<int, char>写法
    // 该宏将被扩展为Pair$_int_$$_char_$
    pair(int, char) p1;
    pair(str, float) p2;

    // Pair(int, char, Init)()模仿C++的访问成员函数Pair<int, char>::Init()写法
    // 该宏将被扩展为Pair$_int_$$_char_$Init()
    pair(int, char, init)(&p1, pair(int, char, print_val), 123, 'a');
    pair(str, float, init)(&p2, pair(str, float, print_val), "pi", 3.14f);

    p1.print_type();
    p1.print_val(&p1);

    p2.print_type();
    p2.print_val(&p2);

    return 0;
}

```


#### 封装成头
header
```
#ifndef __PAIR_H_
#define __PAIR_H_

/* pair_template.h */
#include <stdio.h>

#define pair(T1, T2, T3, ...) pair$##T1##$##T2##$##T3##$##__VA_ARGS__

// declaration /////////////////////////////////////////////////////////////////
#define pair_decl(T1, T2, T3) \
typedef struct pair(T1, T2, T3) pair(T1, T2, T3); \
struct pair(T1, T2, T3) { \
    T1 first; \
    T2 second; \
    T3 third; \
    void (*print_type)(void); \
    void (*print_val)(const pair(T1, T2, T3)* _this); \
}; \
\
void pair(T1, T2, T3, init)( \
    pair(T1, T2, T3)* _this, \
    T1 t1, \
    T2 t2, \
    T3 t3)

// definition //////////////////////////////////////////////////////////////////
#define pair_def(T1, T2, T3) \
static void pair(T1, T2, T3, print_type)(void) { \
    printf("T1: "#T1", T2: "#T2", T3: "#T3"\n"); \
} \
\
void pair(T1, T2, T3, init)( \
    pair(T1, T2, T3)* _this, \
    T1 t1, \
    T2 t2, \
    T3 t3) \
{ \
    _this->print_type = pair(T1, T2, T3, print_type); \
    _this->print_val = pair(T1, T2, T3, print_val); \
    _this->first = t1; \
    _this->second = t2; \
    _this->third = t3; \
}

typedef const char* str;

pair_decl(int, char, str);
pair_decl(str, float, str);
pair_decl(float, str, str);
pair_decl(str, str, str);

#endif // __PAIR_H_

```

```
#include "pair.h"

static void pair(int, char, str, print_val)(const pair(int, char, str)* _this) {
    printf("%d, %c, %s\n", _this->first, _this->second, _this->third);
}

static void pair(str, float, str, print_val)(const pair(str, float, str)* _this) {
    printf("%s, %f, %s\n", _this->first, _this->second, _this->third);
}

static void pair(float, str, str, print_val)(const pair(float, str, str)* _this) {
    printf("%f, %s, %s\n", _this->first, _this->second, _this->third);
}

static void pair(str, str, str, print_val)(const pair(str, str, str)* _this) {
    printf("%s, %s, %s\n", _this->first, _this->second, _this->third);
}


pair_def(int, char, str);
pair_def(str, float, str);
pair_def(float, str, str);
pair_def(str, str, str);

```

main function
```
#include <stdio.h>
#include <stdlib.h>

#include "pair.h"

int main() {
    // Pair(int, char)模仿C++的Pair<int, char>写法
    // 该宏将被扩展为Pair$_int_$$_char_$
    pair(int, char ,str) p1;
    pair(str, float,str) p2;
    pair(float, str,str) p3;
    pair(str, str,str)   p4;


    // pair(int, char, init)()模仿C++的访问成员函数Pair<int, char>::init()写法
    // 该宏将被扩展为Pair$_int_$$_char_$init()
    pair(int, char ,str, init)(&p1, 123, 'a', "!");
    pair(str, float,str, init)(&p2, "pi", 3.14f, "");
    pair(float, str,str, init)(&p3, 3.14f, "hello world", "!");
    pair(str, str,str, init)(&p4, "hello", "world", "!");

    p1.print_type();
    p1.print_val(&p1);

    p2.print_type();
    p2.print_val(&p2);

    p3.print_type();
    p3.print_val(&p3);

    p4.print_type();
    p4.print_val(&p4);

    return 0;
}
```

<br/>
<br/>
<br/>
<br/>
<br/>