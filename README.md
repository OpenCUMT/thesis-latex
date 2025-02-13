# 中国矿业大学研究生学位论文 LaTeX 模板

![Last Commit](https://img.shields.io/github/last-commit/senli1073/cumtthesis)
[![GitHub release](https://img.shields.io/github/v/release/senli1073/cumtthesis)](https://github.com/senli1073/cumtthesis/releases/latest)
[![License](https://img.shields.io/github/license/senli1073/cumtthesis)](https://github.com/senli1073/cumtthesis/blob/master/README.md)

## 简介

本 LaTeX 模板根据[《中国矿业大学研究生学位论文撰写规定及模板（2021年版）》](https://gs.cumt.edu.cn/info/1049/3149.htm)的要求编写，适用于中国矿业大学本科毕业论文（设计）、硕士学位论文、博士学位论文的撰写。

> **注意**：暂不支持外文学院硕士毕业论文。

> **Overleaf 模板**：[点击此处](https://www.overleaf.com/latex/templates/10290-zhong-guo-kuang-ye-da-xue-shuo-shi-sheng-bi-ye-lun-wen-mo-ban/qwggynbswxwg)访问 Overleaf 模板，近期将同步更新。

## 编译文档

### 1. 本地编译

- **编译论文** `thesis.pdf`：
   ```bash
   latexmk -xelatex thesis.tex
   ```

- **清理编译临时文件**：
   ```bash
   latexmk -c
   ```

### 2. Overleaf 编译

直接使用 [Overleaf 模板](https://www.overleaf.com/latex/templates/10290-zhong-guo-kuang-ye-da-xue-shuo-shi-sheng-bi-ye-lun-wen-mo-ban/qwggynbswxwg)进行在线编译。

## 反馈问题

### 1. 发现 BUG

请在 [Issues](https://github.com/senli1073/cumtthesis/issues) 中提交新 issue，并附带以下信息：
- **环境版本**（如 TeXLive、MacTeX 等）
- **问题说明及截图**
- **问题复现步骤**

### 2. 提出建议

欢迎在 [Issues](https://github.com/senli1073/cumtthesis/issues) 中提出新 issue，并详细描述您的建议。

## 更新日志

### 2025.01.27  V2.2.0-beta
- 修复元数据配置默认值处理 bug
- 新增盲审模式

### 2025.01.26  V2.1.0-beta
- 优化数据集页面
- 去除 `degree-level` 参数，改为根据 `thesis-type` 参数自动识别
- 适配本科毕业论文（设计）

### 2025.01.15  V2.0.2-beta
- 调整部分间距
- 修复若干小 bug
- 增强对生僻字的支持

### 2025.01.12  V2.0.1-beta
- 改用 `ctexbook` 文档类，更适合学位论文撰写
- 优化配置命令输入方式，采用 key-value 格式
- 优化配置命令，增加可选项检查

### 2024.12.23 V1.3.0
- 使用矢量图 LOGO
- 优化封面、正文、页眉、页脚等尺寸和间距
- 修复字号、字体错误问题
- 优化部分环境冲突问题
- 新增若干环境
- 优化大量细节

### 2024.12.15 V1.2.0
- 优化目录、图列表样式
- 优化基本信息命令

### 2023.08.22 V1.0.0
- 缩短封面页中英文题目行间距
- 增加封面页作者与导师行间距
- 增加封面页作者和导师的可输入长度
- 增加封面题目与作者和导师之间的垂直距离
- 修正表清单字体为 5 号
- 新增 `ifthen` 宏包，提供判断逻辑运算
- 更改页面布局（信息页、图清单、表清单、变量注释表）
- 新增 `\paragraph` 命令
- ~~新增对中文生僻字的支持，可在组内使用 `\RareWord` 命令~~
- 修复图表中文标题字号为小四的问题
- 修改参考文献条目间距

### 2023.08.22 V0.3.1
- 调整行间距及段间距
- 修改封面参数

### 2023.04.04 V0.3.0
- 更改学位论文数据集实现方式
- 实现获取最后一页页码数
- 新增指导老师职称命令，重新实现指导老师输入方式
- 新增学位论文数据集自动生成条目
- 重新实现封面页
- ~~用户需将 `SectionTex` 中的 `dataCollection.tex` 替换为自己项目中的对应文件~~

### 2023.04.03 V0.2.0
- 新增 `\AA` 命令，用于表示单位埃符号
- 新增 `tabularx` 宏包

### 2023.03.09 V0.1.0
- ~~新增 `gbt7714-numerical.bst`、`gbt7714.sty` 文件~~，修改参考文献列表作者大小写字母格式
- 用户需将上述文件导入项目根目录中，具体位置可参考模板

## License

Copyright C.Zhang & S.Li, CUMT. 2024-2025. Licensed under an MIT license.
