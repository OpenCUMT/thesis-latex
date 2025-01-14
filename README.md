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

### 2025.01.12  V2.0.0-beta
* 改为使用ctexbook文档类，更适合学位论文撰写；
* 优化配置命令输入方式，使用key-value方式输入；
* 优化配置命令，增加可选项检查；

### 2024.12.23 V1.3.0
* 使用矢量图CUMT-LOGO；
* 优化封面、正文、页眉、页脚等尺寸和间距；
* 优化字号、字体错误的问题；
* 优化部分环境冲突问题；
* 增加了一些环境；
* 优化了大量细节；

### 2024.12.15 V1.2.0
* 优化目录、图列表样式；
* 优化基本信息命令；

## License
Copyright C.Zhang & S.Li, CUMT. 2024-2025. Licensed under an MIT license.