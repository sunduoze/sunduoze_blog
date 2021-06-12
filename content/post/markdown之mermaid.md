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
    axisFormat  %m-%d
    section 3C
    任务A            :active,a1, 4-18-12, 8h
    任务B            :after a1, 56h
    section VC
    任务C            :crit,done,4-19-02, 12h
    任务D            :crit,17h
    section MC
    任务E            :active,4-18-02, 2d
    任务F            :2d
    section 高风险
    任务E            :4-18-02, 48h
    任务F            :3d
    section 新系统开发
    Tenma            :4-19-18, 1d
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

</br>
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

<div class="flowchart">
    start-->start: 开始
    e-->end: 结束
    start->e
</div>

```
flowchart TB
    c1-->a2
    subgraph one
    a1-->a2
    end
    subgraph two
    b1-->b2
    end
    subgraph three
    c1-->c2
    end
    one --> two
    three --> two
    two --> c2
```

<div class="mermaid">
graph LR
    A[Hard edge] -->|Link text| B(Round edge)
    B --> C{Decision}
    C -->|One| D[Result one]
    C -->|Two| E[Result two]
</div>
    <!-- mermaid.flowchartConfig = {
    width: 100%
} -->

<div class="flowchart">
st=>start: 页面加载

e=>end: End:>http://www.google.com

op1=>operation: get_hotel_ids|past
op2=>operation: get_proxy|current
sub1=>subroutine: get_proxy|current
op3=>operation: save_comment|current
op4=>operation: set_sentiment|current
op5=>operation: set_record|current

cond1=>condition: ids_remain空?
cond2=>condition: proxy_list空?
cond3=>condition: ids_got空?
cond4=>condition: 爬取成功??
cond5=>condition: ids_remain空?

io1=>inputoutput: ids-remain
io2=>inputoutput: proxy_list
io3=>inputoutput: ids-got

st->op1(right)->io1->cond1
cond1(yes)->sub1->io2->cond2
cond2(no)->op3
cond2(yes)->sub1
cond1(no)->op3->cond4
cond4(yes)->io3->cond3
cond4(no)->io1
cond3(no)->op4
cond3(yes, right)->cond5
cond5(yes)->op5
cond5(no)->cond3
op5->e
</div>