# 中国矿业大学研究生学位论文 LaTeX 模板

![Last Commit](https://img.shields.io/github/last-commit/OpenCUMT/thesis-latex)
[![GitHub release](https://img.shields.io/github/v/release/OpenCUMT/thesis-latex)](https://github.com/OpenCUMT/thesis-latex/releases/latest)
[![License](https://img.shields.io/github/license/OpenCUMT/thesis-latex)](https://github.com/OpenCUMT/thesis-latex/blob/main/LICENSE)

## 简介

本 LaTeX 模板根据[《中国矿业大学研究生学位论文撰写规定及模板（2021年版）》](https://gs.cumt.edu.cn/info/1049/3149.htm)的要求编写，适用于中国矿业大学本科毕业论文（设计）、硕士学位论文、博士学位论文的撰写。

感谢 [@senli1073](https://github/senli1073) 等前辈们的初始贡献！

> [!NOTE]
>
> 暂不支持外文学院硕士学位论文。

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

直接使用 [Overleaf 模板](https://www.overleaf.com/latex/templates/10290-zhong-guo-kuang-ye-da-xue-shuo-shi-sheng-bi-ye-lun-wen-mo-ban/qwggynbswxwg) 进行在线编译。（近期将同步更新）

## 反馈问题

如果你发现了 BUG，请在 [Issues](https://github.com/OpenCUMT/thesis-latex/issues) 界面[提交 BUG](https://github.com/OpenCUMT/thesis-latex/issues/new?template=bug_report.yml).

欢迎在 [Issues](https://github.com/OpenCUMT/thesis-latex/issues) 中提出新 issue，并详细描述您的建议。

## License

Copyright (c) C.Zhang & S.Li, CUMT. All rights reserved.

Licensed under the [LPPL license](LICENSE).
