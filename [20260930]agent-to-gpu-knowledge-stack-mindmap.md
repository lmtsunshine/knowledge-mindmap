# Agent 到 GPU 知识栈

> Markmap 预览：
> 1. 装扩展 `gera2ld.markmap-vscode`
> 2. 打开本文件 → `Cmd+Shift+P` → **Markmap: Open as markmap**
> 3. 或命令行：`npx markmap-cli "本文件路径" -o /tmp/mindmap.html && open /tmp/mindmap.html`
>
> 分层原则：业务与 Agent 落地只占两层；工具与模型接入并入 Agent；服务端从「模型如何被提供」起细拆。
>
> 红线：仅互联网公开知识，禁止任何公司信息。

## 建设原则

### 分界

- 左：谁用 Agent、Agent 如何落地
- 右：模型服务如何在服务端被提供

### 一层一页

- 边界与非目标
- 向上接口
- 向下依赖
- 黄金指标

### 因果按层下落

- 上层现象换下层语言
- 禁止跨层混写词条

## 业务使用 Agent

### 决定什么

- 解决什么任务
- 成功标准是什么
- 何时必须人介入

### 知识对象

- 场景卡
- 验收标准
- 人机门禁
- 失败与回退预期

### 非目标

- 不展开编排框架细节
- 不展开推理与 GPU 实现

## Agent 如何落地

### Agent 形态

- 单 Agent
- 多 Agent
- 固定工作流
- 形态服务于场景，不是知识主干

### 工具作为 Agent 能力的一部分

- Tool schema
- MCP / Skill
- 幂等与副作用分级
- 调用审计

### 知识与记忆作为 Agent 能力的一部分

- 工作上下文
- 检索 / RAG
- 长期记忆
- 检索质量优先于向量库选型

### 护栏与评测作为 Agent 能力的一部分

- 权限与合规
- Guardrail
- Eval 集

### 模型调用作为 Agent 能力的一部分

- 模型选择与路由
- reasoning / 快模型
- 降级与升级
- API / 流式 / 会话语义
- 对服务端只表现为一次 ModelRequest

### 本层对外接口

- 发出的是模型请求与工具副作用
- 不拥有 GPU forward
- 不拥有舰队拓扑

## 模型服务如何提供

### 请求进入服务端之后

- 多租户与限流
- 计量计费
- 逻辑模型到物理舰队的映射

### 推理舰队

#### 放置与副本

- 模型到节点到 GPU
- 副本数
- 滚动升级

#### 弹性与故障

- 按队列 / 利用率扩缩
- 权重加载带宽
- 实例摘除与回退

#### 本层指标

- 副本健康
- 扩缩事件
- 放置约束违反

### Prefill / Decode 与路由

#### 角色池

- Prefill 算力密集
- Decode 带宽密集
- 两池比例独立扩缩

#### 请求路由

- 队列深度
- 前缀亲和
- LoRA 亲和

#### 本层指标

- 各角色队列长度
- 亲和命中率
- P 与 D 配比

### 引擎调度

#### Admission

- 显存水位
- 并发上限
- 优先级拒入

#### Continuous batching

- 逐步重排
- token budget
- chunked prefill 保 TPOT

#### Host 与 Device 重叠

- EngineCore 独立进程
- Overlap Scheduler
- Speculative Decoding

#### 本层指标

- TTFT
- TPOT / ITL
- batch size 分布
- 抢占次数

### KV 与会话状态

#### PagedAttention

- block table
- 按需分配
- 降碎片

#### 复用

- prefix cache
- copy-on-write
- 系统提示共享

#### 显存预算

- 权重
- KV
- activation
- workspace

#### 本层指标

- KV 占用
- 碎片率
- prefix hit rate

### 模型执行与算子

#### Attention

- FlashAttention
- Paged Attention kernel
- MLA 等变体

#### 计算主体

- GEMM / MLP
- MoE 路由与专家
- 多模态 encoder

#### 数值与融合

- FP16 / BF16 / FP8 / FP4
- KV quant
- kernel fusion

#### 本层知识产物

- 显存拆分账
- prefill / decode 算力画像

### 模型并行

#### 切分方式

- TP 层内切 高频 AllReduce
- PP 按层切 管线气泡
- EP 专家分布 AllToAll
- DP 副本分流扩吞吐

#### 选型约束

- 单机多卡优先 TP
- 放不进单机再 PP
- 大 MoE 才上 EP

#### 本层指标

- 集合通信带宽与延迟
- 气泡时间

### 跨实例状态搬运

#### KV transfer

- Prefill 到 Decode
- NIXL / UCX / RDMA
- 同机 CUDA IPC

#### Reshard

- 跨 TP / PP 布局重排
- 传输带宽预算

#### 本层指标

- KV transfer GB/s
- 传输尾延迟
- decode 等 KV 空转

### 设备运行时

#### 执行模型

- Stream / Event
- CUDA Graph 捕获 decode
- batch padding 对齐

#### 内存

- device / pinned / IPC
- caching allocator
- 长跑碎片 OOM

#### 版本基线

- 驱动
- CUDA / ROCm
- Fabric Manager

#### 本层指标

- graph hit rate
- SM / DRAM 利用率
- allocator 碎片

### 加速器硬件

#### 硅片

- SM
- Tensor Core 代际
- 精度能力 FP8 / FP4

#### 存储与互联

- HBM 容量与带宽
- NVLink 域
- PCIe only 上限

#### 对上层约束语言

- 同容量不同代际吞吐差
- Decode 跟带宽走
- 最大可行 TP

### 集群与物理底座

#### 组网与调度

- IB / RoCE
- 机柜 / NVSwitch 域
- K8s 或自研调度
- MIG / 独占 / 共享

#### 物理与供应

- 功耗墙与降频
- Xid / ECC
- 卡型库存与成本地板

#### 可调度原语

- 算力单元
- 带宽单元
- 显存单元
- 拓扑单元
- 并行可行性集合

## 跨层因果

### TTFT 差 TPOT 尚可

- 引擎 admission / chunked
- Prefill 池不足
- Attention 算力

### TPOT 抖尾延迟差

- 大 prefill 抢 decode
- 未拆 P/D
- CUDA Graph miss

### 吞吐低利用率虚高

- HBM 带宽打满
- TP 通信打满

### 显存总不够

- KV 分页碎片
- 前缀未共享
- 精度与并发估错

### 扩卡更慢

- 舰队 / P-D 规划错
- 跨节点并行
- KV 传输成瓶颈

### 成本高 GPU 空

- Agent 侧路由无亲和
- 副本过多
- batch 喂不饱

## 角色深度

### 业务与 Agent 开发

- 深：业务使用 Agent、Agent 落地
- 对服务端：只认慢 / 贵 / 满与请求语义

### 模型服务

- 深：请求接入到 P/D 与舰队
- 懂：引擎调度与 KV 接口

### 推理引擎

- 深：调度、KV、算子、并行
- 懂：运行时与硬件约束

### 资源与集群

- 深：舰队、P/D、并行、KV 传输、硬件、集群底座
- 懂：引擎调度与 KV 预算语义
- Agent 侧：只懂负载形态与工具副作用
