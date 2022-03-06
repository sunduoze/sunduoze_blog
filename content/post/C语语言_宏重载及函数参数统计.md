---
categories:
- 笔记
- 技术
date: 2022-02-19T19:44:06+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "C语语言_宏重载及函数参数统计"
url: ""
draft: false
math : false
mermaid : false
wavedrom : false
---


## 通过宏重载和函数参数统计实现C语言的重载(静态多态)

```C++
#include <iostream>
using namespace std;

#define OVERLOADED_MACRO(M, ...)                _OVR(M, _COUNT_ARGS(__VA_ARGS__)) (__VA_ARGS__)
#define _OVR(macroName, number_of_args)         _OVR_EXPAND(macroName, number_of_args)
#define _OVR_EXPAND(macroName, number_of_args)  macroName##number_of_arg
#define _COUNT_ARGS(...)                        _ARG_PATTERN_MATCH(__VA_ARGS__, 9,8,7,6,5,4,3,2,1)
#define _ARG_PATTERN_MATCH(_1,_2,_3,_4,_5,_6,_7,_8,_9, N, ...)   N

//Example:
#define ff(...)                                 OVERLOADED_MACRO(ff, __VA_ARGS__)
#define ii(...)                                 OVERLOADED_MACRO(ii, __VA_ARGS__)
#define ff3(c, a, b)                            for (int c = int(a); c < int(b); ++c)
#define ff2(c, b)                               ff3(c, 0, b)
                    
#define ii2(a, b)                               ff3(i, a, b)
#define ii1(n)                                  ii2(0, n)


int main() {
    ff (counter, 3, 5)
        cout << "counter = " << counter << endl;
    ff (abc, 4)
        cout << "abc = " << abc << endl;
    ii (3)
        cout << "i = " << i << endl;
    ii (100, 103)
        cout << "i = " << i << endl;
    return 0;
}

```

输出结果：

```
counter = 3
counter = 4
abc = 0
abc = 1
abc = 2
abc = 3
i = 0
i = 1
i = 2
i = 100
i = 101
i = 102
```

<div>
    <a href="/media/note_img/C宏重载+宏函数参数统计.zip">source code</a>
</div>

</br>

</br>.