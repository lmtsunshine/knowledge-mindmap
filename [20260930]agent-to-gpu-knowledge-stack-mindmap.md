# Agent 到 GPU 知识栈

> Markmap 预览：
> 1. 装扩展 `gera2ld.markmap-vscode`
> 2. 打开本文件 → `Cmd+Shift+P` → **Markmap: Open as markmap**
> 3. 或：`npx markmap-cli "本文件路径" -o /tmp/mindmap.html && open /tmp/mindmap.html`
>
> 红线：仅互联网公开知识，禁止任何公司信息。

## 怎么读这张图

### 上两层是使用侧

- 业务使用 Agent
- Agent 如何落地
- Agent 对外只发出 ModelRequest

### 下面全是服务端

- 按一次请求从外到内穿过的路径排层
- 每层只回答一个问题
- 层与层是上下游，不是并列功能清单

### 服务端路径一句话

1. 请求如何被接纳与计量
2. 跑在哪些引擎实例上
3. 进 Prefill 池还是 Decode 池
4. 单个引擎本步如何组 batch
5. 序列状态 KV 如何占显存
6. 本步计算图跑哪些算子
7. 一个副本内部如何切多卡
8. 若 P/D 分离，KV 如何搬到另一池
9. CUDA 等运行时如何提交执行
10. 落在什么 GPU 硬件上
11. 机器处在什么集群与物理约束里

## 业务使用 Agent

### 本层只回答

- 用 Agent 解决什么业务问题

### 管什么

- 场景与成功标准
- 人机门禁
- 失败与回退预期

### 不管什么

- Agent 内部怎么实现
- 模型在哪台机器上跑

## Agent 如何落地

### 本层只回答

- 怎样把业务诉求变成对模型服务的一次次调用

### 管什么

- Agent 形态：单 Agent / 多 Agent / 工作流
- 工具：Tool schema、MCP、Skill、副作用
- 知识：上下文、检索、长期记忆
- 护栏：权限、Guardrail、Eval
- 模型调用：选模、路由、流式、降级

### 不管什么

- 引擎怎么 batch
- GPU 怎么切分
- 集群怎么调度

### 向下交出的唯一对象

- ModelRequest
- 附带：上下文长度、是否流式、是否工具调用密集

## 服务接入

### 本层只回答

- 这个 ModelRequest 能不能进系统、记谁的账、打到哪类服务

### 管什么

- 鉴权与多租户
- 限流与优先级
- token 计量与计费
- 逻辑模型名到服务入口的映射

### 不管什么

- 后面有几份副本
- Prefill / Decode 怎么拆
- 显存怎么分页

### 向下交出

- 已接纳的推理请求
- 租户与 SLA 标签

## 部署拓扑

### 本层只回答

- 为了提供该模型，世界上跑着哪些引擎实例、各在哪

### 管什么

- 副本集合
- 放置：节点、GPU、亲和与污点
- 扩缩与滚动升级
- 故障摘除

### 不管什么

- 请求进 Prefill 还是 Decode
- 单实例内部如何调度 step
- kernel 怎么写

### 向下交出

- 可路由的 EngineReplica 集合

## 角色路由

### 本层只回答

- 这条请求此刻由哪类角色实例处理

### 管什么

- Prefill 池与 Decode 池的划分
- 池间比例
- 按队列、前缀、LoRA 的路由
- 是否启用 P/D 分离

### 不管什么

- 单引擎里 batch 怎么排
- KV block 怎么分配
- 跨机 KV 字节怎么传（那是更下层）

### 关键约束

- Prefill：算力密集，影响 TTFT
- Decode：带宽密集，影响 TPOT
- 同池混跑会互相干扰；分池要付传输成本

### 向下交出

- 打到具体角色实例的请求

## 引擎批调度

### 本层只回答

- 在一个引擎实例内，当前 step 让哪些序列一起算

### 管什么

- Admission：显存与并发门槛
- Continuous batching：逐步重排
- Chunked prefill：长提示切块，减少饿死 decode
- Speculative decoding：草稿与校验
- Host / Device 重叠：减少 CPU 卡住 GPU

### 不管什么

- KV 物理布局细节可下沉，但调度要消费其容量信号
- 不算具体 Attention kernel
- 不管多卡集合通信实现

### 本层指标

- TTFT
- TPOT
- 有效 batch size
- 抢占与拒绝次数

### 向下交出

- 本 step 的 batched forward 任务

## KV 管理

### 本层只回答

- 序列的注意力状态在显存里如何存放、复用、回收

### 管什么

- PagedAttention / block table
- 按需分配，降低碎片
- prefix cache 与 copy-on-write
- 抢占时释放与重建策略
- 权重 / KV / activation / workspace 的预算拆分

### 不管什么

- 本 step 选哪些请求进 batch
- Attention 用哪种 kernel 实现
- 跨实例如何传 KV

### 本层指标

- KV 占用
- 碎片率
- prefix hit rate

### 向下交出

- 可被算子寻址的 KV 视图

## 计算图与算子

### 本层只回答

- 一次 forward 具体算哪些层、用哪些内核与数值精度

### 管什么

- Transformer / MoE / 多模态结构
- Attention、GEMM、专家路由等算子
- 量化：FP16 / BF16 / FP8 / FP4、KV quant
- kernel fusion 与编译路径

### 不管什么

- 请求级调度
- 集群放置
- CUDA Graph 捕获策略可与运行时交界，但算子定义在本层

### 本层产物

- 显存拆分账
- Prefill / Decode 各自瓶颈画像

### 向下交出

- 需要在设备上执行的 kernel 序列
- 若多卡：带并行切分意图的计算图

## 卡间并行

### 本层只回答

- 一个引擎副本内部，模型如何切到多张 GPU 上一起算

### 管什么

- TP：层内切，高频 AllReduce
- PP：按层切，关注气泡
- EP：专家并行，AllToAll
- DP：多副本分流，扩吞吐

### 不管什么

- Prefill 池与 Decode 池之间的 KV 搬运
- 集群里有多少副本
- HBM 物理规格本身

### 选型直觉

- 单机多卡先 TP
- 单机放不下再 PP
- 大 MoE 才上 EP

### 向下交出

- 每张卡上的局部计算与集合通信计划

## 实例间传输

### 本层只回答

- 当 Prefill 与 Decode 不在同一实例时，状态如何搬走

### 管什么

- KV transfer：NIXL / UCX / RDMA / 同机 IPC
- 跨 TP/PP 布局的 reshard
- 传输与计算重叠

### 不管什么

- 不决定要不要分 P/D（那是角色路由）
- 不管理单实例内 block 分配器
- 不是 TP 的 AllReduce

### 何时存在

- 仅 P/D 分离或同类跨实例状态交接时
- 同实例混跑则本层可空

### 本层指标

- 传输带宽
- 传输尾延迟
- Decode 等 KV 的空转

## 设备运行时

### 本层只回答

- kernel 如何被设备执行、内存如何被运行时管理

### 管什么

- CUDA / ROCm Stream 与 Event
- CUDA Graph 捕获与回放
- caching allocator 与碎片
- 驱动与运行时版本矩阵

### 不管什么

- 模型有哪些层
- 集群网络拓扑
- 业务租户是谁

### 本层指标

- graph hit rate
- SM / DRAM 利用率
- allocator 碎片与 OOM

## GPU 硬件

### 本层只回答

- 单卡 / 单机加速器提供什么物理能力上限

### 管什么

- SM 与 Tensor Core 代际
- 支持的精度
- HBM 容量与带宽
- NVLink / PCIe 域

### 不管什么

- 软件如何 batch
- 机房如何供电组网

### 对上层的约束语言

- 算力天花板
- 带宽天花板
- 单机最大可行 TP

## 集群与物理底座

### 本层只回答

- 这些 GPU 机器如何组网、调度、供电，以及供应是否跟得上

### 管什么

- IB / RoCE、机柜、NVSwitch 域
- 调度与隔离：独占、共享、MIG
- 功耗墙、降频、Xid、ECC
- 库存与成本地板

### 不管什么

- 单个 ModelRequest 的语义
- 某个 Attention kernel 的实现

### 向上可暴露的调度原语

- 算力单元
- 带宽单元
- 显存单元
- 拓扑单元
- 允许的并行组合

## 层间对照

### 容易混的两对

#### 部署拓扑 vs 角色路由

- 拓扑：有哪些实例
- 路由：这条请求进哪个角色实例

#### 卡间并行 vs 实例间传输

- 卡间并行：一个副本内多卡算同一个 forward
- 实例间传输：不同副本之间搬 KV

### 可选层

- 角色路由中的 P/D 分离：可选
- 实例间传输：随 P/D 分离出现

## 排障从哪一层看

### TTFT 差

- 服务接入排队
- 角色路由 Prefill 不足
- 引擎批调度 admission / chunked
- 计算图 Prefill 算力

### TPOT 差或抖动

- 角色路由未拆 P/D 且混跑干扰
- 引擎批调度被大 Prefill 打断
- KV 碎片导致并发上不去
- GPU 硬件带宽打满
- 设备运行时 graph miss

### 扩了卡更慢

- 部署拓扑并行规划错误
- 卡间并行跨节点通信过重
- 实例间传输成为瓶颈

### GPU 空但业务仍慢

- 服务接入或角色路由无亲和，缓存打不上
- 部署拓扑副本过多、单副本喂不饱
- Agent 侧请求形态过于碎片化
