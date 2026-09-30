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

## Agent 执行沙箱

- 代码 / 命令执行隔离
- 文件与网络策略
- 权限降级与回收
- 客户端 / 控制面侧 sandbox
- 目录：`domains/03-agent-sandbox`

## 推理服务接入

- API / 鉴权 / 租户 / 限流 / 计量
- 目录：`domains/04-inference-api`

## 集群管理

- GPU 调度与配额
- 拓扑感知放置
- MIG / MPS 隔离
- 节点与故障
- 目录：`domains/05-cluster-management`

## 基础环境

- OS 镜像与节点初始化
- 主机 CPU / 内存 / NUMA
- GPU 驱动 / 主机侧依赖
- 容器基础镜像与业务镜像
- 目录：`domains/06-base-environment`

## 容器运行时与沙箱

- 服务端容器隔离（seccomp / gVisor / Kata 等）
- 镜像快照 / 懒加载
- 启动加速与 warmup
- 目录：`domains/07-container-runtime`

## 高性能存储

- 权重与镜像的读写通道
- NVMe / 并行 FS / 缓存
- KV offload
- 目录：`domains/08-hpc-storage`

## 模型资产

- 权重格式与分片
- tokenizer / processor
- 配置与版本注册
- 编译产物与源权重关系
- 目录：`domains/09-model-artifacts`

## 推理服务编排

- 副本与扩缩
- Prefill / Decode 池与路由
- 前缀 / LoRA 亲和
- 目录：`domains/10-inference-orchestration`

## 推理引擎

- vLLM / SGLang / TensorRT-LLM
- admission / continuous batching
- KV cache / prefix cache
- sampling / 流式输出
- 目录：`domains/11-inference-engine`

## 模型并行与集合通信

- TP / PP / EP / DP
- NCCL
- 目录：`domains/12-model-parallel-comm`

## 高性能网络

- NVLink / NVSwitch
- IB / RoCE / RDMA
- P/D 间 KV transfer 网络
- 目录：`domains/13-hpc-network`

## 算子与量化

- Attention / GEMM / MoE kernel
- FP8 / FP4 / 融合
- 目录：`domains/14-kernels-quantization`

## 设备运行时

- CUDA / ROCm
- CUDA Graph
- 分配器
- 目录：`domains/15-device-runtime`

## GPU 硬件

- SM / Tensor Core
- HBM
- 片间互联能力
- 目录：`domains/16-gpu-hardware`

## 机房与供电散热

- 机柜与供电
- 散热与功耗墙
- 降频与可靠性信号
- 目录：`domains/17-datacenter-facility`

## 横切能力

### 可观测与评测

- 指标 / 日志 / 链路追踪
- 质量评测与回归
- 贯穿 Agent 到引擎，不单独占热路径一层

### Sandbox 的两端

- 客户端：Agent 执行沙箱
- 服务端：容器运行时与沙箱
- 同构能力，落点不同
