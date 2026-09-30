# knowledge-mindmap

个人知识图谱仓库：从 Agent 请求到芯片执行，按一条竖栈沉淀公开技术知识。

## 红线：禁止任何公司信息

**本仓库只允许互联网公开内容。写入、提交或推送任何公司信息，均属严重违规。**

此处「公司信息」涵盖一切非公开或仅限内部使用的材料，不论是否已标密，包括但不限于：

- 内部设计、方案、评审、工单、会议纪要、邮件与聊天记录
- 账号、AK/SK、token、证书、私钥、密码及同类凭证
- 内部 endpoint、域名、IP、机房与网络拓扑
- 客户数据、业务数据、配额、成本等经营数据
- 仅限内网访问的文档、链接、截图与导出文件
- 可据此还原上述内容的脱敏不充分文本

**判断原则：拿不准是否公开，就当禁止。宁可缺内容，不可违规入库。**

误写入时必须立刻停止后续提交，从工作区与 git 历史中清除，确认远程无残留；涉及凭证则立即轮换，并按公司安全流程上报。

## 目录

- `maps/`：竖栈总览导图
- `domains/`：各层正文与公开资料笔记

阅读顺序即目录编号顺序：

| 目录 | 层 |
| --- | --- |
| `domains/01-agent-business` | Agent 业务使用 |
| `domains/02-agent-system` | Agent 系统 |
| `domains/03-inference-api` | 推理服务接入 |
| `domains/04-cluster-management` | 集群管理 |
| `domains/05-base-environment` | 基础环境（OS / 驱动 / 容器镜像 / 主机 CPU） |
| `domains/06-container-startup` | 容器与启动加速 |
| `domains/07-hpc-storage` | 高性能存储 |
| `domains/08-model-artifacts` | 模型资产（权重 / tokenizer / 版本） |
| `domains/09-inference-orchestration` | 推理服务编排 |
| `domains/10-inference-engine` | 推理引擎（含 vLLM） |
| `domains/11-model-parallel-comm` | 模型并行与集合通信 |
| `domains/12-hpc-network` | 高性能网络 |
| `domains/13-kernels-quantization` | 算子与量化 |
| `domains/14-device-runtime` | 设备运行时 |
| `domains/15-gpu-hardware` | GPU 硬件 |
| `domains/16-datacenter-facility` | 机房与供电散热 |

横切：可观测与评测（见导图，不单独占热路径编号）。

## 约定

- 只收互联网公开资料
- 总览按请求下落路径顺着排；集群 / 基础环境 / 容器 / 存储 / 网络 / 机房插在挡住路径的位置
- 需要 Markmap 时自行打开 `maps/` 下文件；改完只重新生成 HTML，不自动打开
