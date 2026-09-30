# 推理引擎

单实例（或单副本）如何做推理。**vLLM、SGLang、TensorRT-LLM、llama.cpp server 等落在本层。**

子题：
- admission 与 continuous batching
- PagedAttention / KV cache / prefix cache
- chunked prefill、speculative decoding、采样与流式输出
- OpenAI-compatible server 实现细节
