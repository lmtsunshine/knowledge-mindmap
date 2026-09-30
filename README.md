# knowledge-mindmap

个人知识图谱仓库，用于整理从 Agent 应用到 GPU / 集群底座的公开技术知识结构。

## 内容范围

- 来源限于互联网公开资料、开源项目文档、公开论文与公开技术文章
- 产出形式以 Markmap 思维导图等可版本化文本为主
- 目标是建立可检索、可迭代的个人知识分层，而非公司内部方案归档

## 禁止上传

本仓库**禁止**写入或提交任何公司敏感信息与内部材料，包括但不限于：

- 未公开的内部设计、评审、工单、会议纪要
- 账号、AK/SK、token、证书、私钥、密码
- 内部 endpoint、域名、机房/网络拓扑细节
- 客户数据、业务数据、配额与成本等经营数据
- 仅限内网访问的文档链接与截图

若误写入，立即从工作区删除，检查 git 历史，必要时轮换相关凭证。

## 使用方式

思维导图为 Markdown 源文件，可用 Markmap 预览：

1. 安装扩展 `gera2ld.markmap-vscode`
2. 打开 `*.md` → `Cmd+Shift+P` → **Markmap: Open as markmap**
3. 或：`npx markmap-cli "文件路径" -o /tmp/mindmap.html && open /tmp/mindmap.html`
