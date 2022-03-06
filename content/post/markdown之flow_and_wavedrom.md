---
categories:
- 笔记
date: 2021-06-06T21:19:19+08:00
description: Resonance,natural language communication
keywords:
- 其他
title: "markdown之flow_and_wavedrom"
url: ""
# math : true
# mermaid : true
wavedrom : true
---


<script type="WaveDrom">
{ signal : [
  { name: "clk",  wave: "p......" },
  { name: "bus",  wave: "x.34.5x",   data: "head body tail" },
  { name: "wire", wave: "0.1..0." },
]}
</script>

```WaveDrom
{ signal : [
  { name: "clk",  wave: "p......" },
  { name: "bus",  wave: "x.34.5x",   data: "head body tail" },
  { name: "wire", wave: "0.1..0." },
]}
```

blog format:
```
<script type="WaveDrom">
{ signal : [
  { name: "clk",  wave: "p......" },
  { name: "bus",  wave: "x.34.5x",   data: "head body tail" },
  { name: "wire", wave: "0.1..0." },
]}
</script>
```

</br>

<script type="WaveDrom">
{ signal: [
  { name: "pclk", wave: 'p.......' },
  { name: "Pclk", wave: 'P.......' },
  { name: "nclk", wave: 'n.......' },
  { name: "Nclk", wave: 'N.......' },
  {},
  { name: 'clk0', wave: 'phnlPHNL' },
  { name: 'clk1', wave: 'xhlhLHl.' },
  { name: 'clk2', wave: 'hpHplnLn' },
  { name: 'clk3', wave: 'nhNhplPl' },
  { name: 'clk4', wave: 'xlh.L.Hx' },
]}
</script>

```WaveDrom
{ signal: [
  { name: "pclk", wave: 'p.......' },
  { name: "Pclk", wave: 'P.......' },
  { name: "nclk", wave: 'n.......' },
  { name: "Nclk", wave: 'N.......' },
  {},
  { name: 'clk0', wave: 'phnlPHNL' },
  { name: 'clk1', wave: 'xhlhLHl.' },
  { name: 'clk2', wave: 'hpHplnLn' },
  { name: 'clk3', wave: 'nhNhplPl' },
  { name: 'clk4', wave: 'xlh.L.Hx' },
]}
```

blog format:
```
<script type="WaveDrom">
{ signal: [
  { name: "pclk", wave: 'p.......' },
  { name: "Pclk", wave: 'P.......' },
  { name: "nclk", wave: 'n.......' },
  { name: "Nclk", wave: 'N.......' },
  {},
  { name: 'clk0', wave: 'phnlPHNL' },
  { name: 'clk1', wave: 'xhlhLHl.' },
  { name: 'clk2', wave: 'hpHplnLn' },
  { name: 'clk3', wave: 'nhNhplPl' },
  { name: 'clk4', wave: 'xlh.L.Hx' },
]}
</script>
```

<script type="WaveDrom">
{ assign:[
  ["out",
    ["XNOR",
      ["NAND",
        ["INV", "a"],
        ["NOR", "b", ["BUF","c"]]
      ],
      ["AND",
        ["XOR", "d", "e", ["OR","f","g"]],
        "h"
      ]
    ]
  ]
]}
</script>

```WaveDrom
{ assign:[
  ["out",
    ["XNOR",
      ["NAND",
        ["INV", "a"],
        ["NOR", "b", ["BUF","c"]]
      ],
      ["AND",
        ["XOR", "d", "e", ["OR","f","g"]],
        "h"
      ]
    ]
  ]
]}
```


blog format:
```
<script type="WaveDrom">
{ assign:[
  ["out",
    ["XNOR",
      ["NAND",
        ["INV", "a"],
        ["NOR", "b", ["BUF","c"]]
      ],
      ["AND",
        ["XOR", "d", "e", ["OR","f","g"]],
        "h"
      ]
    ]
  ]
]}
</script>
```

</br>

<script type="WaveDrom">
{ assign:[
  ["g0", ["^", "b0", "b1"]],
  ["g1", ["^", "b1", "b2"]],
  ["g2", ["^", "b2", "b3"]],
  ["g3", ["=", "b3"]]
]}
</script>

```WaveDrom
{ assign:[
  ["g0", ["^", "b0", "b1"]],
  ["g1", ["^", "b1", "b2"]],
  ["g2", ["^", "b2", "b3"]],
  ["g3", ["=", "b3"]]
]}
```
</br>


blog format:
```
<script type="WaveDrom">
{ assign:[
  ["g0", ["^", "b0", "b1"]],
  ["g1", ["^", "b1", "b2"]],
  ["g2", ["^", "b2", "b3"]],
  ["g3", ["=", "b3"]]
]}
</script>
```