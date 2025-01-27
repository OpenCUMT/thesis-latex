[![GitHub commits](https://img.shields.io/github/commits-since/senli1073/cumtthesis/latest)](https://github.com/senli1073/cumtthesis/commits/main)
[![GitHub release](https://img.shields.io/github/v/release/senli1073/cumtthesis/)](https://github.com/senli1073/cumtthesis/releases/latest)

# 中国矿业大学研究生学位论文 LaTeX 模板

此LaTex模板按照[《中国矿业大学研究生学位论文撰写规定及模板（2021年版）》](https://gs.cumt.edu.cn/info/1049/3149.htm)的要求编写，可用于中国矿业大学硕士学位论文、博士学位论文撰写。

> 暂不支持外文学院硕士毕业论文

## 编译文档

- 编译论文 `thesis.pdf`：
   ```
   latexmk -xelatex thesis.tex
   ```

- 清理编译临时文件：
   ```
   latexmk -c
   ```

## 反馈问题

1. 发现BUG

    在 [Issues](https://github.com/senli1073/cumtthesis/issues) 中提出新 issue，并附带以下信息：
    - 环境版本（TeXLive/MacTex等）
    - 问题说明&截图
    - 问题复现流程

2. 提出建议

    在 [Issues](https://github.com/senli1073/cumtthesis/issues) 中提出新 issue，并详尽说明。


## 更新日志

### 2025.01.27  V2.2.0-beta
* 修复元数据配置默认值处理bug
* 增加盲审模式

### 2025.01.26  V2.1.0-beta
* 优化数据集页面
* 去除degree-level参数，根据thesis-type参数识别
* 适配本科毕业论文（设计）

### 2025.01.15  V2.0.2-beta
* 修改了部分间距；
* 修了一些小 bug；

### 2025.01.12  V2.0.1-beta
* 改为使用 ctexbook 文档类，更适合学位论文撰写；
* 优化配置命令输入方式，使用 key-value 方式输入；
* 优化配置命令，增加可选项检查；

### 2024.12.23 V1.3.0
* 使用矢量图LOGO；
* 优化封面、正文、页眉、页脚等尺寸和间距；
* 优化字号、字体错误的问题；
* 优化部分环境冲突问题；
* 增加了一些环境；
* 优化了大量细节；

### 2024.12.15 V1.2.0
* 优化目录、图列表样式；
* 优化基本信息命令；

### 2023.08.22 V1.0.0
* 缩短封面页中英文题目行间距
* 增加封面页作者与导师行间距
* 增加封面页作者和导师的可输入长度
* 增加了封面题目与作者和导师之间的垂直距离
* 修正表清单字体为5号
* 新增ifthen宏包，提供判断逻辑运算
* 更改页面布局(信息页，图清单，表清单，变量注释表)
* 新增\paragraph命令
* 新增对中文生僻字的支持，可以在组里面使用\RareWord命令
* 修改图表中文标题字号为小四的问题
* 修改参考文献条目间距

### 2024.08.22 V0.3.1
* 修改行间距以及段间距；
* 修改封面参数；
* 用户需要将本模板中的cls文件替换掉自己项目中的文件即可

### 2023.04.04 V0.3.0
* 更改学位论文数据集实现方式
* 实现获取最后一页页码数
* 新增指导老师职称命令，重新实现指导老师输入方式
* 新增学位论文数据集自动生成条目
* 重新实现封面页
* 用户需要将SectionTex中的dataCollection.tex替换掉自己项目中的该文件
* 用户需要将cls文件替换掉自己项目中的cls文件


### 2023.04.03 V0.2.0
* 新建\AA命令，为单位埃符号
* 新增tabularx宏包
* 用户需要将本模板中的cls文件替换掉自己项目中的文件即可

### 2023.03.09 V0.1.0
* 新增gbt7714-numerical.bst、gbt7714.sty文件，修改参考文献列表作者大小写字母格式
* 用户需要将上述文件导入自己的项目根目录中，具体位置可以参考模板

## License
Copyright C.Zhang & S.Li, CUMT. 2024-2025. Licensed under an MIT license.