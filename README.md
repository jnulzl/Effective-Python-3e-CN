# Effective Python, 3e（AI翻译版 · LaTeX 工程）

把 Brett Slatkin 的 *Effective Python: 125 Specific Ways to Write Better Python, Third Edition*
（Addison-Wesley, 2025）全书 125 个条目逐条译为中文，并套用 Manning 风格的 LaTeX 书籍模板
（取自 `D:\Ego\trans\Mastering the C++17 STL\latex_source`）重排出可编译的成品。

- 原书：*Effective Python, 3rd Edition — 125 Specific Ways to Write Better Python*
- 作者：Brett Slatkin（effectivepython.com）
- 出版：Addison-Wesley / Pearson，2025，ISBN 978-0-13-817218-3
- 中文名：**高效 Python（第 3 版）：写出更好 Python 代码的 125 个具体建议**

---

## 成品概览

| 项目 | 数值 |
|---|---|
| PDF 页数 | 584 页 = 封面 3 页（原书封面 / 中文重绘封面 / 中文内封）+ 目录 10 页 + 正文 560 页 + 索引 11 页 |
| 正文 | 14 章 / 125 个 Item（每个 Item 均含「需要记住的要点」小结） |
| 小节 | 173 个 `\subsection` |
| 代码块 | 1390 个 `codebox`（minted 高亮，Manning 配色） |
| 列表项 | 518 条 |
| 索引 | 565 条词条，按拼音 A–Z 分组、双栏点线，页码为真实页级页码 |

页面尺寸取自原书正文页实测：**531.36bp × 628.83bp**（7.38in × 8.73in），版心宽 375bp。

### 章节与条目分布

| 章 | 标题 | Item 范围 | 条数 |
|---|---|---|---|
| 1 | Pythonic 思维 | 1–9 | 9 |
| 2 | 字符串与切片 | 10–16 | 7 |
| 3 | 循环与迭代器 | 17–24 | 8 |
| 4 | 字典 | 25–29 | 5 |
| 5 | 函数 | 30–39 | 10 |
| 6 | 推导式与生成器 | 40–47 | 8 |
| 7 | 类与接口 | 48–57 | 10 |
| 8 | 元类与属性 | 58–66 | 9 |
| 9 | 并发与并行 | 67–79 | 13 |
| 10 | 健壮性 | 80–91 | 12 |
| 11 | 性能 | 92–99 | 8 |
| 12 | 数据结构与算法 | 100–107 | 8 |
| 13 | 测试与调试 | 108–115 | 8 |
| 14 | 协作 | 116–125 | 10 |

---

## 目录结构

```
Effective Python/                     # 项目根
├── Effective Python, 3e ... .pdf     # 原书 PDF（提取源，不参与编译）
│
├── latex_source/                     # ★ LaTeX 工程（编译入口；本 README 就在这里）
│   ├── README.md                     #   ← 本文件
│   ├── main.tex                      # \input{book/ccs.tex} + \subfile{book/index.tex}
│   ├── build.bat                     # 一键编译（三遍 xelatex + 清理 minted 缓存）
│   ├── main.pdf                      # 编译成品
│   ├── fonts/                        # JetBrains Mono（等宽备份字体）
│   ├── images/
│   │   └── cover.jpg                 # 原书封面（从原版 PDF 第 1 页抽出的内嵌图，1400×1826）
│   └── book/
│       ├── ccs.tex                   # 导言区：页面/字体/自定义命令环境/minted v3 缓存配置
│       ├── index.tex                 # 章节装配（前置页、14 章、索引；增删章节改这里）
│       ├── manning-pygments-style.tex# 代码高亮配色
│       └── content/
│           ├── front/                # 00-cover（原书封面）/ 00-cover-cn（中文重绘封面）
│           │                         #   / 00-title（中文内封）/ 01-preface
│           │                         #   / 02-acknowledgments / 03-author
│           ├── main/                 # 第 1–14 章（main/01.tex … 14.tex）
│           └── back/00-index.tex     # 书末索引（由 work/gen_index.py 生成，勿手改）
│
└── work/                             # 翻译流水线（不参与编译）
    ├── TRANSLATION_GUIDE.md          # ★ 翻译规范：输出格式、LaTeX 命令对照、术语表
    ├── chapters/                     # 提取出的源文片段（143 个，按 [section]/[code]/[body] 打标签）
    ├── trans/                        # 译文片段（142 个 X.txt.tex，由子代理产出）
    ├── index_chunks/                 # 原书索引词条（terms_1..6.tsv，已英→中）
    └── *.py                          # 流水线脚本（见下节）
```

---

## 环境依赖

| 依赖 | 版本 / 说明 |
|---|---|
| TeX Live | 2026（`xelatex`、minted **v3.8** / `latexminted`、tcolorbox、tikz、geometry、fancyhdr） |
| Python | 3.x（`latexminted` 需要可用的 `python.exe`；本机用 `D:\anaconda3`） |
| 中文字体 | **Source Han Serif SC（思源宋体，正文）**、**Microsoft YaHei（微软雅黑，标题与代码注释）** |
| 拉丁字体 | Cambria（正文）、Franklin Gothic Medium（标题）、Consolas（等宽） |
| 等宽备份 | `latex_source/fonts/JetBrainsMonoNL-*.ttf`，可替换 Consolas |

> 字体缺失会直接报 "font not found"；思源宋体与微软雅黑需在本机已安装。
> 页面尺寸与边距集中在 `ccs.tex` 开头那段 `geometry`，注释里写清了每个值对应原书的哪条实测线。

---

## 编译

### 方式 A：命令行（推荐）

在本目录（`latex_source/`）下执行。**关键**是把 minted v3 的缓存目录指向工程绝对根（见「已知坑」第 1 条）：

```bash
# 1) Python 根目录要排在 TeX bin 之前，避免 latexminted 被其它副本遮蔽
export PATH="/d/anaconda3:/d/ProgramData/texlive/2026/bin/windows:$PATH"

# 2) minted v3 必须用绝对路径作为缓存目录
export TEXMF_OUTPUT_DIRECTORY="D:/Ego/trans/Effective Python/latex_source"
export TEXMFOUTPUT="$TEXMF_OUTPUT_DIRECTORY"

# 3) 跑三遍：第 1 遍生成高亮缓存（此时代码块是 <MINTED> 占位）
#            第 2 遍代码真正排版出来、分页趋于稳定
#            第 3 遍目录/书签/交叉引用收敛
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
```

- `-shell-escape` 必须有（minted 要调外部高亮器）。
- 首次编译或 `book/content/**` 改动后，minted 会重高亮 1390 个代码块；
  实测每遍约 2–3 分钟，三遍合计 6–9 分钟。
- 编译结束后建议清理根目录上千个 `*.minted` / `*.listing` 缓存。

### 方式 B：build.bat（一键）

双击 `build.bat` 即可：它会设好 `PATH` 与 `TEXMF_OUTPUT_DIRECTORY`、连跑三遍 xelatex、
检查 `Cannot write file` / `Cannot highlight code` 两类 minted 失败，最后清掉 `*.minted` 与 `*.listing`。

> ⚠️ `build.bat` **不含索引重算**。若正文分页发生了变化（改译文、加删页、换版式），
> 书末索引里写死的页码会整体错位，必须手动补一步：
>
> ```bash
> cd "D:/Ego/trans/Effective Python"
> python work/gen_index.py        # 从 main.pdf 书签重算每条词条的真实页码
> cd latex_source && xelatex -shell-escape -interaction=nonstopmode main.tex   # 再跑两遍
> ```

---

> 如果环境配置遇到问题或者编译失败可以直接到[releases](https://github.com/jnulzl/Effective-Python-3e-CN/releases)下载最新的pdf文件

## 参考

- [bslatkin/effectivepython](https://github.com/bslatkin/effectivepython) —— 书中示例代码（作者官方仓库）
- [effectivepython.com](https://effectivepython.com) —— 作者站点
- [Python 之禅](https://peps.python.org/pep-0020/) —— PEP 20，正文多处引用

---

## 版权

原书文字、代码与封面版权归 Brett Slatkin 与 Pearson Education, Inc. 所有
（Copyright © 2025 Pearson Education, Inc.，封面图 Victoria Moloman/Shutterstock）。
本工程仅为个人学习用途的中文翻译与排版实践，**不用于任何商业目的**，请勿分发成品 PDF。
