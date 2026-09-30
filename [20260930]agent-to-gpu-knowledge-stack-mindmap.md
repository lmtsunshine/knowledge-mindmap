# Agent 到 GPU 知识栈

> Markmap 预览：
> 1. 装扩展 `gera2ld.markmap-vscode`
> 2. 打开本文件 → `Cmd+Shift+P` → **Markmap: Open as markmap**
> 3. 或命令行：`npx markmap-cli "本文件路径" -o /tmp/mindmap.html && open /tmp/mindmap.html`
>
> 分层原则：上层收敛，下层展开；一层一类决策；编排不单独占多层。

## 建设原则

### 两套栈在 L10 交界

- 上：Agent 如何决策与行动
- 下：token 如何算出来

### 一层一页

- 边界与非目标
- 向上接口
- 向下依赖
- 黄金指标

### 因果按层下落

- 上层现象换下层语言
- 禁止跨层混写词条

### 对象模型

- 场景
- Agent
- Session
- ToolCall
- ModelRequest
- Fleet
- Pool Role
- EngineReplica
- BatchStep
- KVBlock
- Kernel
- Device
- Rack

## L12 业务与 Agent 应用

### 决定什么

- 解决什么任务
- Agent 如何组织
- 何时人工介入

### 知识对象

- 场景卡
- 成功标准
- 人机门禁
- 单 Agent / 多 Agent / 工作流作手段而非主干

## L11 工具 · 知识 · 护栏

### 工具与动作

- Tool schema
- MCP / Skill
- 幂等与副作用分级
- 审计

### 记忆与知识

- 工作上下文
- 检索 / RAG
- 长期记忆
- 检索质量优先于向量库选型

### 策略与评测

- 权限与合规
- Guardrail
- Eval 集

## L10 模型服务接入

### 模型选择与路由

- 模型目录与能力标签
- reasoning / 快模型
- 降级与升级

### 服务接入面

- API 与流式
- 多租户
- 限流
- token 计量与账单

### 本层指标

- QPS
- 拒绝率
- 按租户 token
- 模型命中分布

## L9 推理舰队

### 放置与副本

- 模型到节点到 GPU
- 副本数
- 滚动升级

### 弹性与故障

- 按队列 / 利用率扩缩
- 权重加载带宽
- 实例摘除与回退

### 本层指标

- 副本健康
- 扩缩事件
- 放置约束违反

## L8 Prefill / Decode 与路由

### 角色池

- Prefill 算力密集
- Decode 带宽密集
- 两池比例独立扩缩

### 请求路由

- 队列深度
- 前缀亲和
- LoRA 亲和

### 本层指标

- 各角色队列长度
- 亲和命中率
- P 与 D 配比

## L7 引擎调度

### Admission

- 显存水位
- 并发上限
- 优先级拒入

### Continuous batching

- 逐步重排
- token budget
- chunked prefill 保 TPOT

### Host 与 Device 重叠

- EngineCore 独立进程
- Overlap Scheduler
- Speculative Decoding

### 本层指标

- TTFT
- TPOT / ITL
- batch size 分布
- 抢占次数

## L6 KV 与会话状态

### PagedAttention

- block table
- 按需分配
- 降碎片

### 复用

- prefix cache
- copy-on-write
- 系统提示共享

### 显存预算

- 权重
- KV
- activation
- workspace

### 本层指标

- KV 占用
- 碎片率
- prefix hit rate

## L5 模型执行与算子

### Attention

- FlashAttention
- Paged Attention kernel
- MLA 等变体

### 计算主体

- GEMM / MLP
- MoE 路由与专家
- 多模态 encoder

### 数值与融合

- FP16 / BF16 / FP8 / FP4
- KV quant
- kernel fusion

### 本层知识产物

- 显存拆分账
- prefill / decode 算力画像

## L4 模型并行

### 切分方式

- TP 层内切 高频 AllReduce
- PP 按层切 管线气泡
- EP 专家分布 AllToAll
- DP 副本分流扩吞吐

### 选型约束

- 单机多卡优先 TP
- 放不进单机再 PP
- 大 MoE 才上 EP

### 本层指标

- 集合通信带宽与延迟
- 气泡时间

## L3 跨实例状态搬运

### KV transfer

- Prefill 到 Decode
- NIXL / UCX / RDMA
- 同机 CUDA IPC

### Reshard

- 跨 TP / PP 布局重排
- 传输带宽预算

### 本层指标

- KV transfer GB/s
- 传输尾延迟
- decode 等 KV 空转

## L2 设备运行时

### 执行模型

- Stream / Event
- CUDA Graph 捕获 decode
- batch padding 对齐

### 内存

- device / pinned / IPC
- caching allocator
- 长跑碎片 OOM

### 版本基线

- 驱动
- CUDA / ROCm
- Fabric Manager

### 本层指标

- graph hit rate
- SM / DRAM 利用率
- allocator 碎片

## L1 加速器硬件

### 硅片

- SM
- Tensor Core 代际
- 精度能力 FP8 / FP4

### 存储与互联

- HBM 容量与带宽
- NVLink 域
- PCIe only 上限

### 对上层约束语言

- 同容量不同代际吞吐差
- Decode 跟带宽走
- 最大可行 TP

## L0 集群与物理底座

### 组网与调度

- IB / RoCE
- 机柜 / NVSwitch 域
- K8s 或自研调度
- MIG / 独占 / 共享

### 物理与供应

- 功耗墙与降频
- Xid / ECC
- 卡型库存与成本地板

### 可调度原语

- 算力单元
- 带宽单元
- 显存单元
- 拓扑单元
- 并行可行性集合

## 跨层因果

### TTFT 差 TPOT 尚可

- L7 admission / chunked
- L8 Prefill 池不足
- L5 Attention 算力

### TPOT 抖尾延迟差

- L7 大 prefill 抢 decode
- L8 未拆 P/D
- L2 graph miss

### 吞吐低利用率虚高

- L1 HBM 带宽打满
- L4 TP 通信打满

### 显存总不够

- L6 分页碎片
- 前缀未共享
- 精度与并发估错

### 扩卡更慢

- L9 / L8 规划错
- L4 跨节点
- L3 KV 传输成瓶颈

### 成本高 GPU 空

- L10 路由无亲和
- L9 副本过多
- L7 batch 喂不饱

## 角色深度

### Agent / 应用

- 深 L12 到 L11
- 懂 L10 接口
- L9 以下只认慢贵满

### 模型服务

- 深 L10 到 L8
- 懂 L7 到 L6 接口

### 推理引擎

- 深 L8 到 L5
- 懂 L4 到 L2

### 资源与集群

- 深 L9 L8 L4 L3 L1 L0
- 懂 L10 L7 L6 L2 接口
- L12 L11 只懂负载形态与副作用
