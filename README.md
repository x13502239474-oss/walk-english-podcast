# 初中英语散步听

一个为「边走边听」设计的英语听力网页应用（PWA），手机浏览器打开即可用，可添加到主屏幕、离线缓存。

## 两个板块

### 1. 单词播客（32 集，约 8.7 小时）

内容来自新东方《初中英语词汇词根+联想记忆法》，共 **1812 个词条**，按原书 32 个 Word List 分集，每集约 16 分钟。

每集的节奏是：

| 环节 | 作用 |
| --- | --- |
| 单词慢速朗读两遍 | 听清发音与音节 |
| 中文释义 + 例句译文 | 立刻建立词义 |
| 英文例句 | 在语境中巩固 |
| 2.2 秒静默 | 留白做主动回想 |

### 2. 英语节目（12 集，约 92 分钟）

题材取自初中英语课标 24 个话题与中考高频情景，全部为初中词汇难度，每集 7–8 分钟。

1. 问候与介绍　2. 学校生活　3. 我的日常　4. 点餐与饮食
5. 购物与价格　6. 天气与季节　7. 兴趣与运动　8. 问路与交通
9. 健康与就医　10. 节日与假期　11. 旅行与计划　12. 动物与环境

单集结构：中文开场 → 情景对话（男女双声）→ 用法讲解 → 独白 → 例句领读 → 慢速跟读 → 10 个重点表达 → 口语小任务。

## 功能

- 进度条可拖动跳转，带时间气泡
- 0.8×–1.5× 倍速、连播、10/30/45 分钟定时关闭
- 锁屏后台播放，耳机线控切上一句／下一句
- 当前单词／当前句的中英文实时显示
- 播放进度自动记忆
- 单集离线下载，无网络也能听

## 本地运行

```bash
cd podcast
python -m http.server 8765
# 打开 http://localhost:8765
```

直接双击 `index.html` 也能运行（数据已内联为 `data/data.js`）。

## 目录结构

```
podcast/
├── index.html            应用本体（单文件，含全部逻辑）
├── sw.js                 Service Worker，负责离线缓存
├── manifest.webmanifest  PWA 配置
├── icon.svg              图标
├── data/
│   ├── data.js           内联数据（供 file:// 直接打开）
│   ├── words.json        单词数据（1812 词）
│   ├── episodes.json     单词板块分集元数据
│   └── talks.json        节目板块分集元数据与字幕
└── audio/
    ├── ep01..ep32.mp3    单词播客音频
    └── talk01..talk12.mp3 英语节目音频
```

## 重新生成

音频由微软 Edge TTS 合成（英文 `en-US-AvaNeural` / `en-US-AndrewMultilingualNeural`，中文 `zh-CN-XiaoxiaoNeural`）。

```bash
pip install edge-tts
python parse_words.py     # 从 epub 提取单词，生成 data/words.json
python build_podcast.py   # 生成单词板块音频
python build_talks.py     # 生成节目板块音频
python make_datajs.py     # 生成离线数据与元数据
```

需要 ffmpeg 参与音频拼接。改成英音只需把脚本里的 `EN_A` 换成 `en-GB-SoniaNeural` 后重跑。

## 说明

音源文本来自第三方出版物，仅供个人学习使用，请勿二次分发。
