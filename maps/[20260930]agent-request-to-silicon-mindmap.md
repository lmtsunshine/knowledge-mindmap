# Agent 到芯片知识领域

> 用一次请求的路径发现边界，按领域建图谱，不按步骤写流水账。
>
> 红线：仅互联网公开知识，禁止任何公司信息。

## Agent 侧

### Agent 业务使用

- 场景与验收
- 人机门禁
- 目录：`domains/01-agent-business`

### Agent 系统

- 规划循环与会话
- 工具 / MCP / Skill
- 记忆与检索
- 护栏与评测
- 模型客户端与路由
- 目录：`domains/02-agent-system`

## 模型服务侧

### 推理服务接入

- API / 鉴权 / 租户 / 限流 / 计量
- 目录：`domains/03-inference-api`

### 推理服务编排

- 副本与放置
- 扩缩与升级
- Prefill / Decode 池与路由
- 目录：`domains/04-inference-orchestration`

### 推理引擎

- vLLM
- SGLang
- TensorRT-LLM
- batching / KV / sampling
- 目录：`domains/05-inference-engine`

### 模型并行与集合通信

- TP / PP / EP / DP
- NCCL
- 目录：`domains/06-model-parallel-comm`

### 算子与量化

- Attention / GEMM / MoE kernel
- FP8 / FP4 / 融合
- 目录：`domains/07-kernels-quantization`

### 设备运行时

- CUDA / ROCm
- CUDA Graph
- 分配器
- 目录：`domains/08-device-runtime`

### GPU 硬件

- SM / Tensor Core
- HBM
- NVLink
- 目录：`domains/09-gpu-hardware`

## 基础设施侧

### 容器与启动加速

- 镜像快照 / 懒加载
- 容器启动加速
- warmup
- 目录：`domains/10-container-startup`

### 高性能网络

- IB / RoCE / RDMA
- NVLink / NVSwitch
- KV transfer 网络
- 目录：`domains/11-hpc-network`

### 高性能存储

- 权重 / 镜像 / checkpoint 加载
- NVMe / 并行 FS / 缓存
- KV offload
- 目录：`domains/12-hpc-storage`

### 集群管理

- GPU 集群调度
- 配额与隔离
- 拓扑感知放置
- 节点与故障
- 目录：`domains/13-cluster-management`

## 关键落点

### vLLM 在哪

- 推理引擎

### 集群管理在哪

- 集群管理

### 高性能网络在哪

- 高性能网络
- 也被模型并行、P/D KV 传输依赖

### 高性能存储在哪

- 高性能存储
- 影响冷启动、扩容、切模

### 容器启动加速在哪

- 容器与启动加速
- 位于集群调度之后、引擎稳态服务之前
