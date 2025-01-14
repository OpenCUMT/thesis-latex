% MIT License
%
% Copyright (c) 2024-2025 by C.Zhang & S.Li, CUMT.
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

\NeedsTeXFormat{LaTeX2e}[2023/11/01]
\ProvidesClass{cumt-graduate-thesis}[2025/01/09 V2.0.1-beta CUMT Graduate Thesis Template]
\def\version{2.0.1-beta}

% 错误和警告
\newcommand\cumt@raise@error[1]{%
    \ClassError{cumt-graduate-thesis}{#1}{}
}
\newcommand\cumt@raise@warning[1]{%
    \ClassWarning{cumt-graduate-thesis}{#1}
}

% 检查版本
\@ifl@t@r\fmtversion{2023/11/01}{}{
    \cumt@raise@error{2023/11/01 or later version is required, got \fmtversion}
}

% XeLaTeX
\RequirePackage{iftex} % 检查 TeX 引擎
\ifXeTeX\else
    \cumt@raise@error{XeLaTeX is required.}
\fi

% 字符串布尔
\def\@true{true}
\def\@false{false}

% 处理键值选项
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}

\SetupKeyvalOptions{
    family=cumt,
    prefix=cumt@,
}

\newcommand\cumtsetup[1]{%
    \kvsetkeys{cumt}{#1}%
}

% 处理键值定义
\kv@set@family@handler{cumt@keydef}{%
    \@namedef{cumt@keydef@#1@name}{#1}  % 宏名称
    \@namedef{cumt@keydef@#1@default}{} % 默认值
    \@namedef{cumt@keydef@#1@choices@values}{} % 可选项
    \@namedef{cumt@keydef@#1@choices@check}{}  % 选项检查函数
    \@namedef{cumt@keydef@#1@code}{}   % 钩子函数

    \kv@define@key{cumt@keydef@property}{name}{%
        \@namedef{cumt@keydef@#1@name}{##1}%
    }

    \kv@set@family@handler{cumt@keydef@property@choices}{%
        \expandafter\def\csname cumt@keydef@#1@choices@values@##1\endcsname{}
    }

    \kv@define@key{cumt@keydef@property}{choices}{%
        \@namedef{cumt@keydef@#1@choices@values}{##1}
        \edef\tmp@expanded@values{\@nameuse{cumt@keydef@#1@choices@values}}
        \kvsetkeys@expandafter{cumt@keydef@property@choices}{\tmp@expanded@values}
        \@namedef{cumt@keydef@#1@choices@check}{%
            \expandafter\@ifundefined{%
                cumt@keydef@#1@choices@values@\@nameuse{cumt@\@nameuse{cumt@keydef@#1@name}}%
            }{%
                \cumt@raise@error{Illegal value "\@nameuse{cumt@\@nameuse{cumt@keydef@#1@name}}" for key "\@nameuse{cumt@keydef@#1@name}". Available: {\@nameuse{cumt@keydef@#1@choices@values}}}
            }
            \@namedef{cumt@keydef@#1@choices@values@\@nameuse{cumt@\@nameuse{cumt@keydef@#1@name}}}{}
        }
    }

    \kv@define@key{cumt@keydef@property}{default}{%
        \@namedef{cumt@keydef@#1@default}{##1}
        \@namedef{cumt@\@nameuse{cumt@keydef@#1@name}}{##1}
    }

    \kv@define@key{cumt@keydef@property}{code}{%
        \@namedef{cumt@keydef@#1@code}{##1}
    }

    \kvsetkeys{cumt@keydef@property}{#2}

    \kv@define@key{cumt}{#1}{%
        \@namedef{cumt@\@nameuse{cumt@keydef@#1@name}}{##1}
        \@nameuse{cumt@keydef@#1@choices@check}
        \@nameuse{cumt@keydef@#1@code}
    }%
}

\newcommand\cumt@option@hook[2]{%
    \expandafter\g@addto@macro\csname cumt@keydef@#1@code\endcsname{#2}%
}

\newcommand\cumt@define@keys[1]{%
    \kvsetkeys{cumt@keydef}{#1}
}

\cumt@define@keys{
    output={
            name=output,
            default=electronic,
            choices={
                    print,
                    electronic,
                },
        },
    funding-on-cover={
            name=funding@on@cover,
            default=false,
            choices={
                    \@true,
                    \@false,
                },
        },
    title={
            name=title@cn,
            default=论文标题,
        },
    title*={
            name=title@en,
            default=Thesis Title,
        },
    author={
            name=author,
            default=姓名,
        },
    thesis-name={
            name=thesis@name@full,
            default=硕士学位论文,
        },
    supervisor={
            name=supervisor@name,
            default=姓名,
        },
    supervisor-title={
            name=supervisor@title,
            default=职称,
        },
    co-supervisor={
            name=cosupervisor@name,
            default= ,
        },
    co-supervisor-title={
            name=cosupervisor@title,
            default= ,
        },
    year={
            name=year,
            default=2000,
        },
    month={
            name=month,
            default=6,
        },
    degree-applied={
            name=degree@applied,
            default= ,
        },
    affiliation={
            name=affiliation,
            default= ,
        },
    major={
            name=major,
            default= ,
        },
    field={
            name=field,
            default= ,
        },
    defense-committee-chair={
            name=defense@committee@chair,
            default= ,
        },
    reviewer={
            name=reviewer,
            default= ,
        },
    security-level={
            name=security@level,
            default=公开,
        },
    clc={
            name=clc,
            default= ,
        },
    udc={
            name=udc,
            default= ,
        },
    funding={
            name=funding,
            default= ,
        },
    degree-category={
            name=degree@category,
            default= ,
        },
    degree-level={
            name=degree@level,
            default= ,
        },
    language={
            name=language,
            default=中文,
        },
    student-id={
            name=student@id,
            default= ,
        },
    program-duration={
            name=program@duration,
            default= ,
        },
    defense-committee-members={
            name=defense@committee@members,
            default= ,
        },
    electronic-thesis-format={
            name=electronic@thesis@format,
            default= 多媒体,
            choices={
                    文本,
                    图像,
                    视频,
                    音频,
                    多媒体,
                    其他,
                },
        },
    electronic-thesis-publisher={
            name=electronic@thesis@publisher,
            default= ,
        },
    electronic-thesis-publisher-location={
            name=electronic@thesis@publisher@location,
            default= ,
        },
    permission-statement={
            name=permission@statement,
            default= ,
        },
}

% 一些辅助命令
\ExplSyntaxOn
% 英文符号->中文符号
\NewDocumentCommand\cumt@format@symbols@cn@inplace{m}
{
    \tl_set:Nx \l_tmpa_tl { \tl_use:c { #1 } }
    \regex_replace_all:nnN { ; } { ； } \l_tmpa_tl
    \regex_replace_all:nnN { , } { ， } \l_tmpa_tl
    \regex_replace_all:nnN { : } { ： } \l_tmpa_tl
    \regex_replace_all:nnN { ! } { ！ } \l_tmpa_tl
    \regex_replace_all:nnN { \? } { ？ } \l_tmpa_tl
    \cs_gset_eq:cN { #1 } \l_tmpa_tl
}

% 中文符号->英文符号
\NewDocumentCommand\cumt@format@symbols@en@inplace{m}
{
    \tl_set:Nx \l_tmpa_tl { \tl_use:c { #1 } }
    \regex_replace_all:nnN { ； } { ; } \l_tmpa_tl
    \regex_replace_all:nnN { ， } { , } \l_tmpa_tl
    \regex_replace_all:nnN { 。 } { . } \l_tmpa_tl
    \regex_replace_all:nnN { ： } { : } \l_tmpa_tl
    \regex_replace_all:nnN { （ } { \( } \l_tmpa_tl
    \regex_replace_all:nnN { ） } { \) } \l_tmpa_tl
    \regex_replace_all:nnN { ！ } { ! } \l_tmpa_tl
    \regex_replace_all:nnN { ？ } { ? } \l_tmpa_tl
    \cs_gset_eq:cN { #1 } \l_tmpa_tl
}

% 原地替换
\NewDocumentCommand\cumt@replace@string@inplace{m m m}
{
    \tl_set:Nx \l_tmpa_tl { \tl_use:c { #1 } }
    \regex_replace_all:nnN { #2 } { #3 } \l_tmpa_tl
    \cs_gset_eq:cN { #1 } \l_tmpa_tl
}

% 格式化封面基金列表
\NewDocumentCommand\cumt@format@funding@list@inplace{m}
{
    \tl_set:Nx \l_tmpa_tl { \tl_use:c { #1 } }
    \regex_replace_all:nnN { [；;] } { = } \l_tmpa_tl
    \regex_replace_all:nnN { [,，] } {,{\ }} \l_tmpa_tl
    \seq_set_split:NnV \l_tmpa_seq { = } \l_tmpa_tl
    \tl_clear:N \l_tmpb_tl
    \seq_map_inline:Nn \l_tmpa_seq
    {
        \tl_put_right:Nn \l_tmpb_tl { ##1 \par }
    }
    \cs_gset_eq:cN { #1 } \l_tmpb_tl
}

% 将中文数字映射为阿拉伯数字
\NewDocumentCommand\cumt@format@digits@arabic@inplace{m}
{
    \tl_set:Nx \l_tmpa_tl { \tl_use:c { #1 } }
    \regex_replace_all:nnN { 一 } { 1 } \l_tmpa_tl
    \regex_replace_all:nnN { 二 } { 2 } \l_tmpa_tl
    \regex_replace_all:nnN { 三 } { 3 } \l_tmpa_tl
    \regex_replace_all:nnN { 四 } { 4 } \l_tmpa_tl
    \regex_replace_all:nnN { 五 } { 5 } \l_tmpa_tl
    \regex_replace_all:nnN { 六 } { 6 } \l_tmpa_tl
    \regex_replace_all:nnN { 七 } { 7 } \l_tmpa_tl
    \regex_replace_all:nnN { 八 } { 8 } \l_tmpa_tl
    \regex_replace_all:nnN { 九 } { 9 } \l_tmpa_tl
    \regex_replace_all:nnN { [〇零] } { 0 } \l_tmpa_tl

    \cs_gset_eq:cN { #1 } \l_tmpa_tl
}
\ExplSyntaxOff

\cumt@option@hook{title}{\title{\cumt@title}}
\cumt@option@hook{author}{\author{\cumt@author}}
\cumt@option@hook{year}{\cumt@format@digits@arabic@inplace{cumt@year}}
\cumt@option@hook{month}{\cumt@format@digits@arabic@inplace{cumt@month}}
\cumt@option@hook{funding}{
    \cumt@replace@string@inplace{cumt@funding}{;}{；}
    \gdef\cumt@funding@list{\cumt@funding}
    \cumt@format@funding@list@inplace{cumt@funding@list}
}
\cumt@option@hook{thesis-name}{
    \def\cumt@thesis@name@doctor{博士学位论文}
    \ifx\cumt@thesis@name@doctor\cumt@thesis@name@full
        \gdef\cumt@thesis@name@en{Dissertation}%
    \else
        \gdef\cumt@thesis@name@en{Thesis}%
    \fi
}
% 合并导师名称
\AtBeginDocument{%
    \ifx\cumt@cosupervisor@name\@empty
        \gdef\cumt@supervisor@name@merged{\cumt@supervisor@name}
        \gdef\cumt@supervisor@title@merged{\cumt@supervisor@title}
    \else
        \gdef\cumt@supervisor@name@merged{\cumt@supervisor@name、\cumt@cosupervisor@name}
        \gdef\cumt@supervisor@title@merged{\cumt@supervisor@title、\cumt@cosupervisor@title}
    \fi
}

% 处理选项
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

% CTexBook文档类. linespread = lineskip / baselineskip = 20bp / (12bp * 1.2) ≈ 1.39
\LoadClass[UTF8,a4paper,twoside,openany,onecolumn,zihao=-4,linespread=1.39,fontset=none]{ctexbook}[2022/07/14]

% 宏包冲突检查
\RequirePackage{filehook}
\newcommand\cumt@declare@package@conflict[2]{
    \AtBeginOfPackageFile*{#1}{%
        \@ifpackageloaded{#2}{%
            \cumt@raise@error{Package "#1" is incompatible with "#2"}%
        }{}%
    }%
    \AtBeginOfPackageFile*{#2}{%
        \@ifpackageloaded{#1}{%
            \cumt@raise@error{Package "#2" is incompatible with "#1"}%
        }{}%
    }%
}
\cumt@declare@package@conflict{biblatex}{bibunits}
\cumt@declare@package@conflict{biblatex}{chapterbib}
\cumt@declare@package@conflict{biblatex}{cite}
\cumt@declare@package@conflict{biblatex}{multibib}
\cumt@declare@package@conflict{biblatex}{natbib}
\cumt@declare@package@conflict{bibunits}{chapterbib}
\cumt@declare@package@conflict{bibunits}{multibib}
\cumt@declare@package@conflict{natbib}{cite}
\cumt@declare@package@conflict{subcaption}{subfigure}
\cumt@declare@package@conflict{fontspec}{mathspec}
\cumt@declare@package@conflict{geometry}{fullpage}
\cumt@declare@package@conflict{algorithm2e}{algorithm}
\cumt@declare@package@conflict{fancyhdr}{titleps}
\cumt@declare@package@conflict{inputenc}{fontenc}
\cumt@declare@package@conflict{beamer}{article}
\cumt@declare@package@conflict{listings}{minted}
\cumt@declare@package@conflict{graphicx}{epsfig}

% 宏包加载顺序检查
\newcommand\cumt@declare@package@order[2]{
    \AtBeginOfPackageFile*{#1}{%
        \@ifpackageloaded{#2}{%
            \cumt@raise@error{The "#1" package must be loaded before "#2"}%
        }{}%
    }%
}
\cumt@declare@package@order{memoir}{hyperref}
\cumt@declare@package@order{tocbibind}{hyperref}
\cumt@declare@package@order{footmisc}{hyperref}
\cumt@declare@package@order{endnotes}{hyperref}
\cumt@declare@package@order{titlesec}{hyperref}
\cumt@declare@package@order{tocloft}{hyperref}
\cumt@declare@package@order{babel}{hyperref}
\cumt@declare@package@order{hyperref}{cleveref}
\cumt@declare@package@order{hyperref}{glossaries}
\cumt@declare@package@order{hyperref}{glossaries-extra}
\cumt@declare@package@order{hyperref}{bookmark}
\cumt@declare@package@order{hyperref}{nameref}
\cumt@declare@package@order{hyperref}{zref}
\cumt@declare@package@order{fontspec}{unicode-math}
\cumt@declare@package@order{amsmath}{mathtools}
\cumt@declare@package@order{amsmath}{newtx}
\cumt@declare@package@order{inputenc}{fontenc}
\cumt@declare@package@order{graphicx}{tikz}
\cumt@declare@package@order{xcolor}{tikz}
\cumt@declare@package@order{geometry}{fancyhdr}

% 引入所需宏包
\RequirePackage{setspace} % 设置行距
\RequirePackage{graphicx} % 图形支持
\RequirePackage{subcaption} % 子图支持
\RequirePackage{array} % 表格单元格长度
\RequirePackage{longtable} % 长表格支持
\RequirePackage{makecell} % 表格单元格换行
\RequirePackage{float} % 浮动体控制
\RequirePackage{multirow} % 表格多行合并
\RequirePackage{booktabs} % 控制线宽
\RequirePackage[justification=centering]{caption} % 图表标题居中
\RequirePackage{bicaption} % 双语图表标题
\RequirePackage{colortbl} % 表格样式和颜色支持
\RequirePackage{tabularx} % 自动计算表格宽度
\RequirePackage[algochapter,linesnumbered,ruled,vlined]{algorithm2e} % 算法表
\RequirePackage{pifont} % 提供带圈的数字
\RequirePackage{amsmath} % 数学公式支持
\RequirePackage{amsthm} % 定理环境支持
\RequirePackage{newtxmath} % 设置数学字体为Times风格
\let\Bbbk\relax % newtxmath与amssymb均定义了\Bbbk
\RequirePackage{amssymb} % 数学符号支持
\RequirePackage{bm} % 公式中字母加粗
\RequirePackage{upgreek} % 大写希腊字母
\RequirePackage[
    backend=biber, % 使用 biber 后端
    style=gb7714-2015, % 引用样式
    abbreviate=true, % 缩写作者名
    maxnames=3, % 最大作者数
    minnames=3, % 最小作者数
    giveninits=true, % 使用作者名的缩写
    uniquename=init, % 唯一作者名处理
    doi=false, % 不显示 DOI
    url=false, % 不显示 URL
    isbn=false, % 不显示 ISBN
    defernumbers=true, % 延迟编号
    language=auto, % 自动语言检测
    autolang=other*, % 多语言支持
]{biblatex} % 引用
\RequirePackage[english]{babel} % 多语言支持
\RequirePackage{csquotes} % 引用样式
\RequirePackage[perpage]{footmisc} % 每页重置脚注编号
\RequirePackage[
    unicode=true, % 启用 Unicode 支持
    bookmarksnumbered=true, % 书签显示编号
    bookmarksopen=true, % 展开书签
    bookmarksopenlevel=3, % 展开书签到第 3 级
    breaklinks=true, % 允许链接换行
    plainpages=false, % 禁用纯页码模式
    pdfborder=0 0 0, % 去除链接边框
    pdfstartview=FitH, % PDF 打开时适合页面宽度
    colorlinks=true, % 启用彩色链接
    linkcolor=black, % 内部链接颜色
    urlcolor=black, % URL 链接颜色
    citecolor=black, % 引用链接颜色
    linktoc=all, % 目录中所有条目添加链接
]{hyperref}
\RequirePackage{xcolor} % 颜色支持
\RequirePackage{ifthen} % 条件判断
\RequirePackage{calc} % 提供计算功能，如 \minof{}{} 和 \widthof{}
\RequirePackage{microtype} % 微调排版
\RequirePackage{etoolbox} % 工具宏包
\RequirePackage{enumitem} % 自定义列表环境
\RequirePackage{lastpage} % 获取总页数
\RequirePackage{titletoc} % 自定义目录样式
\RequirePackage{fontspec}[2023/11/01] % 字体设置
\RequirePackage[normalem]{ulem} % 下划线和删除线
\RequirePackage[
    includeheadfoot, % 包含页眉和页脚
    left=3.17cm, % 左边距
    right=3.17cm, % 右边距
    top=0cm, % 上边距
    bottom=1.85cm, % 下边距
    headheight=2cm-0.5pt, % 页眉高度
    headsep=0.54cm, % 页眉与正文的间距
    footskip=2.54cm-1.85cm, % 页脚与正文的间距
]{geometry} % 页面
\RequirePackage{emptypage} % 空白页处理
\RequirePackage{indentfirst} % 段落首行缩进
\RequirePackage{fancyhdr} % 自定义页眉和页脚
\RequirePackage{listings} % 代码块支持
\RequirePackage{xpatch} % 补丁命令

% 矿大蓝 RGB:30,50,100 (#1e3264)
\definecolor{cumtblue}{RGB}{30,50,100}

% 行间距段间距
\setlength{\parskip}{0bp}

% 电子版/打印版
\def\cumt@output@print{print}
\newcommand\cumt@clearpage{
    \ifx\cumt@output@print\cumt@output
        \cleardoublepage
    \else
        \clearpage
    \fi
}

% 配置字体
\defaultCJKfontfeatures{}
\let\heiti\relax
\let\songti\relax
\setmainfont{Times New Roman}
\setsansfont{Verdana}
\setmonofont{Courier New}
\newfontfamily{\arial}[
    Path = Assets/Fonts/,
    UprightFont = Arial.ttf,
    BoldFont = Arial-Bold.ttf,
    ItalicFont = Arial-Italic.ttf,
    BoldItalicFont = Arial-Bold-Italic.ttf
]{Arial}
\newCJKfontfamily{\kaiti}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
]{SimKai.ttf}
\newCJKfontfamily{\huawenxingkai}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
]{STXingKai.ttf}
\newCJKfontfamily{\lishu}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
]{SimLi.ttf}
\newCJKfontfamily{\heiti}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
]{SimHei.ttf}
\newCJKfontfamily{\songti}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
]{SimSun.ttf}
\setCJKmainfont{SimSun.ttf}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
] % 中文默认字体
\setCJKfallbackfamilyfont{\CJKrmdefault}{SimSun-ExtB.ttf}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
] % ExtB
\setCJKsansfont{SimHei.ttf}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
] % 无衬线
\setCJKmonofont{FangSong.ttf}[
    Path = Assets/Fonts/,
    AutoFakeBold = 3,
    AutoFakeSlant = 0.2
] % 等宽
\xeCJKDeclareCharClass{CJK}{"2460 -> "2473} % 圆圈序号

% 页面样式
\renewcommand\chaptermark[1]{\markboth{\thechapter\hspace{0.5\ccwd}#1}{}}
\fancypagestyle{frontmatter}{%
    \fancyhf{}
    \pagenumbering{Roman}
    \fancyhead{}
    \fancyfoot{}
    \fancyhead[L]{}
    \fancyfoot[C]{\zihao{-5} \textbf{\thepage}}
    \renewcommand\footrulewidth{0pt}
    \renewcommand\headrulewidth{0pt}
}
\fancypagestyle{mainmatter}{% Main
    \fancyhf{}
    \pagenumbering{arabic}
    \fancyhead[OC]{\zihao{-5}\linespread{1}\leftmark}
    \fancyhead[EC]{\zihao{-5}\linespread{1}\cumt@thesis@name@full}
    \fancyhead[R]{}
    \fancyhead[L]{}
    \fancyfoot[C]{\zihao{-5} \textbf{\thepage}}
    \setlength\headwidth{\textwidth}
    \renewcommand\headrulewidth{0.5pt}
    \renewcommand\footrulewidth{0pt}
}
\fancypagestyle{backmatter}{%
    \fancyhf{}
    \fancyhead{}
    \fancyfoot{}
    \fancyhead[L]{}
    \fancyfoot[C]{\zihao{-5} \textbf{\thepage}}
    \renewcommand\footrulewidth{0pt}
    \renewcommand\headrulewidth{0pt}
}
\let\buildinpagestyle\pagestyle
\renewcommand\pagestyle[1]{%
    \def\@tmpstyle{#1}
    \def\@backmatter{backmatter}
    \ifx\@tmpstyle\@backmatter
        \cumt@clearpage
    \fi
    \buildinpagestyle{#1}
}

% 代码块
\lstset{
    basicstyle = \small\ttfamily,
    breaklines = true,
    showspaces = false,
    columns = fixed,
    morekeywords = {as},
    deletendkeywords = {compile}
}

% 脚注
\xpatchcmd\@makefntext
{{\hss\@makefnmark}}
{{\hss\@makefnmark@nosuperscript}}
{}{\fail}
\def\@makefnmark@nosuperscript{\lower -.0ex\hbox{\bfseries\@thefnmark\hspace{0.06ex}}}
\renewcommand\@makefnmark{\textsuperscript{\tiny\bfseries\@thefnmark}}
\newcommand\circledtext[1]{
    \ifnum\value{#1}<11\relax
        {\symbol{\numexpr\value{#1} + "245F\relax}}%
    \else
        \cumt@raise@error{Exceeding the maximum allowed number of footnotes (<=10), got \the\value{#1}}%
    \fi
}
\renewcommand\thefootnote{\circledtext{footnote}}
\renewcommand\footnotesize{\linespread{1}\zihao{-5}}
\setlength{\footnotemargin}{10bp}

% 公式编号
\renewcommand\theequation{\thechapter-\arabic{equation}}

% 图表格式
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.85}
\renewcommand{\floatpagefraction}{0.60}
\DeclareCaptionFont{cumtcaptionfont}{\zihao{5}}
\captionsetup{
    font           = cumtcaptionfont,
    labelsep       = space,
    skip           = 2bp,
    figureposition = bottom,
    tableposition  = top,
}
\captionsetup[figure][bi-first]{name=图}
\captionsetup[figure][bi-second]{name=Figure}
\captionsetup[table][bi-first]{name=表}
\captionsetup[table][bi-second]{name=Table}
\renewcommand\thetable{\arabic{chapter}-\arabic{table}}
\renewcommand\thefigure{\arabic{chapter}-\arabic{figure}}
\renewcommand\tabularxcolumn[1]{m{#1}<{\centering}}

% 表格样式
\definecolor{greentableline}{rgb}{.105,.410,.113} % 模板中的颜色
\let\buildintable\table
\let\buildinendtable\endtable
\renewenvironment{table}[1][]{%
    \buildintable[#1]%
    \zihao{5}%
}{%
    \buildinendtable
}

% 算法表格
\xapptocmd{\algorithm}{%
    \SetAlgorithmName{算法}{算法}{算法清单}%
    \SetAlCapSkip{2bp}%
    \SetAlCapFnt{\zihao{5}}%
    \SetAlCapNameFnt{\zihao{5}}%
    \SetAlgoCaptionSeparator{\unskip\hspace*{2em}}%
}{}{}

% 封面页
\newcommand\MakeCoverPage{
    \newgeometry{left=2.0cm,right=2.0cm,top=2.54cm,bottom=2.63cm}
    \vspace*{-8bp} % 与Word模板位置保持一致
    \hspace*{1.17cm}
    \begin{minipage}[t]{0.25\textwidth}
        \vspace{0bp} % 留着别动
        \includegraphics[width=3.26cm]{Assets/cumt-logo.pdf}
    \end{minipage}
    \hfill
    \ifx\cumt@funding@on@cover\@true
        \begin{minipage}[t]{0.5\textwidth}
            \vspace{5bp}
            {\heiti\zihao{5}\cumt@funding@list}
        \end{minipage}
    \fi
    \vspace{35bp}
    \begin{center}
        {\centering\zihao{-2}\cumt@thesis@name@full \par}
        \vspace{0bp}
        \parbox[c][7cm][c]{16.0cm}{
            {\centering\setstretch{1.2}\heiti\zihao{2}\cumt@title@cn\par}
                {\centering\setstretch{1.2}\zihao{2}\cumt@title@en\par}
        }
        \vspace{1.2cm}
        \begin{table}[h]
            \renewcommand\arraystretch{1.5}
            \centering
            \setlength{\tabcolsep}{-2bp}
            \begin{tabular}{>{\raggedleft}p{0.35\textwidth}<{}p{0.35\textwidth}}
                {\zihao{-3} \makebox[2.24cm]{作 \hfill 者：}} & {\zihao{-3} \cumt@author}                                     \\
                {\zihao{-3} \makebox[2.24cm]{导 \hfill 师：}} & {\zihao{-3} \cumt@supervisor@name~\cumt@supervisor@title}     \\
                \makebox[2.24cm]{}                         & {\zihao{-3} \cumt@cosupervisor@name~\cumt@cosupervisor@title} \\
            \end{tabular}
        \end{table}
        \vfill
        {\centering\kaiti\zihao{-2} 中国矿业大学 \par \vspace{10bp} \zhdigits{\cumt@year}年\zhnumber{\cumt@month}月 \par}

        \vspace*{1.3cm}
    \end{center}

    \cumt@clearpage
    \restoregeometry
}

% 使用授权声明页
\newcommand\MakeCopyrightPage{
    \vspace*{30bp}
    {\centering\linespread{1}\zihao{-2}\heiti\bfseries 学位论文使用授权声明\par}
    \vspace{5bp}
    {\kaiti
        \setlength{\baselineskip}{20bp} % 固定行间距20磅
        本人完全了解中国矿业大学有关保留、使用学位论文的规定，同意本人所撰写的学位论文的使用授权按照学校的管理规定处理：\par
        作为申请学位的条件之一，学位论文著作权拥有者须授权所在学校拥有学位论文的部分使用权，即：\ding{172}学校档案馆和图书馆有权保留学位论文的纸质版和电子版，可以使用影印、缩印或扫描等复制手段保存和汇编学位论文；\ding{173}为教学和科研目的，学校档案馆和图书馆可以将公开的学位论文作为资料在档案馆、图书馆等场所或在校园网上供校内师生阅读、浏览。另外，根据有关法规，同意中国国家图书馆保存研究生学位论文。\par
        （保密的学位论文在解密后适用本授权书）。\par
    }
    \vspace{40bp}
    作者签名：\hspace{14.5em} 导师签名： \par
    \hspace{2.5em}年\hspace{1.5em}月\hspace{1.5em}日\hspace{14em}年\hspace{1.5em}月\hspace{1.5em}日

    \cumt@clearpage
}

% 扉页
\newcommand\MakeTitlePage{
{   
    \newgeometry{left=2.0cm,right=2.0cm,top=2.54cm,bottom=2.63cm}
    \begin{center}
        \begin{tabularx}{16.83cm}{|X|}
            \hline\hbadness=10000 % FIXME
            \parbox[c][2.2cm][c]{16.0cm}{
                \renewcommand\arraystretch{1.3}
                {
                    \zihao{4}
                    \begin{tabularx}{16.0cm}{XX}
                        \hspace{-1cm}{中图分类号}\uline{\makebox[3.8cm]{\centering \cumt@clc}} & \makebox[2cm]{学 \hfill 校 \hfill 代 \hfill 码}\uline{\makebox[4cm]{\centering 10290 }} \\
                        \hspace{-1cm}\hspace{0.3cm}UDC\uline{\makebox[5.0cm]{\centering \cumt@udc}} & \makebox[2cm]{密 \hfill 级}\uline{\makebox[4cm]{\centering \cumt@security@level }}
                    \end{tabularx}
                }
            } \\
            \parbox[c][6cm][c]{16.0cm}{
                {\centering\huawenxingkai\zihao{1} 中国矿业大学 \par}
                    {\centering\lishu\zihao{1} \cumt@thesis@name@full \par}
            } \\
            \vspace{0bp}
            \parbox[c][6cm][c]{16.0cm}{
                {\centering\setstretch{1.2}\heiti\zihao{2}\cumt@title@cn\par}
                    {\centering\setstretch{1.2}\zihao{2}\cumt@title@en\par}
            } \\
            \vspace{0.5cm}
            \parbox[c][7cm][c]{16.0cm}{
                \heiti\zihao{4}
                \renewcommand\arraystretch{1.3}
                \begin{tabularx}{16.0cm}{XX}
                    \makebox[2cm]{作 \hfill 者}\uline{\makebox[5cm]{\resizebox{\minof{4.8cm}{\widthof{\cumt@author}}}{!}{\centering \cumt@author}}} & \makebox[2cm]{导 \hfill 师} \uline{\makebox[5cm]{\resizebox{\minof{4.8cm}{\widthof{\cumt@supervisor@name@merged}}}{!}{\centering \cumt@supervisor@name@merged}}} \\
                    \makebox[2cm]{申 \hfill 请 \hfill 学 \hfill 位}\uline{\makebox[5cm]{\resizebox{\minof{4.8cm}{\widthof{\cumt@degree@applied}}}{!}{\centering \cumt@degree@applied}}} & \makebox[2cm]{培 \hfill 养 \hfill 单 \hfill 位} \uline{\makebox[5cm]{\resizebox{\minof{4.8cm}{\widthof{\cumt@affiliation}}}{!}{\centering \cumt@affiliation }}} \\
                    \makebox[2cm]{学 \hfill 科 \hfill 专 \hfill 业}\uline{\makebox[5cm]{\resizebox{\minof{4.8cm}{\widthof{\cumt@major}}}{!}{\centering \cumt@major}}} & \makebox[2cm]{研 \hfill 究 \hfill 方 \hfill 向} \uline{\makebox[5cm]{\resizebox{\minof{4.8cm}{\widthof{\cumt@field}}}{!}{\centering \cumt@field }}} \\
                    \makebox[3.4cm]{答辩委员会主席}\uline{\makebox[3.6cm]{\centering \cumt@defense@committee@chair}} & \makebox[2cm]{评 \hfill 阅 \hfill 人} \uline{\makebox[5cm]{\centering\cumt@reviewer}} \\
                \end{tabularx}
            } \\

            \parbox[c][2.5cm][c]{16.0cm}{
                {\centering\heiti\zihao{4}\zhdigits{\cumt@year}年\zhnumber{\cumt@month}月\par}
            } \\
            \hline
        \end{tabularx}
    \end{center}
    \cumt@clearpage
    \restoregeometry}
}

% 致谢
\newenvironment{acknowledgements}{%
    \newpage
    \vspace*{-10bp}
    {\centering\linespread{1}\zihao{-2}\heiti\bfseries 致谢\par}
    \vspace{6bp}
    \kaiti\zihao{-4}\setlength{\baselineskip}{20bp}
}
{%
    \cumt@clearpage
}

\newcommand\cnkeywords[1]{
    \gdef\@cnkeywords{#1}
    \cumt@format@symbols@cn@inplace{@cnkeywords} %
    \hangafter 1
        {\noindent \textbf{关键词：}}
    \hangindent 3.9em
    \@cnkeywords
}

\newcommand\enkeywords[1]{
    \gdef\@enkeywords{#1}
    \cumt@format@symbols@en@inplace{@enkeywords} %
    \hangafter 1
        {\noindent \textbf{Keywords:~}}
    \hangindent 5.4em
    \@enkeywords
}

% 中文摘要环境
\newenvironment{cnabstract}{%
    % 中文
    \newpage
    \vspace*{-10bp}
    {\centering\linespread{1}\zihao{-2}\heiti\bfseries 摘\quad 要\par}
    \vspace{12bp}

    \phantomsection
    \addcontentsline{toc}{chapter}{摘要}
    \par

    \sloppy
    \zihao{-4}\setlength{\baselineskip}{20bp}
}{% 
    \cumt@clearpage
}


% 英文摘要
\newenvironment{enabstract}{%
    \newpage
    \vspace*{-10bp}
    {\centering\linespread{1}\zihao{-2}\arial\bfseries Abstract\par}
    \vspace{12bp}

    \phantomsection
    \addcontentsline{toe}{chapter}{Abstract}
    \par

    \sloppy
    \zihao{-4}\setlength{\baselineskip}{20bp}
}{%
    \cumt@clearpage
}

% 中英文目录格式
\titlecontents{chapter}
[\z@]
{\zihao{-4}\setlength{\baselineskip}{20bp}\bfseries}
{\contentspush{\thecontentslabel\hspace{0.5\ccwd}}}
{}
{\titlerule*[3bp]{$\boldsymbol{\cdot}$}\contentspage}
[\vskip 1.8bp]
% 
\titlecontents{section}
[\z@]
{\zihao{-4}\setlength{\baselineskip}{20bp}}
{\contentspush{\thecontentslabel\hspace{0.5\ccwd}}}
{}
{\titlerule*[3bp]{$\cdot$}\contentspage}
[\vskip 1.8bp]

% 中文目录
\setcounter{tocdepth}{1}  % 目录显示深度到二级标题(section)
\newcommand\MakeCnContents{
    \newpage
    \vspace*{-10bp}
    {\centering\linespread{1}\zihao{-2}\heiti\bfseries 目\quad 录\par}
    \vspace{12bp}

    \phantomsection
    \addcontentsline{toc}{chapter}{目录}

    \@starttoc{toc}

    \cumt@clearpage
}

% 英文目录
\newcommand\MakeEnContents{%
    \newpage
    \vspace*{-10bp}
    {\centering\linespread{1}\zihao{-2}\arial\bfseries Contents\par}
    \vspace{12bp}

    \phantomsection
    \addcontentsline{toe}{chapter}{Contents}

    \@starttoc{toe}

    \cumt@clearpage
}

\ExplSyntaxOn
% 图、表清单
\bool_new:N \l_enfigcaption_bool
\bool_set_true:N \l_enfigcaption_bool
\tl_new:N \g_listoffigures_storelines_tl

\bool_new:N \l_entabcaption_bool
\bool_set_true:N \l_entabcaption_bool
\tl_new:N \g_listoftables_storelines_tl

\NewDocumentCommand\cumt@list@figures@line@name{ m m }
{
    \bool_if:NTF \l_enfigcaption_bool
    {
        \tl_set:Nn \l_tmpa_tl { 图~#1 }
        \bool_set_false:N \l_enfigcaption_bool
    }
    {
        \tl_set:Nn \l_tmpa_tl { Figure~#1 }
        \bool_set_true:N \l_enfigcaption_bool
    }
    \tl_set:Nn \l_tmpb_tl { #2 }
}

\NewDocumentCommand\cumt@list@tables@line@name{ m m }
{
    \bool_if:NTF \l_entabcaption_bool
    {
        \tl_set:Nn \l_tmpa_tl { 表~#1 }
        \bool_set_false:N \l_entabcaption_bool
    }
    {
        \tl_set:Nn \l_tmpa_tl { Table~#1 }
        \bool_set_true:N \l_entabcaption_bool
    }
    \tl_set:Nn \l_tmpb_tl { #2 }
}

\NewDocumentCommand\cumt@list@entries@of{m}
{
    \str_if_eq:nnT { #1 } { figure }
    {
        \tl_use:N \g_listoffigures_storelines_tl
    }
    \str_if_eq:nnT { #1 } { table }
    {
        \tl_use:N \g_listoftables_storelines_tl
    }
}

\NewDocumentCommand\cumt@list@line{ m m m m }
{
    \str_if_eq:nnT { #1 } { figure }
    {
        #2
        \tl_gput_right:Nx \g_listoffigures_storelines_tl
        {
            \exp_not:V \l_tmpa_tl \exp_not:N &
            \exp_not:V \l_tmpb_tl \exp_not:N &
            \exp_not:n { #3 \\ \hline }
        }
    }
    \str_if_eq:nnT { #1 } { table }
    {
        #2
        \tl_gput_right:Nx \g_listoftables_storelines_tl
        {
            \exp_not:V \l_tmpa_tl \exp_not:N &
            \exp_not:V \l_tmpb_tl \exp_not:N &
            \exp_not:n { #3 \\ \hline }
        }
    }
}

\newcolumntype{C}[1]{>{\centering\arraybackslash}m{\dimexpr #1 \relax}}

\str_if_exist:NF \l_tmpa_str { \str_new:N \l_tmpa_str }
\str_if_exist:NF \l_tmpb_str { \str_new:N \l_tmpb_str }
\str_if_exist:NF \l_tmpc_str { \str_new:N \l_tmpc_str }

\NewDocumentCommand\cumt@list@of{ m }
{
    \str_case:nnF { #1 }
    {
        { figure }
            {
                \str_set:Nn \l_tmpa_str { 图 }
                \str_set:Nn \l_tmpb_str { Figures }
                \str_set:Nn \l_tmpc_str { lof }
            }
            { table }
            {
                \str_set:Nn \l_tmpa_str { 表 }
                \str_set:Nn \l_tmpb_str { Tables }
                \str_set:Nn \l_tmpc_str { lot }
            }
    }
    {
        \msg_error:nnn { MakeListOf } { invalid-type } { #1 }
    }

    % 生成清单
    \newpage
    \vspace*{-6bp}
    {
        \centering
        \linespread{1}
        \zihao{-2}
        \heiti
        \bfseries
        \l_tmpa_str 清单
        \par
    }
    \phantomsection
    \addcontentsline{toc}{chapter}{\l_tmpa_str 清单}
    \addcontentsline{toe}{chapter}{List~of~\l_tmpb_str}

    \group_begin:

    % 设置 \contentsline 和 \numberline
    \cs_set_eq:NN \contentsline \cumt@list@line
    \str_if_eq:nnTF { #1 } { figure }
    {
        \cs_set_eq:NN \numberline \cumt@list@figures@line@name
    }
    {
        \str_if_eq:nnTF { #1 } { table }
        {
            \cs_set_eq:NN \numberline \cumt@list@tables@line@name
        }
        {
            \cumt@raise@error{Only~support~"table"~and~"figure",~got~"#1"}
        }
    }

    \cs_set_eq:NN \addvspace \use_none:n

    \@starttoc{\l_tmpc_str}

    \zihao{5}
    \setlength{\tabcolsep}{0bp}
    \begin{center}
        \begin{longtable}{@{}|C{2.34cm}|C{\textwidth-2.34cm-1.25cm-4\arrayrulewidth}|C{1.25cm}|@{}}
            \hline
            \l_tmpa_str 序号 & \l_tmpa_str 名称 & 页码 \\ \hline\endhead
            \cumt@list@entries@of{#1}
        \end{longtable}
    \end{center}
    \group_end:

    \setcounter{table}{0}

    \cumt@clearpage
}
\ExplSyntaxOff

% 生成图清单
\newcommand\MakeListOfFigures{%
    \cumt@list@of{figure}
}

% 生成表清单
\newcommand\MakeListOfTables{%
    \cumt@list@of{table}
}

% 变量注释表环境
\newenvironment{denotation}{%
    \newpage
    \vspace*{-6bp}
    {\centering\linespread{1}\zihao{-2}\heiti\bfseries 变量注释表\par}

    \phantomsection
    \addcontentsline{toc}{chapter}{变量注释表}
    \addcontentsline{toe}{chapter}{List of Variables}

    \vspace{-10bp}
    \zihao{5}
    \begin{center}
        \begin{longtable}{@{}|p{3.5cm}|p{\textwidth-3.5cm-4\tabcolsep-3\arrayrulewidth}|@{}}
            \hline
            }
            {% 
        \end{longtable}
    \end{center}
    \cumt@clearpage
}

% 添加一个变量
\newcommand\Variable[2]{
    #1 & #2 \\ \hline
}

% 参考文献
\newcommand\MakeReferencePage{
    \vspace*{0bp}
    {\centering\linespread{1}\zihao{-2}\heiti\bfseries 参考文献\par}
    \phantomsection
    \addcontentsline{toc}{chapter}{参考文献}
    \addcontentsline{toe}{chapter}{References}
    \vspace*{-6bp}
    \setlength{\bibhang}{0bp}
    \setlength{\bibitemsep}{0bp}
    \renewcommand\bibfont{\zihao{5}}
    \begingroup
    \setstretch{1.667} % 约为20bp
    \printbibliography[heading=none]
    \endgroup
    \cumt@clearpage
}

% 附录
\let\appendix\relax
\newcounter{appendixnum}
\newenvironment{appendix}{%
    \newpage
    \stepcounter{appendixnum}

    \phantomsection
    \addcontentsline{toc}{chapter}{附录~\theappendixnum}
    \addcontentsline{toe}{chapter}{Appendix~\theappendixnum}

    \chapter*{\hspace*{\fill}附录~\theappendixnum\hspace*{\fill}}
    \vspace{12bp}
    \zihao{5}
}
{%
    \cumt@clearpage
}

% 作者简历
\newenvironment{resume}{%
    \newpage
    \phantomsection
    \addcontentsline{toc}{chapter}{作者简历}
    \addcontentsline{toe}{chapter}{Author's Resume}
    \chapter*{\hspace*{\fill}作者简历\hspace*{\fill}}
    \vspace{12bp}
    \makeatletter
    \newcounter{resumesectionnum}
    \newcommand\resumesection[1]{% 
        \stepcounter{resumesectionnum}% 计数
        \noindent {\heiti\zihao{-3} \textbf{\zhdigits{\theresumesectionnum}} 、 ##1} \par
    }
    \zihao{5}
}
{%
    \makeatother
    \cumt@clearpage
}

% 原创声明
\newcommand\MakeDeclarationPage{
    \newpage
    \makeatletter
    \phantomsection
    \addcontentsline{toc}{chapter}{论文原创性声明}
    \addcontentsline{toe}{chapter}{Declaration of \cumt@thesis@name@en \ Originality}
    \chapter*{\hspace*{\fill}学位论文原创性声明\hspace*{\fill}}
     {
      \kaiti\zihao{-4}\setlength{\baselineskip}{20bp}
      \vspace{11bp}
      本人郑重声明：所呈交的学位论文《 \cumt@title@cn 》，是本人在导师指导下，在中国矿业大学攻读学位期间进行的研究工作所取得的成果。据我所知，除文中已经标明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的研究成果。对本文的研究做出贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。
     }
    \makeatother

    \vspace{24bp}

    {\zihao{-4} \hspace{0.44\textwidth} 学位论文作者签名：} \par
    {\zihao{-4} \hspace{0.55\textwidth} 年 \qquad 月 \qquad 日}

    \cumt@clearpage
}

\newcommand\FormatCheckbox[2]{%
    \edef\cumt@tmpa{#1}
    \edef\cumt@tmpb{#2}
    \ifx\cumt@tmpa\cumt@tmpb%
        \hspace{0.02em}\checkmark\hspace{0.02em}
    \else
        \hspace{0.8em}%
    \fi
}

% 论文数据集
\newcommand\MakeDataCollectionPage{
    \newpage
    \newgeometry{left=1.5cm,right=1.5cm,top=2.54cm,bottom=2.54cm}
    \fancyhfoffset[L]{1.5cm}
    \fancyhfoffset[R]{1.5cm}
    \makeatletter
    \phantomsection
    \addcontentsline{toc}{chapter}{学位论文数据集}
    \addcontentsline{toe}{chapter}{\cumt@thesis@name@en \ Data Collection}
    \chapter*{\hspace*{\fill}学位论文数据集\hspace*{\fill}}

    \renewcommand\arraystretch{1.4}
    \begin{center}
        {
        \renewcommand\tabularxcolumn[1]{m{##1}<{\centering}} %更改X列格式
        \centering
        \vskip 12bp
        \arrayrulecolor{black}
        {
            %\renewcommand\arraystretch{1.3}
            \zihao{5}
            \begin{tabularx}{15.05cm}{|m{2.0cm}<{\centering}|m{1.3cm}<{\centering}|m{2.5cm}<{\centering}|m{1.3cm}<{\centering}|X|}
                \hline
                {\bfseries 关键词$\bm \ast$} & {\bfseries 密级$\bm \ast$} & {\bfseries 中图分类号$\bm \ast$} & {\bfseries UDC} & {\bfseries 论文资助} \\ \hline
                {\@cnkeywords}            & {\cumt@security@level}   & {\cumt@clc}                 & {\cumt@udc}     & {\cumt@funding}  \\ \hline
            \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|X|X|X|X|}
            \hline
            {\bfseries 学位授予单位名称$\bm \ast$} & {\bfseries 学位授予单位代码$\bm \ast$} & {\bfseries 学位类别$\bm \ast$} & {\bfseries 学位级别$\bm \ast$} \\ \hline
            中国矿业大学                         & 10290                          & {\cumt@degree@category}    & {\cumt@degree@level}       \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|X|X|m{4cm}<{\centering}|}
            \hline
            {\bfseries 论文题目 $\bm \ast$} & {\bfseries 并列题目$\bm \ast$} & {\bfseries 论文语种$\bm \ast$} \\ \hline
            {\cumt@title@cn}            & {\cumt@title@en}           & {\cumt@language}           \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|X|X|X|X|}
            \hline
            {\bfseries 作者姓名$\bm \ast$}   & { \cumt@author }             & {\bfseries 学号$\bm \ast$} & {\cumt@student@id}          \\\hline
            {\bfseries 培养单位名称$\bm \ast$} & {\bfseries 培养单位代码$\bm \ast$} & {\bfseries 培养单位地址}       & {\bfseries 邮编}              \\\hline
            中国矿业大学                       & 10290                        & 江苏省徐州市                   & 221116                      \\ \hline
            {\bfseries 学科专业$\bm \ast$}   & {\bfseries 研究方向$\bm \ast$}   & {\bfseries 学制$\bm \ast$} & {\bfseries 学位授予年$\bm \ast$} \\ \hline
            { \cumt@major }              & { \cumt@field }              & {\cumt@program@duration} & {\cumt@year}                \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|p{6cm}<{\centering}|X|}
            \hline
            {\bfseries 论文提交日期$\bm \ast$} & {\cumt@year 年 \cumt@month 月} \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|X|X|X|X|}
            \hline
            {\bfseries 导师姓名$\bm \ast$} & {\cumt@supervisor@name@merged} & {\bfseries 职称$\bm \ast$} & {  \cumt@supervisor@title@merged  } \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|p{4cm}<{\centering}|p{3.2cm}<{\centering}|X|}
            \hline
            {\bfseries 评阅人} & {\bfseries 答辩委员会主席$\bm \ast$} & {\bfseries 答辩委员会成员}\\ \hline
            {\cumt@reviewer} & {\cumt@defense@committee@chair} & {\cumt@defense@committee@members} \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|X|}
            \hline
            {
                \bfseries
                % \makecell[l]{\cumt@electronic@thesis@format@cell}
                \makecell[l]{%
                    电子版论文提交格式 \hspace{2\ccwd}%
                    文本（\FormatCheckbox{\cumt@electronic@thesis@format}{文本}）\ %
                    图像（\FormatCheckbox{\cumt@electronic@thesis@format}{图像}）\ %
                    视频（\FormatCheckbox{\cumt@electronic@thesis@format}{视频}）\ %
                    音频（\FormatCheckbox{\cumt@electronic@thesis@format}{音频}）\ %
            多媒体（\FormatCheckbox{\cumt@electronic@thesis@format}{多媒体}）  \\
            \hspace{11\ccwd} 其他（\FormatCheckbox{\cumt@electronic@thesis@format}{其他}） \\
                    推荐格式：application/msword; application/pdf%
                }
            } \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|X|X|X|}
            \hline
            {\bfseries 电子版论文出版（发布）者} & {\bfseries 电子版论文出版（发布）地} & {\bfseries 权限声明} \\ \hline
            {\cumt@electronic@thesis@publisher} & {\cumt@electronic@thesis@publisher@location} & {\cumt@permission@statement} \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        %\renewcommand\arraystretch{1.3}
        \zihao{5}
        \begin{tabularx}{15.05cm}{|p{6cm}<{\centering}|X|}
            \hline
            {\bfseries 论文总页数$\bm \ast$} & { \pageref{LastPage} } \\
            \hline
        \end{tabularx}
        }
        \vskip -1.4pt
        {
        \renewcommand\tabularxcolumn[1]{m{##1}<{\raggedright}} %更改X列格式
        \renewcommand\arraystretch{1}
        \zihao{5}
        \begin{tabularx}{15.05cm}{| X |}
            \hline
            {\bfseries 注：共33项，其中带$\bm \ast$为必填数据，共22项。} \\
            \hline
        \end{tabularx}
        }

        }
    \end{center}
    \restoregeometry
    \makeatother
}

% Ai
\renewcommand\AA{\text{Å}}

% 各级标题
\ctexset{
    % 一级标题[章]（中文黑体，数字Times New Roman，小二加粗，单倍行距，段前6磅，段后0磅；两端对齐，大纲1级，编号与标题之间留一个空格）
    chapter = {
      name       = {,},
      format     = \linespread{1}\zihao{-2}\heiti\bfseries\raggedright,
      indent     = 0bp,
      number     = \arabic{chapter},
      aftername  = \hspace{0.5\ccwd},
      beforeskip = 13bp,
      afterskip  = 0bp,
      pagestyle  = fancy,
      runin      = false,
      fixskip     = true,
     },
    % 二级标题[节]（中文黑体，数字英文Times New Roman，小三号，行距固定值20磅，段前6磅，段后6磅；两端对齐，大纲2级，编号与标题之间留一个空格）
    section = {
      format     = \setlength{\baselineskip}{20bp}\zihao{-3}\heiti\raggedright,
      indent     = 0bp,
      aftername  = \hspace{0.5\ccwd},
      beforeskip = 2bp,
      afterskip  = 6bp,
      runin      = false,
     },
    %
    % 三级标题[小节]（中文黑体，数字Times New Roman，四号，行距固定值20磅，段前6磅，段后6磅；两端对齐，大纲3级，编号与标题之间留一个空格；三级标题不需要翻译成英文）
    subsection = {
            format     = \setlength{\baselineskip}{20bp}\zihao{4}\heiti\raggedright,
            indent     = 0bp,
            aftername  = \hspace{0.5\ccwd},
            beforeskip = 2bp,
            afterskip  = 6bp,
            runin      = false,
        },
    %
    % 四级标题[次小节]（《撰写规定》无明确要求）（中文黑体，数字Times New Roman，小四号，行距固定值20磅，段前6磅，段后6磅；两端对齐，大纲4级，编号与标题之间留一个空格）
    subsubsection = {
            format     = \setlength{\baselineskip}{20bp}\zihao{-4}\heiti\raggedright,
            indent     = 0bp,
            aftername  = \hspace{0.5\ccwd},
            beforeskip = 2bp,
            afterskip  = 6bp,
            runin      = false,
        },
    % 五级标题[段落]（《撰写规定》无明确要求）（中文宋体，数字Times New Roman，小四号，行距固定值20磅，段前0磅，段后0磅；两端对齐，大纲5级，编号与标题之间留一个空格）
    paragraph = {
            format     = \setlength{\baselineskip}{20bp}\zihao{-4}\songti\bfseries\raggedright,
            number     = \hspace*{-0.4em}（\arabic{paragraph}）,
            aftername  = \hspace{0bp},
            indent     = 2\ccwd,
            beforeskip = 0bp,
            afterskip  = 0bp,
            runin      = true,
        },
    % 六级标题[小段]（《撰写规定》无明确要求）（中文宋体，数字Times New Roman，小四号，行距固定值20磅，段前0磅，段后0磅；两端对齐，大纲6级，编号与标题之间留一个空格）
    subparagraph = {
            format     = \setlength{\baselineskip}{20bp}\zihao{-4}\songti\bfseries\raggedright,
            number     = \circledtext{subparagraph},
            aftername  = \hspace{0.1em},
            indent     = 2\ccwd,
            beforeskip = 0bp,
            afterskip  = 0bp,
            runin      = true,
        },
}

% 标题编号深度
\setcounter{secnumdepth}{5}
% \chapter：章（第0级）
% \section：节（第1级）
% \subsection：子节（第2级）
% \subsubsection：次子节（第3级）
% \paragraph：段落（第4级）
% \subparagraph：子段落（第5级）
\newcommand\cumt@contents@add@line@numbered@en[2]{%
    \addcontentsline{toe}{#1}{\protect\numberline{\csname the#1\endcsname}#2}
}
\newcommand\bichapter[2]{
    \newpage
    \chapter{#1}
    \vspace*{3.3ex}
    {\linespread{1}\zihao{-2}\heiti\bfseries\raggedright\thechapter\hspace{0.5\ccwd}#2\par}
    \vspace{4bp}
    \cumt@contents@add@line@numbered@en{chapter}{#2}
}
\newcommand\bisection[2]{
    \section[#1]{#1（#2） }%
    \cumt@contents@add@line@numbered@en{section}{#2}
}
\let\buildinparagraph\paragraph
\RenewDocumentCommand\paragraph{s m}{%
    \IfBooleanTF{#1}
    {%
        \ctexset{paragraph/runin = false}
        \buildinparagraph{#2}
        \ctexset{paragraph/runin = true}
    }
    {% 
        \buildinparagraph{#2}
    }
}
\let\buildinsubparagraph\subparagraph
\RenewDocumentCommand\subparagraph{s m}{%
    \IfBooleanTF{#1}
    {%
        \ctexset{subparagraph/runin = false}
        \buildinsubparagraph{#2}
        \ctexset{subparagraph/runin = true}
    }
    {%
        \buildinsubparagraph{#2}
    }

}