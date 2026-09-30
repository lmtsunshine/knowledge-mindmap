# Agent 到芯片知识领域

> 一条竖栈，从上往下顺着看：一次 Agent 请求如何落到芯片。
> 基础设施插在它真实挡住路径的位置，不单独拆成另一侧。
>
> 红线：仅互联网公开知识，禁止任何公司信息。

## Agent 业务使用

- 场景与验收
- 人机门禁
- 目录：`domains/01-agent-business`

## Agent 系统

- 规划循环与会话
- 工具 / MCP / Skill
- 记忆与检索
- 护栏与评测
- 模型客户端与路由
- 目录：`domains/02-agent-system`

## 推理服务接入

- API / 鉴权 / 租户 / 限流 / 计量
- 目录：`domains/03-inference-api`

## 集群管理

- GPU 调度与配额
- 拓扑感知放置
- 节点与故障
- 目录：`domains/04-cluster-management`

## 基础环境

- OS 镜像与节点初始化
- GPU 驱动 / 主机侧依赖
- 容器基础镜像与业务镜像
- 镜像构建与分发基线
- 目录：`domains/05-base-environment`

## 容器与启动加速

- 镜像快照 / 懒加载
- 容器启动加速
- warmup
- 目录：`domains/06-container-startup`

## 高性能存储

- 权重 / 镜像 / checkpoint 加载
- NVMe / 并行 FS / 缓存
- KV offload
- 目录：`domains/07-hpc-storage`

## 推理服务编排

- 副本与扩缩
- Prefill / Decode 池与路由
- 前缀 / LoRA 亲和
- 目录：`domains/08-inference-orchestration`

## 推理引擎

- vLLM / SGLang / TensorRT-LLM
- admission / continuous batching
- KV cache / prefix cache
- sampling / 流式输出
- 目录：`domains/09-inference-engine`

## 模型并行与集合通信

- TP / PP / EP / DP
- NCCL
- 目录：`domains/10-model-parallel-comm`

## 高性能网络

- NVLink / NVSwitch
- IB / RoCE / RDMA
- P/D 间 KV transfer 网络
- 目录：`domains/11-hpc-network`

## 算子与量化

- Attention / GEMM / MoE kernel
- FP8 / FP4 / 融合
- 目录：`domains/12-kernels-quantization`

## 设备运行时

- CUDA / ROCm
- CUDA Graph
- 分配器
- 目录：`domains/13-device-runtime`

## GPU 硬件

- SM / Tensor Core
- HBM
- 片间互联能力
- 目录：`domains/14-gpu-hardware`
