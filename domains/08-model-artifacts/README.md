# 模型资产

推理真正加载的不是「一块磁盘」，而是一组版本化资产：权重文件、tokenizer、config、processor、可能的 LoRA / draft 模型，以及注册与版本选择。

高性能存储负责「怎么存、怎么快读」；本层负责「读进来的是什么、版本如何对齐」。

子题：
- 权重格式与分片（safetensors / checkpoint）
- tokenizer 与多模态 processor
- 模型配置与结构元数据
- 模型注册、版本、回滚
- 编译产物（如 TensorRT engine）与源权重的关系
