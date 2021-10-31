---
categories:
- 笔记
keywords:
- 技术
title: "c_doxygen_vscode"
date: 2021-10-31T16:41:27+08:00
url: ""
---


### doxygen 命令关键字

* 文件信息：

1. @file --> 文件声明，即当前文件名
2. @author --> 作者
3. @version --> 版本，
4. @todo --> 改进，可以指定针对的版本

* 模块信息：

1. @var --> 模块变量说明
2. @typedef --> 模块变量类型说明

* 函数信息：

1. @param --> 参数说明
2. @arg --> 列表说明参数信息
3. @return --> 返回值说明
4. @retval --> 返回值类型说明
5. @note --> 注解

* 提醒信息：

1. @brief --> 摘要，即当前文件说明
2. @see --> 参看
3. @attention --> 注意
4. @bug --> 问题
5. @warning --> 警告
6. @sa --> 参考资料


### VS code :Doxygen Documentation Generator

 settings.json

```
{
    // The prefix that is used for each comment line except for first and last.
    "doxdocgen.c.commentPrefix": "  * ",

    // Smart text snippet for factory methods/functions.
    "doxdocgen.c.factoryMethodText": "Create a {name} object",

    // The first line of the comment that gets generated. If empty it won't get generated at all.
    "doxdocgen.c.firstLine": "/**",

    // Smart text snippet for getters.
    "doxdocgen.c.getterText": "Get the {name} object",

    // The last line of the comment that gets generated. If empty it won't get generated at all.
    "doxdocgen.c.lastLine": "  */",

    // Smart text snippet for setters.
    "doxdocgen.c.setterText": "Set the {name} object",

    // Doxygen comment trigger. This character sequence triggers generation of Doxygen comments.
    "doxdocgen.c.triggerSequence": "/**",

    // Smart text snippet for constructors.
    "doxdocgen.cpp.ctorText": "Construct a new {name} object",

    // Smart text snippet for destructors.
    "doxdocgen.cpp.dtorText": "Destroy the {name} object",

    "window.zoomLevel": 0,
    "editor.minimap.enabled": false,
    "python.pythonPath": "C:\\Users\\Ez\\AppData\\Local\\Programs\\Python\\Python36\\python.exe",
    "workbench.iconTheme": "vs-seti",
    "explorer.autoReveal": false,   //取消左侧自动聚焦
    "terminal.external.windowsExec": "C:\\Program Files\\Git\\bash.exe",
    "todo-tree.highlights.enabled": true,
    // Doxygen documentation generator set
    "doxdocgen.file.copyrightTag": [
        "@copyright  Copyright (c) {year} Enzo Sun All Right Reserved"
    ],
    "doxdocgen.file.customTag": [
        "@par modify log:",
        "<table>",
        "<tr><th>Date       <th>Version <th>Author  <th>Description",
        "<tr><td>{date} <td>1.0     <td>Enzo    <td>detail",
        "</table>",
    ],
    "doxdocgen.file.fileOrder": [
        "file",
        "brief",
        "author",
        "version",
        "date",
        "empty",
        "copyright",
        "empty",
        "custom"
    ],
    "doxdocgen.file.fileTemplate":     "@file       {name}",
    "doxdocgen.file.versionTag":       "@version    1.0.0",
    "doxdocgen.generic.useGitUserName": false,
    "doxdocgen.generic.authorEmail":   "sunduoze@163.com",
    "doxdocgen.generic.authorName":    "  Enzo",
    "doxdocgen.generic.authorTag":     "@author   {author} ({email})",
    "doxdocgen.generic.briefTemplate": "@brief      <h3>template</h3>",

    "doxdocgen.generic.dateFormat":    "YYYY/MM/DD",
    "doxdocgen.generic.dateTemplate": "@date       {date}",
    // 根据自动生成的注释模板（目前主要体现在函数注释上）
    "doxdocgen.generic.order": [
        "brief",
        "tparam",
        "param",
        "return",
        "arg",
        "author",
        "date",
    ],

    "doxdocgen.generic.paramTemplate":  "@param[in]  {param} param doc", ///< "@param[in] {indent:8}{param}{indent:25}param doc",
    "doxdocgen.generic.returnTemplate": "@return     {type}  @arg      0:  @arg      1:",
    "doxdocgen.generic.includeTypeAtReturn": true,
    "doxdocgen.generic.boolReturnsTrueFalse": true,
    "doxdocgen.generic.splitCasingSmartText": true,
    "doxdocgen.generic.commandSuggestion": true,
    "doxdocgen.generic.generateSmartText": true,
    "doxdocgen.generic.commandSuggestionAddPrefix": true,
    "tabnine.experimentalAutoImports": true
   
}

```

<br/>
