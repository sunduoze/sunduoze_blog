---
categories:
- 笔记
date: 2021-06-06T20:10:29+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "Markdown之mermaid"
url: ""
math : true
mermaid : true
---


<div class="mermaid">
gantt
    title Team 项目周进度
    excludes    weekends
    dateFormat  MM-DD-HH
    axisFormat  %d

    section 2 weeks
    last week :done, 4-19, a1, 5d
    this week:done, after a1, 5d

    section 恺城
    DT3S1P           :4-18, a1, 2d
    P2007            :after a1, 4h
    P2150            :4h
    Ascend           :4-18, 48h

    section 兴辉
    Tenma            :after a1, 4h
</div>


```
Input       Example             Description:
YYYY        2014                4 digit year
YY          14                  2 digit year
Q           1..4                Quarter of year. Sets month to first month in quarter.
M MM        1..12               Month number
MMM MMMM    January..Dec        Month name in locale set by moment.locale()
D DD        1..31               Day of month
Do          1st..31st           Day of month with ordinal
DDD DDDD    1..365              Day of year
X           1410715640.579      Unix timestamp
x           1410715640579       Unix ms timestamp
H HH        0..23               24 hour time
h hh        1..12               12 hour time used with a A.
a A         am pm               Post or ante meridiem
m mm        0..59               Minutes
s ss        0..59               Seconds
S           0..9                Tenths of a second
SS          0..99               Hundreds of a second
SSS         0..999              Thousandths of a second
Z ZZ        +12:00              Offset from UTC as +-HH:mm, +-HHmm, or Z
```


<div class="mermaid">
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
</div>  

<div class="mermaid">
journey
    title 工作日
    section 去工作
      Make tea: 5: 我
      Go upstairs: 3: 我
      Do work: 1: 我, 猫
    section 回家
      Go downstairs: 5: 我
      Sit down:      0: 我,猫,was,hen
  Go downstairs: 5: 我
  Sit down:      0: 我,猫,was,hen
</div>

<div class="mermaid">
pie title What Voldemort doesn't have?
         "FRIENDS" : 2
         "FAMILY" : 3
         "NOSE" : 45
</div> 

<div class="mermaid">
sequenceDiagram
    Alice ->> Bob: Hello Bob, how are you?
    Bob-->>John: How about you John?
    Bob--x Alice: I am good thanks!
    Bob-x John: I am good thanks!
    Note right of John: Bob thinks a long<br/>long time, so long<br/>that the text does<br/>not fit on a row.

    Bob-->Alice: Checking with John...
    Alice->John: Yes... John, how are you?
</div>

<div class="mermaid">
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts<br/>prevail...
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
</div>

